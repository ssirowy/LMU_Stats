//
//  LMUReportModule.m
//  Stats
//
//  Created by Scott Sirowy on 8/13/12.
//
//

#import "LMUReportModule.h"
#import "LMUFilters.h"
#import "LMUHeader.h"
#import "LMUReports.h"

@interface LMUReportModule ()

@property (nonatomic, retain, readwrite) LMUFilters*    filters;
@property (nonatomic, retain) LMUHeader*                header;
@property (nonatomic, retain) LMUReports*               reports;

@end

@implementation LMUReportModule

- (void)dealloc
{
    [_filters   release];
    [_header    release];
    [_reports   release];
    
    [super dealloc];
}

- (id)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self) {
        LMUFilters *f = [[LMUFilters alloc] initWithJSON:[json objectForKey:@"filters"]];
        self.filters = f;
        [f release];
        
        LMUHeader*h  = [[LMUHeader alloc] initWithJSON:[json objectForKey:@"header"]];
        self.header = h;
        [h release];
        
        LMUReports* r = [[LMUReports alloc]initWithJSON:[json objectForKey:@"data"]];
        self.reports = r;
        [r release];
        
        self.icon = [UIImage imageNamed:@"report_icon.png"];
    }
    
    return self;
}

@end
