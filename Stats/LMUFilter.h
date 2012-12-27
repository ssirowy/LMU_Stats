//
//  LMUFilter.h
//  Stats
//
//  Created by Scott Sirowy on 8/19/12.
//
//

/**
 @Brief
 */

#import <Foundation/Foundation.h>

@interface LMUFilter  : NSObject

/**
 Name of filter, for display purposed
 */
@property (nonatomic, copy, readonly) NSString*         title;

/**
 The selected filter choice
 */
@property (nonatomic, copy) NSString*                   selectedFilterString;

/**
 Default initializer. Accepts a filter title
 */
- (id)initWithTitle:(NSString *)title filterChoices:(NSArray *)filterChoices;

/**
 Returns a formatted string for filter.
 */
- (NSString*)displayString;

/**
 Returns a string for the selected filter encoding
 */
- (NSString*)selectedFilterEncoding;

/**
 Returns a string name for the filter choice at a given index
 */
- (NSString*)choiceNameAtIndex:(NSUInteger)index;

/**
 Returns the number of choices for a filter
 */
- (NSUInteger)numberOfChoices;

@end
