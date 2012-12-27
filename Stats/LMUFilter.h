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

@property (nonatomic, copy, readonly) NSString*         title;
@property (nonatomic, copy) NSString*                   selectedFilterString;

- (id)initWithTitle:(NSString *)title filterChoices:(NSArray *)filterChoices;
- (NSString*)displayString;
- (NSString*)selectedFilterEncoding;
- (NSString*)choiceNameAtIndex:(NSUInteger)index;
- (NSUInteger)numberOfChoices;

@end
