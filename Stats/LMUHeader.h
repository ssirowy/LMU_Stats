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

@class LMUAttributedString;

@interface LMUHeader : NSObject

- (id)initWithJSON:(NSDictionary *)json;

- (NSString*)title;

- (LMUAttributedString*)valueAtColumnIndex:(NSInteger)index;
- (NSUInteger)numValues;

@end
