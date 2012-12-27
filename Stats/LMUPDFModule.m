//
//  LMUPDFModule.m
//  Stats
//
//  Created by Scott Sirowy on 8/13/12.
//
//

#import "LMUPDFModule.h"

@implementation LMUPDFModule

@synthesize fileName    = _fileName;

- (void)dealloc
{
    [_fileName  release];
    [super      dealloc];
}

- (id)initWithJSON:(NSDictionary *)json
{
    self = [super initWithJSON:json];
    if (self)
    {
        _fileName = [[json objectForKey:@"fileName"] copy];
        
        self.icon = [UIImage imageNamed:@"pdf_icon.png"];
    }
    
    return self;
}


@end
