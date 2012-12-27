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

/**
 Title for display purposes on header
 */
- (NSString*)title;

/**
 Returns total number of values to be displayed in header
 */
- (NSUInteger)numValues;

/**
 Since the header defined a set of n values to be displayed, use this to
 generate an attributed string indexing into header columns
 */
- (LMUAttributedString*)valueAtColumnIndex:(NSInteger)index;

@end
