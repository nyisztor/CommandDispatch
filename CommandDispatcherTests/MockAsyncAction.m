//
//  MockAsyncAction.m
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/16/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "MockAsyncAction.h"
#import "Utility.h"

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
    float t = [Utility randomizeInRange:1.f upperLimit:3.f];
    NSLog( @"Executing async action %@, sleeping for %0.2f", self.identifier, t );

    // XXX: if the action is async itself, the dispatch_group_wait() within the parallel executor has no effect, since the action returns instantly
    // If you assign async actions to a ParallelExecutor, the executor will return before all actions complete
    // Use semaphores to convert async calls to synchronous ones if you want to orchestrate their execution via ParallelExecutor
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
