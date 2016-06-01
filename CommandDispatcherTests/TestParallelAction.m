//
//  MockAsyncAction.m
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/16/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "TestParallelAction.h"
#import "Utility.h"

@interface TestParallelAction()

@property(nonatomic, strong) NSString* identifier;
@property (nonatomic, assign) EEXECUTION_TYPE type;
@property (nonatomic, assign) EEXECUTION_STATE state;

@end

@implementation TestParallelAction

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
    
    float t = [Utility randomizeInRange:1.f upperLimit:3.f];
    NSLog( @"Executing async action %@, sleeping for %0.2f", self.identifier, t );
        
//    [NSThread sleepForTimeInterval:t];
//    self.state = COMPLETED;
//    NSLog( @"Action %@ completed", self.identifier );

    // XXX: if the action is async itself, the dispatch_group_wait() within the parallel executor has no effect, since the action returns instantly
    // If you assign async actions to a ParallelExecutor, the executor will return before all actions complete
    // Use semaphores to convert async calls to synchronous ones if you want to orchestrate their execution via ParallelExecutor
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:t];
        self.state = COMPLETED;
        NSLog( @"Action %@ completed", self.identifier );
    });
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@, ID: %@", NSStringFromClass(self.class), _identifier];
}
@end
