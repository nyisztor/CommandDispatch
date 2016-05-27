//
//  NYKActionGroup.m
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "ActionGroup.h"
#import "ExecutorFactory.h"

@interface ActionGroup()
@property(nonatomic, strong) NSString* identifier;
@end

@implementation ActionGroup

-(ActionGroup*) initWithIdentifier:(NSString*)id_in
{
    self = [super init];
    if( self )
    {
        self.identifier = id_in;
        self.type = UNKNOWN;
        self.execQueue = [NSMutableArray array];
    }
    return self;
}
/**
 *  Executes the commands from the queue by passing them to the appropriate executor (serial or parallel)
 * the command can be a NYKAction or another NYKActionGroup
 */
-(void) execute
{
    NSLog( @"Executing action group %@", self.identifier );
    
    // create the executor based on action group type
    id<Executor> executor = [[ExecutorFactory sharedInstance] makeExecutor:self.type];
    [executor executeCommands:self.execQueue];
    
    NSLog( @"Action group %@ completed", self.identifier );
}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@, ID: %@", NSStringFromClass(self.class), _identifier];
}

@end
