//
//  LMUPDFModuleView.h
//  Stats
//
//  Created by Scott Sirowy on 8/14/12.
//
//

/**
 @Brief
 */

#import "LMUModuleView.h"

@class LMUPDFModule;

@interface LMUPDFModuleView : LMUModuleView

/**
 Overridden version of base class implementation
 */
- (id)initWithFrame:(CGRect)frame withModule:(LMUPDFModule*)module;

@end
