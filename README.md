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
The numbers below reflect the averaged results of several test runs executed on an iPhone 5s device
// iPhone 5s
@synchronized 	NSLock	NSRecursiveLock	dispatch_sync		pthread_mutex_t
520				262		263				69				202

It turns out that @synchronized is the slowest, whilst dispatch_sync is surprisingly fast. NSLock and NSRecursiveLock produced almost the same results, whilst pthread_mutex_t came in the second.


Measurements are performed using dispatch_benchmark, which is an easy to use, block-based API. 
Unfortunately it is not public (although documented), so *do not use dispatch_benchmark in productive code*.
See also: http://nshipster.com/benchmarking/

