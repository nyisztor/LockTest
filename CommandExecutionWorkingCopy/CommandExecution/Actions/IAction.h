//
//  IAction.h
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

/**
 *  Defines possible execution types
 */
typedef NS_ENUM(NSInteger, EEXECUTION_TYPE)
{
    /**
     *  <#Description#>
     */
    SERIAL,
    /**
     *  <#Description#>
     */
    PARALLEL,
    /**
     *  <#Description#>
     */
    UNKNOWN = 0xffff
};

#import <Foundation/Foundation.h>

/**
 *  Decalres the command interface
 */
@protocol IAction <NSObject>

@required

/**
 *  Custom intializer, expects a unique ID to be passed
 *
 *  @param id_in unique command ID
 *
 *  @return command instance
 */
-(id) initWithIdentifier:(NSString*)id_in;

-(void) execute;    ///< fires the request

@property (nonatomic, strong, readonly) NSString* identifier;   ///< unique ID
@property (nonatomic, strong) NSMutableDictionary* parameters;  ///< custom parameters
@property (nonatomic, assign) EEXECUTION_TYPE type;             ///< execution type

@end
