//
//  MockAsyncAction.h
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/16/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IAction.h"

@interface MockAsyncAction : NSObject <IAction>

@property (nonatomic, strong, readonly) NSString* identifier;
@property (nonatomic, strong) NSMutableDictionary* parameters;
@property (nonatomic, assign) EEXECUTION_TYPE type;

@end
