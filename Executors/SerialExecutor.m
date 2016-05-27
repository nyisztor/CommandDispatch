//
//  SerialExecutor.m
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "SerialExecutor.h"
#import "Action.h"
#import "ActionGroup.h"
#import "DummyAction.h"

@interface SerialExecutor()
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
    for(id<Action> command in actions )
    {
        // parallel action (group) nested in a serial one shall complete before starting the next command in the serial queue
        if( command.type == PARALLEL )
        {
            [command execute];
        }
        else
        {
            // !!! Calls to dispatch_sync() targeting the current queue will result in deadlock
            dispatch_sync(self.serialQueue, ^{
                [command execute];
            });
        }
    }
}

@end
