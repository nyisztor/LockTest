//
//  NYKDummyAction.m
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "NYKDummyAction.h"

@interface NYKDummyAction()

@property(nonatomic, strong) NSString* identifier;

@end

@implementation NYKDummyAction

-(id) initWithIdentifier:(NSString *)id_in
{
    self = [super init];
    if( self )
    {
        self.identifier = id_in;
    }
    return self;
}

-(void) execute
{
    NSLog( @"Executing action %@", self.identifier );
    NSLog( @"Action %@ completed", self.identifier );
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@, ID: %@", NSStringFromClass(self.class), _identifier];
}
@end
