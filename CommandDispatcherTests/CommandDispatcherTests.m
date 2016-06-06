//
//  CommandDispatcherTests.m
//  CommandDispatcherTests
//
//  Created by Nyisztor, Karoly on 2016. 05. 27..
//  Copyright © 2016. Nyisztor, Karoly. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ActionGroup.h"
#import "TestSerialAction.h"
#import "TestParallelAction.h"

@interface CommandDispatcherTests : XCTestCase

@end

@implementation CommandDispatcherTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testActionExecution {
    // 1. create some mock nested action groups and actions
    // Our setup goes like this:
    //
    // [SERIAL GROUP #1] BEGIN
    //      SERIAL ACTION #1
    //      SERIAL ACTION #2
    //
    //      [PARALLEL GROUP #1] BEGIN
    //          PARALLEL ACTION #1
    //
    //          [SERIAL GROUP #2] BEGIN
    //              SERIAL ACTION #11
    //              SERIAL ACTION #12
    //          [SERIAL GROUP #2] END
    //
    //          PARALLEL ACTION #2
    //      [PARALLEL GROUP #1] END
    //
    //      SERIAL ACTION #3
    //      SERIAL ACTION #4
    //
    // [SERIAL GROUP #1] END
    ActionGroup* serialGroupRoot = [[ActionGroup alloc] initWithIdentifier:@"serialGroupRoot" type:SERIAL];
    
    TestSerialAction* serialAction1 = [[TestSerialAction alloc] initWithIdentifier:@"serialAction1" type:SERIAL];
    TestSerialAction* serialAction2 = [[TestSerialAction alloc] initWithIdentifier:@"serialAction2" type:SERIAL];
    
    ActionGroup* parallelGroupInner = [[ActionGroup alloc] initWithIdentifier:@"parallelGroupInner" type:PARALLEL];
    
    TestParallelAction* parallelAction1 = [[TestParallelAction alloc] initWithIdentifier:@"parallelAction1" type:SERIAL];
    
    // serial group within the parallel group
    ActionGroup* serialGroupInner = [[ActionGroup alloc] initWithIdentifier:@"serialGroupInner" type:SERIAL];
    // define serial actions
    TestParallelAction* parallelAction11 = [[TestParallelAction alloc] initWithIdentifier:@"serialAction11" type:PARALLEL];
    TestParallelAction* parallelAction12 = [[TestParallelAction alloc] initWithIdentifier:@"serialAction12" type:PARALLEL];
    
    serialGroupInner.actions = @[parallelAction11, parallelAction12];
    
    TestParallelAction* parallelAction2 = [[TestParallelAction alloc] initWithIdentifier:@"parallelAction2" type:SERIAL];
    // add the actions to the parallel group
    parallelGroupInner.actions  = @[parallelAction1, serialGroupInner, parallelAction2];
    
    TestSerialAction* serialAction3 = [[TestSerialAction alloc] initWithIdentifier:@"serialAction3" type:SERIAL];
    TestSerialAction* serialAction4 = [[TestSerialAction alloc] initWithIdentifier:@"serialAction4" type:SERIAL];
    // add the actions and the actionGroup to the root group
    serialGroupRoot.actions = @[serialAction1, serialAction2, parallelGroupInner, serialAction3, serialAction4];
    
    // 2. call execute on the "root" action group
    [serialGroupRoot execute];
    
    XCTAssertTrue(serialGroupRoot.state == COMPLETED, "Actions should be completed, received different state instead ");
    
    for( id<Action>action in serialGroupRoot.actions )
    {
        XCTAssertTrue(action.state == COMPLETED, "Actions should be completed, received different state instead ");
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
