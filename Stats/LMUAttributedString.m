//
//  LMUAttributedString.m
//  Stats
//
//  Created by Scott Sirowy on 8/6/12.
//
//

#import "LMUAttributedString.h"

@interface LMUAttributedString ()

@property (nonatomic, assign, readwrite) UITextAlignment    textAlignment;
@property (nonatomic, assign, readwrite) BOOL               underlined;
@property (nonatomic, assign, readwrite) BOOL               bolded;
@property (nonatomic, assign, readwrite) BOOL               italicized;
@property (nonatomic, copy, readwrite)   NSString*          plainText;

- (void)parsePlainText:(NSString*)string;

@end

@implementation LMUAttributedString

- (void)dealloc
{
    [_plainText release];
    
    [super      dealloc];
}

- (id)initWithString:(NSString *)aString    
{
    self = [self init];
    if(self)
    {
        self.textAlignment = UITextAlignmentCenter;  //Default
        self.underlined = NO;
        self.italicized = NO;
        self.bolded = NO;
                
        [self parsePlainText:aString];
    }
    
    return self;
}

+ (LMUAttributedString*)attributedStringWithString:(NSString*)string
{
    return [[[LMUAttributedString alloc] initWithString:string] autorelease];
}

- (void)parsePlainText:(NSString*)string
{
    NSString* rawStringCopy = [[string copy] autorelease];
    NSScanner*  theScanner = [NSScanner scannerWithString:string];
    NSString*   markup = nil;
    
    while ([theScanner isAtEnd] == NO) {
        
        [theScanner scanUpToString:@"[" intoString:NULL];
        
        [theScanner scanUpToString:@"]" intoString:&markup];
        
        if (markup && markup.length > 0)
        {
            NSString* toReplaceString = [NSString stringWithFormat:@"%@]", markup];
            rawStringCopy = [rawStringCopy stringByReplacingOccurrencesOfString:toReplaceString withString:@""];
            
            [self updatePropertiesForMarkup:toReplaceString];
        }
    }
    //
    rawStringCopy = [rawStringCopy stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    self.plainText = rawStringCopy;
}

- (void)updatePropertiesForMarkup:(NSString*)markup
{
    if([markup rangeOfString:@"r"].location != NSNotFound)
    {
        self.textAlignment = UITextAlignmentRight;
    }
    else if ([markup rangeOfString:@"i"].location != NSNotFound)
    {
        self.italicized = YES;
    }
    else if ([markup rangeOfString:@"u"].location != NSNotFound)
    {
        self.underlined = YES;
    }
}

@end
