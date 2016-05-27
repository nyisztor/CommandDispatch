//
//  NYKDummyAction.m
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "DummyAction.h"
#import "Utility.h"

@interface DummyAction()

@property(nonatomic, strong) NSString* identifier;

@end

@implementation DummyAction

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
    float t = [Utility randomizeInRange:1.f upperLimit:2.f];
    NSLog( @"Executing action %@, sleeping for %0.2f", self.identifier, t );
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:t];
    });
    
    NSLog( @"Action %@ completed", self.identifier );
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@, ID: %@", NSStringFromClass(self.class), _identifier];
}
@end
