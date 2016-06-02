//
//  Action.h
//  CommandDispatcher
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

/**
 *  Defines possible execution types
 */
typedef NS_ENUM(NSInteger, EEXECUTION_TYPE)
{
    /**
     *  sequential action
     */
    SERIAL,
    /**
     *  parallel action
     */
    PARALLEL,
    /**
     *  unexpected state
     */
    UNKNOWN = 0xffff
};


/**
 *  Defines possible execution states
 */
typedef NS_ENUM(NSInteger, EEXECUTION_STATE)
{
    /**
     *  created but not yet started
     */
    IDLE,
    /**
     *  execution in progress
     */
    EXECUTING,
    /**
     *  completed successfully
     */
    COMPLETED,
    /**
     *  completed with errors
     */
    FAILED,
    /**
     *  unexpected state
     */
    INVALID = 0xffff
};


@import Foundation;
@protocol Action;

/**
 *  Delegate implemented by the SerialExecutor to execute async actions in sequence
 *  @remark Asynchronous actions nested in a serial group shall be executed sequentially; the action must call these delegate methods so that the serial executor can synchronize action execution
 */
@protocol SerialActionExecuting <NSObject>

/**
 *  Called before the action is executed
 *
 *  @param action_in <#action_in description#>
 */
-(void) wait:(id<Action>)action_in;


/**
 *  Called after the action completes
 *
 *  @param action_in <#action_in description#>
 */
-(void) signal:(id<Action>)action_in;

@end

/**
 *  Declares the action/command interface
 */
@protocol Action <NSObject>

@required

/**
 *  Custom intializer, expects a unique ID to be passed
 *
 *  @param id_in unique command ID
 *
 *  @return command instance
 */
-(id) initWithIdentifier:(NSString*)id_in type:(EEXECUTION_TYPE)type_in;

/**
 *  Fires a request
 *
 *  @param executionGroup_in a dispatch queue to serialize the action;
 *  SerialExecutor instances will pass in a group to synchronize background actions; if you implement a custom Action type, you must call dispatch_call_leave( executionGroup_in ) when the async operation completes
 */
-(void) execute;


@property (nonatomic, strong, readonly) NSString* identifier;   ///< unique ID
@property (nonatomic, strong) NSMutableDictionary* parameters;  ///< custom parameters
@property (nonatomic, assign, readonly) EEXECUTION_TYPE type;   ///< execution type
@property (nonatomic, assign, readonly) EEXECUTION_STATE state; ///< action's execution state

@property (nonatomic, assign) NSUInteger nestingLevel; ///< shows group/action nesting level

/**
 *  Delegate methods shall be triggered in order to enable the Serial Executor to execute async requests sequentially
 */
@property (nonatomic, assign) id<SerialActionExecuting> serialExecutionDelegate;

@end
