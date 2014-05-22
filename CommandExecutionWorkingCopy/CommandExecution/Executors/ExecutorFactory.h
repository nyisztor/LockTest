//
//  ExecutorFactory.h
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IExecutor.h"

/**
 *  Creates executors of provided type
 */
@interface ExecutorFactory : NSObject

/**
 *  Creates the singleton factory instance
 *
 *  @return Shared instance
 */
+(ExecutorFactory*) sharedInstance;

-(id<IExecutor>) makeExecutor:(EEXECUTION_TYPE)type;

@end
