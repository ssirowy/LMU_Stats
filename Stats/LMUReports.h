//
//  LMUReports.h
//  Stats
//
//  Created by Scott Sirowy on 8/6/12.
//
//

/**
 @Brief A wrapper for an array of LMUReport's.
 */

#import <Foundation/Foundation.h>
#import "LMUCoding.h"

@class LMUReport;

@interface LMUReports : NSObject <LMUCoding>

/**
 Returns the LMU Report for a given encoding (defined in doc files)
 Ex. 1_1_1_1_1 returns a report where most filters are set to 'All'
 */
- (LMUReport*)reportForEncodedString:(NSString*)encodedString;

@end
