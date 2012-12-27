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

/**
 All filters associated with report module
 */
@property (nonatomic, retain, readonly) LMUFilters*     filters;

/**
 Header object associated with report module
 */
@property (nonatomic, retain, readonly) LMUHeader*      header;

/**
 All reports associated with report module
 */
@property (nonatomic, retain, readonly) LMUReports*     reports;

@end
