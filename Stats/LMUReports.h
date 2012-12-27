//
//  LMUReports.h
//  Stats
//
//  Created by Scott Sirowy on 8/6/12.
//
//

/**
 @Brief
 */

#import <Foundation/Foundation.h>
#import "LMUCoding.h"

@class LMUReport;

@interface LMUReports : NSObject <LMUCoding>

- (LMUReport*)reportForEncodedString:(NSString*)encodedString;

@end
