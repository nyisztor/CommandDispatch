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
    
    NSString* str = [self indentedString:[NSString stringWithFormat:@"Executing action %@, sleeping for %0.2f", self.identifier, t] level:self.nestingLevel];
    NSLog( @"%@", str );

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:t];
        
        // call delegate method
        if( self.serialExecutionDelegate && [self.serialExecutionDelegate respondsToSelector:@selector(signal:)] )
        {
            [self.serialExecutionDelegate signal:self];
        }
        self.state = COMPLETED;
        
        NSString* str2 = [self indentedString:[NSString stringWithFormat:@"Action %@ completed", self.identifier] level:self.nestingLevel];
        NSLog( @"%@", str2 );

    });
    
    // call delegate method
    if( self.serialExecutionDelegate && [self.serialExecutionDelegate respondsToSelector:@selector(wait:)] )
    {
        [self.serialExecutionDelegate wait:self];
    }
}

//-(void) dealloc
//{
//    self.serialExecutionDelegate = nil;
//}

-(NSString*) description
{
    return [NSString stringWithFormat:@"%@, ID: %@", NSStringFromClass(self.class), _identifier];
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
