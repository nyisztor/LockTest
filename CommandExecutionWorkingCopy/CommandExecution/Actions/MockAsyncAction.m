//
//  MockAsyncAction.m
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/16/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "MockAsyncAction.h"

@interface MockAsyncAction()

@property(nonatomic, strong) NSString* identifier;

@end

@implementation MockAsyncAction

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
    srand(100);
    float t = (1 + random() % 99) / 10.f;
//    float t = (1 + rand() % 99) / 10.f;
    NSLog( @"Executing async action %@, sleeping for %0.2f", self.identifier, t );
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:t];
        NSLog( @"Action %@ completed", self.identifier );
//    });
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@, ID: %@", NSStringFromClass(self.class), _identifier];
}
@end
