//
//  NYKDummyAction.m
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "TestSerialAction.h"
#import "Utility.h"

@interface TestSerialAction()

@property(nonatomic, strong) NSString* identifier;
@property (nonatomic, assign) EEXECUTION_TYPE type;
@property (nonatomic, assign) EEXECUTION_STATE state;

@end

@implementation TestSerialAction

-(id) initWithIdentifier:(NSString *)id_in type:(EEXECUTION_TYPE)type_in
{
    self = [super init];
    if( self )
    {
        self.identifier = id_in;
        self.type = type_in;
        self.state = IDLE;
    }
    return self;
}

-(void) execute
{
    self.state = EXECUTING;
    
    float t = [Utility randomizeInRange:1.f upperLimit:2.f];
    NSLog( @"Executing action %@, sleeping for %0.2f", self.identifier, t );
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:t];
        self.state = COMPLETED;
    });
    
    NSLog( @"Action %@ completed", self.identifier );
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@, ID: %@", NSStringFromClass(self.class), _identifier];
}
@end
