//
//  LMUAttributedString.h
//  Stats
//
//  Created by Scott Sirowy on 8/6/12.
//
//

/**
 @Brief
 */

#import <Foundation/Foundation.h>

@interface LMUAttributedString : NSObject

/**
 Alignment of string
 */
@property (nonatomic, assign, readonly) UITextAlignment textAlignment;

/**
 Boolean as to whether or not text should be underlined
 */
@property (nonatomic, assign, readonly) BOOL            underlined;

/**
 Boolean as to whether or not text should be bolded
 */
@property (nonatomic, assign, readonly) BOOL            bolded;

/**
 Boolean as to whether or not text should be italicized
 */
@property (nonatomic, assign, readonly) BOOL            italicized;

/**
 Plain text that should be attributed by qualifier properties
 */
@property (nonatomic, copy, readonly)   NSString*       plainText;

/**
 Class convenience method for creating an autoreleased attributed string
 with a given plain text string
 */
+ (LMUAttributedString*)attributedStringWithString:(NSString*)string;

@end
