//
//  LMUReport.m
//  Stats
//
//  Created by Scott Sirowy on 8/19/12.
//
//

#import "LMUReport.h"
#import "LMUAttributedString.h"

@interface LMUReport ()

@property (nonatomic, retain) NSArray*  valuesArray;

@end

@implementation LMUReport

- (void)dealloc
{
    [super  dealloc];
}

- (id)initWithJSON:(NSArray*)json
{
    self = [super init];
    if(self)
    {
        self.valuesArray = json;
    }
    
    return self;
}

- (LMUAttributedString*)stringValueForRow:(NSInteger)rowIndex column:(NSInteger)columnIndex
{
    if (rowIndex < 0 || rowIndex >= self.valuesArray.count)
    {
        return nil;
    }
    
    NSArray* row = [self.valuesArray objectAtIndex:rowIndex];
    
    if (columnIndex < 0 || columnIndex >= row.count)
    {
        return nil;
    }
    
    NSString* attString = [row objectAtIndex:columnIndex];
    return [LMUAttributedString attributedStringWithString:attString];
}

- (NSUInteger)numberOfRows
{
    return self.valuesArray.count;
}

- (NSUInteger)numberOfColumns
{
    if (self.valuesArray.count > 0)
    {
        return [[self.valuesArray objectAtIndex:0] count];
    }
    
    return 0;
}

+ (LMUReport*)reportWithJSONArray:(NSArray*)json
{
    LMUReport* report = [[[LMUReport alloc] initWithJSON:json] autorelease];
    return report;
}

@end

