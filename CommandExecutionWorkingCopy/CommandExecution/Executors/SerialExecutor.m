//
//  SerialExecutor.m
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "SerialExecutor.h"
#import "IAction.h"
#import "NYKActionGroup.h"
#import "NYKDummyAction.h"
#import "QueueProvider.h"

const char* SERIAL_QUEUE_LABEL = "com.gammaproject.serialQueue";

@interface SerialExecutor()
@property(nonatomic, retain) dispatch_queue_t serialQueue;
@property(nonatomic, retain) dispatch_group_t queuedGroup;
@end

@implementation SerialExecutor

-(id) init
{
    self = [super init];
    if( self )
    {
        self.serialQueue = dispatch_queue_create( SERIAL_QUEUE_LABEL, NULL);
        self.queuedGroup = dispatch_group_create();
    }
    
    return self;
}

-(void) execute:(id<IAction>)command
{
    dispatch_sync(self.serialQueue, ^{
        [command execute];
    });
}

-(void) executeCommands:(NSArray *)commands
{
    for(id<IAction> command in commands )
    {
        // parallel action (group) nested in a serial one shall complete before starting the next command in the serial queue
        if( command.type == PARALLEL )
        {
            [command execute];
        }
        else
        {
            // !!! Calls to dispatch_sync() targeting the current queue will result in deadlock
            dispatch_sync(self.serialQueue, ^{
                [command execute];
            });
        }
    }
}

@end
