//
//  IExecutor.h
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"

/**
 *  Declares the executor methods
 */
@protocol Executor <NSObject>

/**
 *  Executes a single action
 *
 *  @param command action to be executed
 */
-(void) execute:(id<Action>) command;

/**
 *  Executes the actions from the passed in array
 *
 *  @param commands array< id<IAction> >
 */
-(void) executeCommands:(NSArray*) commands;

@end
