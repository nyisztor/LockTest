//
//  NYKLockTest.h
//  LockPerformance
//
//  Created by Nyisztor Karoly on 2014.05.26..
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NYKLockTest : NSObject

#pragma mark - Benchmark Setup and Execution
/**
 *  Sets how many times the benchmarked code shall be executed
 *  Defaults to 10
 *
 *  @param count_in
 */
+(void) setExecutionCount:(NSUInteger)count_in;

/**
 *  Runs all benchmark tests
 *  Results will be displayed in the console
 */
+(void) runSuite;

#pragma mark - Benchmark Methods

/**
 *  Tests @synchronized performance
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testSynchronizedPerformance:(NSUInteger)execCount_in;

/**
 *  Tests NSLock performance
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testNSLockPerformance:(NSUInteger)execCount_in;

/**
 *  Tests NSRecursiveLock performance
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testNSRecursiveLockPerformance:(NSUInteger)execCount_in;

/**
 *  Tests dispatch_sync performance
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testDispatchSyncPerformance:(NSUInteger)execCount_in;

/**
 *  Tests dispatch_async performance
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testDispatchAsyncPerformance:(NSUInteger)execCount_in;

/**
 *  Tests pthread_mutex_t performance
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testPThreadMutexPerformance:(NSUInteger)execCount_in;

/**
 *  Tests performance of NSLock with added exception handling
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testNSLockWithExceptionHandlingPerformance:(NSUInteger)execCount_in;

/**
 *  Tests performance of NSRecursiveLock with added exception handling
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testNSRecursiveLockWithExceptionHandlingPerformance:(NSUInteger)execCount_in;

/**
 *  Tests performance of pthread_mutex_t with added exception handling
 *
 *  @param execCount_in number of times to execute the benchmark code
 */
+(void) testPThreadMutexWithExceptionHandlingPerformance:(NSUInteger)execCount_in;

@end
