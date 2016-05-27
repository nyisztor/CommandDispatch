//
//  ParallelExecutor.m
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "ParallelExecutor.h"
#import "QueueProvider.h"

#ifdef DEBUG
#import "DummyAction.h"
#import "ActionGroup.h"
#endif

@interface ParallelExecutor()
@property(nonatomic, retain) dispatch_queue_t globalQueue;
@property(nonatomic, retain) dispatch_group_t queuedGroup;
@end

@implementation ParallelExecutor

-(id) init
{
    self = [super init];
    if( self )
    {
        self.globalQueue = dispatch_get_global_queue(0, 0);
        self.queuedGroup = dispatch_group_create();
    }
    
    return self;
}

-(void) execute:(id<Action>)command
{
    dispatch_async(self.globalQueue, ^{
        [command execute];
    });

    
#ifdef DEBUG
    // groups
    if ( [command isKindOfClass:[ActionGroup class]])
    {
        NSLog( @"%@", @"ParallelExecutor is executing an Action Group" );
    }
    else if ( [command isKindOfClass:[DummyAction class]])
    {
        NSLog( @"%@", @"ParallelExecutor is executing an Action" );
    }
    else
    {
        NSLog( @"%@", @"Error! Unknown object in ParallelExecutor's command queue!" );
    }
#endif
}

-(void) executeCommands:(NSArray *)commands
{
    for(id<Action> command in commands )
    {
        dispatch_group_async(self.queuedGroup, self.globalQueue, ^{
            [command execute];
        });
    }
    
    dispatch_group_wait(self.queuedGroup, DISPATCH_TIME_FOREVER);
    
    //            NSLog( @"%@", [NSString stringWithFormat:@"SerialExecutor: Nested parallel %@ %@ finished execution", [command class], command.identifier] );
#ifdef DEBUG
    dispatch_group_notify(self.queuedGroup, self.globalQueue, ^{
        NSLog( @"ParallelExecutor finished execution" );
    });
#endif
}

@end
