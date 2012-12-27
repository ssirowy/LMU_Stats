//
//  LMUReportView.h
//  Stats
//
//  Created by Scott Sirowy on 8/6/12.
//
//

/**
 @Brief
 */

#import <UIKit/UIKit.h>

@class LMUReport;
@class LMUHeader;

@interface LMUReportView : UIView

@property (nonatomic, retain) LMUReport*    report;

- (id)initWithFrame:(CGRect)frame withHeader:(LMUHeader*)header withReport:(LMUReport*)report;

@end
