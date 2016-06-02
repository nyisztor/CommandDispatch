//
//  NYKDummyAction.h
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Action.h"

@interface TestSerialAction : NSObject <Action>

@property (nonatomic, strong, readonly) NSString* identifier;
@property (nonatomic, strong) NSMutableDictionary* parameters;
@property (nonatomic, assign, readonly) EEXECUTION_TYPE type;
@property (nonatomic, assign, readonly) EEXECUTION_STATE state;

@property (nonatomic, assign) NSUInteger nestingLevel;

@property (nonatomic, assign) id<SerialActionExecuting> serialExecutionDelegate;
@end
