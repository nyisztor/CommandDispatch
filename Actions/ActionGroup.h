//
//  ActionGroup.h
//  CommandDispatcher
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Action.h"

/**
 *  Defines an action group
 *  Action groups can include atomic actions of further action groups, following the Conposite Design Pattern
 */
@interface ActionGroup : NSObject <Action>

@property (nonatomic, strong, readonly) NSString* identifier;   ///< unique ID
@property (nonatomic, strong) NSMutableDictionary* parameters;  ///< custom parameters
@property (nonatomic, assign) EEXECUTION_TYPE type;             ///< execution type; tag your actions with the appropriate type
@property (nonatomic, assign) EEXECUTION_STATE state;           ///< action's execution state

@property (nonatomic, assign) NSUInteger nestingLevel;          ///< shows group/action nesting level

@property (nonatomic, assign) id<SerialActionExecuting> serialExecutionDelegate;

@property(nonatomic, strong) NSArray* actions; ///< queue containing the commands (id<Action> objects) to be executed

@end
