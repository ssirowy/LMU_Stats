//
//  LMUReportModule.h
//  Stats
//
//  Created by Scott Sirowy on 8/13/12.
//
//

/**
 @Brief
 */

#import "LMUModule.h"

@interface LMUReportModule : LMUModule

@property (nonatomic, retain, readonly) LMUFilters*     filters;
@property (nonatomic, retain, readonly) LMUHeader*      header;
@property (nonatomic, retain, readonly) LMUReports*     reports;

@end
