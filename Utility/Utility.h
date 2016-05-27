//
//  Utility.h
//  CommandExecution
//
//  Created by Nyisztor, Karoly on 2016. 05. 27..
//  Copyright © 2016. NyK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

/**
 *  Generates random numbers in the given range 
 *
 *  @param min_in nim value
 *  @param max_in max value
 *
 *  @return random float in [min_in, max_in] range
 */
+(float)randomizeInRange:(float)min_in upperLimit:(float)max_in;

@end
