//
//  LMUReport.h
//  Stats
//
//  Created by Scott Sirowy on 8/19/12.
//
//

/**
 @Brief
 */

#import <Foundation/Foundation.h>

@class LMUAttributedString;

@interface LMUReport : NSObject

//Accepts an array of JSON that represents report;
+ (LMUReport*)reportWithJSONArray:(NSArray*)json;

- (LMUAttributedString*)stringValueForRow:(NSInteger)rowIndex column:(NSInteger)columnIndex;
- (NSUInteger)numberOfRows;
- (NSUInteger)numberOfColumns;

@end
