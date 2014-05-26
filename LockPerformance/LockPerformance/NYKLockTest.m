//
//  NYKLockTest.m
//  LockPerformance
//
//  Created by Nyisztor Karoly on 2014.05.26..
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "NYKLockTest.h"
#import <pthread.h>
/**
 *  Declares the dispatch_benchmark function
 *  Although it is part of libdispatch (GCD), it is not a public function
 *  that's why we must declare it here
 *
 *  @param count      determines how many times the block gets executed
 *  @param ^blockvoid block to be executed
 *
 *  @return block execution time in nanoseconds (10^(-9) s)
 */
#warning dispatch_benchmark is a *private* libdispatch function, use it only during development\
Leaving calls to dispatch_benchmark in productive code will most probably lead to your app being rejected!

extern uint64_t dispatch_benchmark(size_t count, void (^block)(void));

static NSUInteger S_EXEC_COUNT = 10;
static BOOL s_DisplayResults;
static NSLock* s_Lock;
static NSRecursiveLock* s_RecursiveLock;
static pthread_mutex_t s_Mutex;
static dispatch_queue_t s_GlobalQueue;

@implementation NYKLockTest

#pragma mark - Benchmark Setup and Execution

/**
 *  Initializes the locks and mutextes
 *  @remark Initializations extracted in order to keep benchmark methods clean
 */
+(void) initialize
{
    s_Lock = [NSLock new];
    s_RecursiveLock = [NSRecursiveLock new];
    pthread_mutex_init ( &s_Mutex, NULL);
    s_GlobalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}
/**
 *  Sets how many times the benchmarked code shall be executed
 *  Defaults to 10
 *
 *  @param count_in
 */
+(void) setExecutionCount:(NSUInteger)count_in;
{
    S_EXEC_COUNT = count_in;
}

/**
 *  Runs all benchmark tests
 *  Results will be displayed in the console
 */
+(void) runSuite;
{
    [self warmUp];
    
    // Now let's run our performance tests
    NSLog( @"%@", @"\nBenchmark test suite start\n--------------------------" );
    s_DisplayResults = YES;
    [NYKLockTest testSynchronizedPerformance:S_EXEC_COUNT];
    [NYKLockTest testNSLockPerformance:S_EXEC_COUNT];
    [NYKLockTest testNSRecursiveLockPerformance:S_EXEC_COUNT];
    [NYKLockTest testDispatchSyncPerformance:S_EXEC_COUNT];
//    [NYKLockTest testDispatchAsyncPerformance:S_EXEC_COUNT];
    [NYKLockTest testPThreadMutexPerformance:S_EXEC_COUNT];
//    [NYKLockTest testNSLockWithExceptionHandlingPerformance:S_EXEC_COUNT];
//    [NYKLockTest testNSRecursiveLockWithExceptionHandlingPerformance:S_EXEC_COUNT];
//    [NYKLockTest testPThreadMutexWithExceptionHandlingPerformance:S_EXEC_COUNT];
    NSLog( @"%@", @"\nBenchmark test suite end\n--------------------------" );
}

#pragma mark - Benchmark Methods

/**
 *  Tests @synchronized performance
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testSynchronizedPerformance:(NSUInteger)execCount_in
{
    uint64_t t = dispatch_benchmark(execCount_in, ^{
        @synchronized( self )
        {
            [NYKLockTest dummy];
        }
    });
    
    if( s_DisplayResults )
    {
        NSLog(@"@synchronized Avg. Runtime: %llu ns", t);
    }
}

/**
 *  Tests NSLock performance
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testNSLockPerformance:(NSUInteger)execCount_in
{
    uint64_t t = dispatch_benchmark(execCount_in, ^{
        [s_Lock lock];
        [NYKLockTest dummy];
        [s_Lock unlock];
    });

    if( s_DisplayResults )
    {
        NSLog(@"NSLock Avg. Runtime: %llu ns", t);
    }
}

/**
 *  Tests NSRecursiveLock performance
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testNSRecursiveLockPerformance:(NSUInteger)execCount_in
{
    uint64_t t = dispatch_benchmark(execCount_in, ^{
        [s_RecursiveLock lock];
        [NYKLockTest dummy];
        [s_RecursiveLock unlock];
    });
    
    if( s_DisplayResults )
    {
        NSLog(@"NSRecursiveLock Avg. Runtime: %llu ns", t);
    }
}

/**
 *  Tests dispatch_sync performance
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testDispatchSyncPerformance:(NSUInteger)execCount_in
{
    uint64_t t = dispatch_benchmark(execCount_in, ^{
        dispatch_sync(s_GlobalQueue, ^{
            [NYKLockTest dummy];
        });
    });
    
    if( s_DisplayResults )
    {
        NSLog(@"dispatch_sync Avg. Runtime: %llu ns", t);
    }
}

/**
 *  Tests dispatch_async performance
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testDispatchAsyncPerformance:(NSUInteger)execCount_in
{
    uint64_t t = dispatch_benchmark(execCount_in, ^{
        dispatch_async(s_GlobalQueue, ^{
            [NYKLockTest dummy];
        });
    });
    
    if( s_DisplayResults )
    {
        NSLog(@"dispatch_async Avg. Runtime: %llu ns", t);
    }
}


/**
 *  Tests pthread_mutex_t performance
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testPThreadMutexPerformance:(NSUInteger)execCount_in
{
    uint64_t t = dispatch_benchmark(execCount_in, ^{
        pthread_mutex_lock( (pthread_mutex_t*)&s_Mutex );
        [NYKLockTest dummy];
        pthread_mutex_unlock( (pthread_mutex_t*)&s_Mutex );
    });
    
    if( s_DisplayResults )
    {
        NSLog(@"pthread_mutex_t Avg. Runtime: %llu ns", t);
    }
}

/**
 *  Tests performance of NSLock with added exception handling
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testNSLockWithExceptionHandlingPerformance:(NSUInteger)execCount_in
{
    uint64_t t = dispatch_benchmark(execCount_in, ^{
        [s_Lock lock];
        @try
        {
            [NYKLockTest dummy];
        }
        @catch (NSException *exception)
        {
            // dummy
            [exception.description length];
        }
        [s_Lock unlock];
    });
    
    if( s_DisplayResults )
    {
        NSLog(@"NSLock with exception handling Avg. Runtime: %llu ns", t);
    }
}

/**
 *  Tests performance of NSRecursiveLock with added exception handling
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testNSRecursiveLockWithExceptionHandlingPerformance:(NSUInteger)execCount_in
{
    uint64_t t = dispatch_benchmark(execCount_in, ^{
        [s_RecursiveLock lock];

        @try
        {
            [NYKLockTest dummy];
        }
        @catch (NSException *exception)
        {
            // dummy
            [exception.description length];
        }

        [s_RecursiveLock unlock];
    });

    if( s_DisplayResults )
    {
        NSLog(@"NSRecursiveLock with exception handling Avg. Runtime: %llu ns", t);
    }
}

/**
 *  Tests performance of pthread_mutex_t with added exception handling
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testPThreadMutexWithExceptionHandlingPerformance:(NSUInteger)execCount_in
{
    uint64_t t = dispatch_benchmark(execCount_in, ^{
        pthread_mutex_lock( (pthread_mutex_t*)&s_Mutex );
        @try
        {
            [NYKLockTest dummy];
        }
        @catch (NSException *exception)
        {
            // dummy
            [exception.description length];
        }

        pthread_mutex_unlock( (pthread_mutex_t*)&s_Mutex );
    });
    
    if( s_DisplayResults )
    {
        NSLog(@"pthread_mutex_t with exception handling Avg. Runtime: %llu ns", t);
    }
}

#pragma mark - Helper Methods
/**
 *  Does nothing, intended to prevent compiler optimization for nop code
 *
 *  @return <#return value description#>
 */
+(NSUInteger) dummy
{
    NSString* str = @"Dummy";
    return [str length];
}

/**
 *  Performs some initial test rounds to warm up the engine
 *  This is required due to get real results - comment out to see the results without this step
 *  Results won't show up in the console
 */
+(void) warmUp
{
    s_DisplayResults = NO;
    
    NSUInteger testRunCount = 10;
    [NYKLockTest testSynchronizedPerformance:testRunCount];
    [NYKLockTest testNSLockPerformance:testRunCount];
    [NYKLockTest testNSRecursiveLockPerformance:testRunCount];
    [NYKLockTest testDispatchSyncPerformance:testRunCount];
//    [NYKLockTest testDispatchAsyncPerformance:testRunCount];
    [NYKLockTest testPThreadMutexPerformance:testRunCount];
//    [NYKLockTest testNSLockWithExceptionHandlingPerformance:testRunCount];
//    [NYKLockTest testNSRecursiveLockWithExceptionHandlingPerformance:testRunCount];
//    [NYKLockTest testPThreadMutexWithExceptionHandlingPerformance:testRunCount];
}

@end
