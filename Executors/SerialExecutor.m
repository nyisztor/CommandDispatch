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
@property(nonatomic, retain) dispatch_group_t queuedGroup;
@end

@implementation SerialExecutor

-(id) init
{
    self = [super init];
    if( self )
    {
        self.queuedGroup = dispatch_group_create();
    }
    
    return self;
}

-(void) execute:(id<Action>)command
{
    [command execute];
}

-(void) fireActions:(NSArray *)actions
{
    for(id<Action> action in actions )
    {
        
#ifdef DEBUG
        NSString* str = [self indentedString:[NSString stringWithFormat:@"About to execute %@", action.identifier] level:action.nestingLevel];
        NSLog( @"%@", str );
#endif
        dispatch_group_enter(_queuedGroup);

        action.serialExecutionDelegate = self;
        [action execute];
    }
}

#pragma mark - SerialActionExecuting

-(void) wait:(id<Action>)action_in
{
#ifdef DEBUG
    NSString* str = [self indentedString:[NSString stringWithFormat:@"%@ is running", action_in.identifier] level:action_in.nestingLevel];
    NSLog( @"%@", str );
#endif
    dispatch_group_wait(_queuedGroup, DISPATCH_TIME_FOREVER);
}

-(void) signal:(id<Action>)action_in
{
#ifdef DEBUG
    NSString* str = [self indentedString:[NSString stringWithFormat:@"%@ signal received", action_in.identifier] level:action_in.nestingLevel];
    NSLog( @"%@", str );
#endif
    dispatch_group_leave(_queuedGroup);
}

-(NSString*) indentedString:(NSString*)string_in level:(NSUInteger)nestingLevel
{
    NSMutableString* indent = [NSMutableString new];
    
    for (int i = 0; i < nestingLevel; ++i)
    {
        [indent appendString:@"\t"];
    }
    
    [indent appendString:string_in];
    
    return indent;
}

@end
