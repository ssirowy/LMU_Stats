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
- (NSString*)displayString;
- (NSString*)selectedFilterEncoding;
- (NSString*)choiceNameAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfChoices;

@end
