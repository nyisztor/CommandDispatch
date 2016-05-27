//
//  ParallelExecutor.h
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Executor.h"
/**
 *  Fires commands instantly, previous actions may still be executing
 */
@interface ParallelExecutor : NSObject <Executor>

@end
