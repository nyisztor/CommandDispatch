//
//  CommandDispatcher.h
//  CommandDispatcher
//
//  Created by Nyisztor, Karoly on 2016. 05. 27..
//  Copyright © 2016. Nyisztor, Karoly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Action.h"
#import "ActionGroup.h"


/**
 * CommandDispatcher allows grouping of commands and executing them sequentially or in parallel
 * You can nest multiple commands or command groups as in the example below:
 *
 * [SERIAL GROUP #1] BEGIN
 *      SERIAL ACTION #1
 *      SERIAL ACTION #2
 *
 *      [PARALLEL GROUP #1] BEGIN
 *          PARALLEL ACTION #1
 *
 *          [SERIAL GROUP #2] BEGIN
 *              SERIAL ACTION #11
 *              SERIAL ACTION #12
 *          [SERIAL GROUP #2] END
 *
 *          PARALLEL ACTION #2
 *      [PARALLEL GROUP #1] END
 *
 *      SERIAL ACTION #3
 *      SERIAL ACTION #4
 *
 * [SERIAL GROUP #1] END
 *
 * Your command classes have to adhere to the Action protocol. Use ActionGroup instances to group your commands.
 * Check out the unit tests for a usage example
 * @see CommandDispatcherTests
 */

//! Project version number for CommandDispatcher.
FOUNDATION_EXPORT double CommandDispatcherVersionNumber;

//! Project version string for CommandDispatcher.
FOUNDATION_EXPORT const unsigned char CommandDispatcherVersionString[];


