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

/**
  Class convenience method to return a report with a given JSON array. Note: Different than
  LMUCoding protocol that specifies a JSON dictionary
  TODO: Can these two ideas be combined?
 */
+ (LMUReport*)reportWithJSONArray:(NSArray*)json;

/**
 Returns an attributed display string to show at a given row and column index
 for the report
 */
- (LMUAttributedString*)stringValueForRow:(NSInteger)rowIndex column:(NSInteger)columnIndex;

/**
 Returns total number of rows in report
 */
- (NSUInteger)numberOfRows;

/**
 Returns total number of columns in report
 */
- (NSUInteger)numberOfColumns;

@end
