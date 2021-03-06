//
//  ExecutorFactory.m
//  CommandDispatcher
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//


#import "ExecutorFactory.h"
#import "SerialExecutor.h"
#import "ParallelExecutor.h"
#import "Executor.h"

@implementation ExecutorFactory

+(ExecutorFactory*) sharedInstance
{
    static ExecutorFactory* factory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        factory = [[ExecutorFactory alloc] init];
    });
    
    return factory;
}

-(id<Executor>) makeExecutor:(EEXECUTION_TYPE)type
{
    id<Executor> result = nil;
    
    switch (type)
    {
        case SERIAL:
        {
            result = [[SerialExecutor alloc] init];
        } break;
        case PARALLEL:
        {
            result = [[ParallelExecutor alloc] init];
        } break;
        default:
        {
            NSLog(@"%@", @"Should not reach here" );
        } break;
    }
    
    return result;
}

@end
