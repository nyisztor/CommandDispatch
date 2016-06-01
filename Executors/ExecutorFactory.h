//
//  ExecutorFactory.h
//  CommandDispatcher
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

@protocol Executor;
#import <Foundation/Foundation.h>
#import "Action.h"

/**
 *  Creates executors of provided type
 */
@interface ExecutorFactory : NSObject

/**
 *  Creates the singleton factory instance
 *
 *  @return Shared instance
 */
+(ExecutorFactory*) sharedInstance;

-(id<Executor>) makeExecutor:(EEXECUTION_TYPE)type;

@end
