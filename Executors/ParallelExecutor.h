//
//  ParallelExecutor.h
//  CommandDispatcher
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Executor.h"
/**
 *  Fires actions in parallel
 *  @remark: Previous actions may still be running
 */
@interface ParallelExecutor : NSObject <Executor>

@end
