LockTest
========

Cocoa offers us several ways to implement locking strategies.
Performance is one of the aspects that should be also considered before chosing one way or teh other.

The app performs benchmark tests on various locking patterns:
- @synchronized keyword
- NSLock
- NSRecursiveLock
- dispatch_sync
- pthread_mutex_t

The app displays the results in the console.
The numbers below reflect the averaged results of several test runs executed on an iPhone 5s device. Note that each benchmark test performed 100 lock/unlock cycles.
1. 69 ns -> dispatch_sync 
2. 202 ns -> pthread_mutex_t
3. 262 ns -> NSLock
4. 263 ns -> NSRecursiveLock
5. 520 ns -> @synchronized

It turns out that @synchronized is the slowest, whilst dispatch_sync is blazingly fast. NSLock and NSRecursiveLock show no comparable difference, whilst pthread_mutex_t came in the second.


Measurements are performed using dispatch_benchmark, which is an easy to use, block-based API. 
Unfortunately it is not public (although documented), so *do not use dispatch_benchmark in productive code*.
See also: http://nshipster.com/benchmarking/
