//
//  LMUHeader.h
//  Stats
//
//  Created by Scott Sirowy on 8/6/12.
//
//

/**
 @Brief
 */

#import <Foundation/Foundation.h>
#import "LMUCoding.h"

@class LMUAttributedString;

@interface LMUHeader : NSObject <LMUCoding>

- (NSString*)title;

- (LMUAttributedString*)valueAtColumnIndex:(NSInteger)index;
- (NSUInteger)numValues;

@end
