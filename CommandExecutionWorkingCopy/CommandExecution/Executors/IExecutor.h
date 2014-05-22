//
//  IExecutor.h
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAction.h"

/**
 *  Declares the executor methods
 */
@protocol IExecutor <NSObject>

/**
 *  Executes a single action
 *
 *  @param command action to be executed
 */
-(void) execute:(id<IAction>) command;

/**
 *  Executes the actions from the passed in array
 *
 *  @param commands array< id<IAction> >
 */
-(void) executeCommands:(NSArray*) commands;

@end
