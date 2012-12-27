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

@class LMUFilter;

@interface LMUFilters : NSObject

- (id)initWithJSON:(NSDictionary *)json;
- (NSUInteger)count;
- (LMUFilter *)filterAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfFilter:(LMUFilter*)filter;

@end