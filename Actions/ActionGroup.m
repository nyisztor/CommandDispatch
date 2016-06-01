//
//  ActionGroup.m
//  CommandDispatcher
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "ActionGroup.h"
#import "ExecutorFactory.h"
#import "Executor.h"
#import "Action.h"

@interface ActionGroup()
@property(nonatomic, strong) NSString* identifier;
@end

@implementation ActionGroup

-(ActionGroup*) initWithIdentifier:(NSString*)id_in type:(EEXECUTION_TYPE)type_in
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
/**
 *  Executes the commands from the queue by passing them to the appropriate executor (serial or parallel)
 * the command can be a NYKAction or another NYKActionGroup
 */
-(void) execute
{
    if( !_actions.count )
    {
        NSLog( @"Action group %@ is empty!", self.identifier );
        self.state = COMPLETED;
    }
    else
    {
        NSLog( @"Executing action group %@", self.identifier );
        self.state = EXECUTING;
        // create the executor based on action group type
        if( _actions.count )
        {
            id<Executor> executor = [[ExecutorFactory sharedInstance] makeExecutor:self.type];
            [executor fireActions:_actions];
        }
        
        self.state = COMPLETED;
        NSLog( @"Action group %@ completed", self.identifier );
    }
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@, ID: %@", NSStringFromClass(self.class), _identifier];
}

@end
