//
//  IExecutor.h
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Action;

/**
 *  Declares the executor methods
 */
@protocol Executor <NSObject>

/**
 *  Executes the actions from the passed in array
 *
 *  @param commands array< id<Action> >
 */
-(void) fireActions:(NSArray*) actions;

@end
