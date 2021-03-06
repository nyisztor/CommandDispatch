//
//  SerialExecutor.h
//  CommandDispatcher
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Executor.h"

/**
 *  Executes actions in sequence
 */
@interface SerialExecutor : NSObject <Executor>

@end