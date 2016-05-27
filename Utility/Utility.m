//
//  Utility.m
//  CommandExecution
//
//  Created by Nyisztor, Karoly on 2016. 05. 27..
//  Copyright © 2016. NyK. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+(float)randomizeInRange:(float)min_in upperLimit:(float)max_in
{
    float result = 0;
    
    if ( min_in >= max_in )
    {
        NSLog( @"%@", @"Invalid range" );
        result = 0;
    }
    result = min_in + arc4random_uniform(max_in - min_in + 1);
    
    return result;
}

@end
