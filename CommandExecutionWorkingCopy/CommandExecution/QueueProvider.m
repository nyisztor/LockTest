//
//  QueueProvider.m
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/16/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "QueueProvider.h"

const char* GLOBAL_SERIAL_QUEUE_LABEL = "com.gammaproject.serialQueue";

@interface QueueProvider()

@property(nonatomic, strong) dispatch_queue_t serialQueue;
@property(nonatomic, strong) dispatch_group_t queuedGroup;

@end

@implementation QueueProvider



/**
 *  Singleton instance
 *
 *  @return <#return value description#>
 */
+(QueueProvider*) sharedInstance
{
    static QueueProvider* sInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sInstance = [[QueueProvider alloc] init];
        
        sInstance.serialQueue = dispatch_queue_create( GLOBAL_SERIAL_QUEUE_LABEL, NULL);
        sInstance.queuedGroup = dispatch_group_create();

    });
    
    return sInstance;
}

@end
