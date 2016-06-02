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

static NSUInteger sNestingLevel = 0;

@interface ActionGroup()
@property(nonatomic, strong) NSString* identifier;
@end

@implementation ActionGroup
{
    NSArray* m_Actions;
}

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

//-(void) setActions:(NSArray*)actions
//{
//    ++sNestingLevel;
//    self.nestingLevel = sNestingLevel;
//    
//    [self updateChildNestingLevels:actions];
//    
//    _actions = actions;
//}

-(void) updateChildNestingLevels:(NSArray*)actions
{
    for( id<Action>action in actions )
    {
        if( [action isKindOfClass:[ActionGroup class]] )
        {
            ActionGroup* group = (ActionGroup*)action;
            group.nestingLevel = group.nestingLevel + 1;
            // process included actions
            [self updateChildNestingLevels:group.actions];
        }
        else
        {
            action.nestingLevel = action.nestingLevel + 1;
        }
    }
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
        ++sNestingLevel;
        self.nestingLevel = sNestingLevel;
        
        [self updateChildNestingLevels:self.actions];

        NSString* execStr = [self indentedString:[NSString stringWithFormat:@"Executing action group %@", self.identifier]];
        NSLog( @"%@", execStr );
        self.state = EXECUTING;
        // create the executor based on action group type
        if( _actions.count )
        {
            id<Executor> executor = [[ExecutorFactory sharedInstance] makeExecutor:self.type];
            [executor fireActions:_actions];
        }
        
        self.state = COMPLETED;
        
        NSString* completedStr = [self indentedString:[NSString stringWithFormat:@"Action group %@ completed", self.identifier]];
        NSLog( @"%@", completedStr );
    }
}

-(NSString*) description
{
    return [self indentedString:[NSString stringWithFormat:@"%@, ID: %@", NSStringFromClass(self.class), _identifier]];
}

-(NSString*) indentedString:(NSString*)string_in
{
    NSMutableString* indent = [NSMutableString new];
    
    for (int i = 0; i < _nestingLevel; ++i)
    {
        [indent appendString:@"\t"];
    }
    
    [indent appendString:string_in];
    
    return indent;
}

@end
