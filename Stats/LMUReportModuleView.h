//
//  LMUModuleView.h
//  Stats
//
//  Created by Scott Sirowy on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/**
 @Brief
 */

#import "LMUModuleView.h"

@class LMUReportModule;

@interface LMUReportModuleView : LMUModuleView

/**
 Overriden version of base class implementation
 */
- (id)initWithFrame:(CGRect)frame withModule:(LMUReportModule*)module;

@end
