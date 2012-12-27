//
//  LMUReports.m
//  Stats
//
//  Created by Scott Sirowy on 8/6/12.
//
//

#import "LMUReports.h"
#import "LMUReport.h"

@interface LMUReports ()

@property (nonatomic, retain) NSDictionary* valuesDictionary;

@end

@implementation LMUReports

- (id)initWithJSON:(NSDictionary*)json
{
    self = [super init];
    if(self)
    {
        self.valuesDictionary = json;
    }
    
    return self;
}

- (LMUReport*)reportForEncodedString:(NSString*)encodedString
{
    NSArray* reportArray = [self.valuesDictionary objectForKey:encodedString];
    return [LMUReport reportWithJSONArray:reportArray];
}

@end