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

@property (nonatomic, assign, readonly) UITextAlignment textAlignment;
@property (nonatomic, assign, readonly) BOOL            underlined;
@property (nonatomic, assign, readonly) BOOL            bolded;
@property (nonatomic, assign, readonly) BOOL            italicized;
@property (nonatomic, copy, readonly)   NSString*       plainText;

+ (LMUAttributedString*)attributedStringWithString:(NSString*)string;

@end
