//
//  ViewController.m
//  ActionGroupTest
//
//  Created by Nyisztor Karoly on 10/14/13.
//  Copyright (c) 2014 NyK. All rights reserved.
//

#import "ViewController.h"
#import "ActionCommons.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // 1. create some mock nested action groups and actions
    // Our setup goes like this:
    //
    // [SERIAL GROUP #1] BEGIN
    //      SERIAL ACTION #1
    //      SERIAL ACTION #2
    //
    //      [PARALLEL GROUP #1] BEGIN
    //          PARALLEL ACTION #1
    //          PARALLEL ACTION #2
    //      [PARALLEL GROUP #1] END
    //
    //      SERIAL ACTION #3
    //      SERIAL ACTION #4
    //
    // [SERIAL GROUP #1] END
    
    ActionGroup* serialGroupRoot = [[ActionGroup alloc] initWithIdentifier:@"serialGroupRoot"];
        serialGroupRoot.type = SERIAL;
    
        DummyAction* serialAction1 = [[DummyAction alloc] initWithIdentifier:@"serialAction1"];
        DummyAction* serialAction2 = [[DummyAction alloc] initWithIdentifier:@"serialAction2"];
    
        ActionGroup* parallelGroupInner = [[ActionGroup alloc] initWithIdentifier:@"parallelGroupInner"];
        parallelGroupInner.type = PARALLEL;
        
            MockAsyncAction* parallelAction1 = [[MockAsyncAction alloc] initWithIdentifier:@"parallelAction1"];
            MockAsyncAction* parallelAction2 = [[MockAsyncAction alloc] initWithIdentifier:@"parallelAction2"];
            // add the actions to the parallel group
            [parallelGroupInner.execQueue addObjectsFromArray:@[parallelAction1, parallelAction2]];
    
        DummyAction* serialAction3 = [[DummyAction alloc] initWithIdentifier:@"serialAction3"];
        DummyAction* serialAction4 = [[DummyAction alloc] initWithIdentifier:@"serialAction4"];
    // add the actions and the actionGroup to the root group
    [serialGroupRoot.execQueue addObjectsFromArray:@[serialAction1, serialAction2, parallelGroupInner, serialAction3, serialAction4]];
    
    // 2. call execute on the "root" action group
    [serialGroupRoot execute];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
