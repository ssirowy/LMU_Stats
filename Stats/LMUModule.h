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
#import "LMUCoding.h"

@class LMUFilters;
@class LMUHeader;
@class LMUReports;

@interface LMUModule : NSObject <LMUCoding>

/**
 Title of module, for display purposes
 */
@property (nonatomic, copy, readonly) NSString*         title;

/**
 Icon for display purposes
 */
@property (nonatomic, retain) UIImage*                  icon;

/**
 Class method for taking in a bunch of JSOn and creating n modules from that JSON 
 of specific types (defined by subclasses)
 */
+ (NSArray*)modulesFromJSON:(NSDictionary*)json forKey:(NSString*)key;

@end
