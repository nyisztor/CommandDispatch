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


#import <Foundation/Foundation.h>
@protocol Action;

/**
 *  Delegate to be implemented by SerialExecutor classes
 */
@protocol SerialActionExecuting

-(void) willExecute:(id<Action>)action_in;
-(void) didExecute:(id<Action>)action_in;

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

@property (nonatomic, assign) id<SerialActionExecuting> serialExecutionDelegate; ///< delegate to be notified about action execution

@end
