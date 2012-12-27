//
//  LMUFilter.m
//  Stats
//
//  Created by Scott Sirowy on 8/19/12.
//
//

#import "LMUFilter.h"

@interface LMUFilter ()

@property (nonatomic, copy, readwrite) NSString*        title;
@property (nonatomic, retain, readwrite) NSArray*       choices;

@end

#define kDefaultValue 1

@implementation LMUFilter

- (void)dealloc
{
    [_title                 release];
    [_choices               release];
    [_selectedFilterString  release];
    
    [super dealloc];
}

-(id)initWithTitle:(NSString *)title filterChoices:(NSArray *)filterChoices
{
    self = [super init];
    if(self)
    {
        self.title = title;
        
        //Choices is an array of dictionaries... Each dictionary has only
        //one key-value pair...  Key = String  Value = Number that represents it encoding
        self.choices = filterChoices;
        
        //find the initial Default Value choice.
        for(NSDictionary *d in self.choices)
        {
            //should only be one
            for(id s in d.allKeys)
            {
                NSNumber *num = [d objectForKey:s];
                if([num intValue] == kDefaultValue)
                {
                    self.selectedFilterString = s;
                }
            }
        }
    }
    
    return self;
}

- (NSString *)displayString
{
    return [NSString stringWithFormat:@"%@ - %@", self.title, self.selectedFilterString];
}

- (NSString *)selectedFilterEncoding
{
    for(NSDictionary *d in self.choices)
    {
        //should only be one
        for(NSString* s in d.allKeys)
        {
            if ([s isEqualToString:self.selectedFilterString]) {
                return [[d objectForKey:s] stringValue];
            }
        }
    }
    
    //empty string if no number
    return @"";
}

- (NSString*)choiceNameAtIndex:(NSUInteger)index
{
    if (index >= self.choices.count) {
        return nil;
    }
    
    //Grab dictionary associated with choice, and return only key in that dictionary
    NSDictionary* d = [self.choices objectAtIndex:index];
    return [d.allKeys objectAtIndex:0];
}

- (NSUInteger)numberOfChoices
{
    return self.choices.count;
}

@end

