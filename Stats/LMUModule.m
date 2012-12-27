//
//  LMUModule.m
//  Stats
//
//  Created by Scott Sirowy on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LMUModule.h"
#import "LMUReportModule.h"
#import "LMUPDFModule.h"

@implementation LMUModule

- (void)dealloc
{
    [_title     release];
    [_icon      release];
        
    [super dealloc];
}

- (id)initWithJSON:(NSDictionary *)json
{
    self = [super init];
    if(self)
    {
        _title = [[json objectForKey:@"title"] copy];
    }
    
    return self;
}

//Utility class creation method
+ (LMUModule*)moduleFromJSON:(NSDictionary*)json
{
    NSString *moduleType = [json objectForKey:@"type"];
    
    Class moduleClass = nil;
        
    if ([moduleType isEqualToString:@"Report"]) {
        moduleClass = [LMUReportModule class];
    }
    else if([moduleType isEqualToString:@"PDF"])
    {
        moduleClass = [LMUPDFModule class];
    }
    
    LMUModule* module = [[[moduleClass alloc] initWithJSON:json] autorelease];
    
    return module;
}

//Utility class for AGSCoding protocl meant to create correct set of widgets
+ (NSArray*)modulesFromJSON:(NSDictionary*)json forKey:(NSString*)key
{
    NSArray* jsonArray = [json valueForKey:key];
	if (jsonArray == (id)[NSNull null]) {
		return nil;
	}
	
	if (!jsonArray){
		return nil;
	}
    
    NSMutableArray* decodedArray = [NSMutableArray arrayWithCapacity:json.count];
	LMUModule* decodedModule;
    
	for (NSDictionary* dictionary in jsonArray) {
		decodedModule = [LMUModule moduleFromJSON:dictionary];
        
        if(decodedModule)
        {
            [decodedArray addObject:decodedModule];
        }
	}
    
	return decodedArray;
}



@end
