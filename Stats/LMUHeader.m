//
//  LMUHeader.m
//  Stats
//
//  Created by Scott Sirowy on 8/6/12.
//
//

#import "LMUHeader.h"
#import "LMUAttributedString.h"

@interface LMUHeader ()

@property (nonatomic, copy) NSString*   title;

/*
 An array of attributed string values
 */
@property (nonatomic, retain) NSArray*  values;

@end

@implementation LMUHeader

- (void)dealloc
{
    [_title     release];
    [_values    release];
    
    [super dealloc];
}

- (id)initWithJSON:(NSDictionary *)json
{
    self = [super init];
    if(self)
    {
        self.title = [json objectForKey:@"title"];
        self.values  = [json objectForKey:@"values"];
    }
    
    return self;
}

- (LMUAttributedString*)valueAtColumnIndex:(NSInteger)index
{
    if (index < 0 || index >= self.values.count)
    {
        return  nil;
    }
    
    NSString* attString = [self.values objectAtIndex:index];
    return [LMUAttributedString attributedStringWithString:attString];
}

- (NSUInteger)numValues
{
    return self.values.count;
}

@end
