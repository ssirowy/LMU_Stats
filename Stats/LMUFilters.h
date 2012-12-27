//
//  LMUFilters.h
//  Stats
//
//  Created by Scott Sirowy on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/**
 @Brief
 */

#import <Foundation/Foundation.h>
#import "LMUCoding.h"

@class LMUFilter;

@interface LMUFilters : NSObject <LMUCoding>

/**
 Returns total number of filters. Use like [NSArray count]
 */
- (NSUInteger)count;

/**
 Returns a filter at a specified index. Nil if index is undefined
 */
- (LMUFilter *)filterAtIndex:(NSUInteger)index;

/**
 Returns index of a given filter. NSNotFound is not found
 */
- (NSUInteger)indexOfFilter:(LMUFilter*)filter;

@end