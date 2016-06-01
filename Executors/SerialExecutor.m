//
//  SerialExecutor.m
//  CommandDispatcher
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "SerialExecutor.h"
#import "Action.h"
#import "ActionGroup.h"
#import "TestSerialAction.h"

@interface SerialExecutor()  <SerialActionExecuting>
@property(nonatomic, retain) dispatch_queue_t serialQueue;
@property(nonatomic, retain) dispatch_group_t queuedGroup;
@end

@implementation SerialExecutor

-(id) init
{
    self = [super init];
    if( self )
    {
        // Create a dedicated serial queue for each SerialExecutor instance
        NSString* uIdStr = [NSUUID UUID].UUIDString;
        self.serialQueue = dispatch_queue_create(uIdStr.UTF8String, DISPATCH_QUEUE_SERIAL);
        self.queuedGroup = dispatch_group_create();
    }
    
    return self;
}

-(void) execute:(id<Action>)command
{
    dispatch_sync(self.serialQueue, ^{
        [command execute];
    });
}

-(void) fireActions:(NSArray *)actions
{
    for(id<Action> action in actions )
    {
        action.serialExecutionDelegate = self;
        [action execute];
    }
}

#pragma mark - SerialActionExecuting

-(void) willExecute:(id<Action>)action_in
{
#ifdef DEBUG
    NSLog(@"\tAbout to execute %@", action_in.identifier);
#endif
    dispatch_group_enter(_queuedGroup);
}

-(void) didExecute:(id<Action>)action_in
{
#ifdef DEBUG
    NSLog(@"\t%@ completed", action_in.identifier);
#endif

    dispatch_group_leave(_queuedGroup);
}


@end
