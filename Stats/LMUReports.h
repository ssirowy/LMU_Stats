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

@class LMUReport;

@interface LMUReports : NSObject

- (id)initWithJSON:(NSDictionary*)json;

- (LMUReport*)reportForEncodedString:(NSString*)encodedString;

@end
