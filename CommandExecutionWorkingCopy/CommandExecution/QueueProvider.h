//
//  QueueProvider.h
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/16/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef GLOBAL_SERIAL_QUEUE
#define GLOBAL_SERIAL_QUEUE [QueueProvider sharedInstance].serialQueue
#endif

#ifndef GLOBAL_QUEUED_GROUP
#define GLOBAL_QUEUED_GROUP [QueueProvider sharedInstance].queuedGroup
#endif


@interface QueueProvider : NSObject

/**
 *  Singleton instance
 *
 *  @return <#return value description#>
 */
+(QueueProvider*) sharedInstance;


@property(nonatomic, strong, readonly) dispatch_queue_t serialQueue;
@property(nonatomic, strong, readonly) dispatch_group_t queuedGroup;


@end
