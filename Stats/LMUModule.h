//
//  LMUModule.h
//  Stats
//
//  Created by Scott Sirowy on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/**
 @Brief
 */

#import <Foundation/Foundation.h>

typedef enum
{
    LMUModuleTypeReport = 0,
    LMUModuleTypePDF,
    LMUModuleTypeUnknown
} LMUModuleType;

@class LMUFilters;
@class LMUHeader;
@class LMUReports;

@interface LMUModule : NSObject

@property (nonatomic, copy, readonly) NSString*         title;
@property (nonatomic, retain) UIImage*                  icon;

- (id)initWithJSON:(NSDictionary *)json;
+ (NSArray*)modulesFromJSON:(NSDictionary*)json forKey:(NSString*)key;

@end