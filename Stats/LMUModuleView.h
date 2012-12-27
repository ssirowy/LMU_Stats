//
//  LMUModuleView.h
//  Stats
//
//  Created by Scott Sirowy on 8/14/12.
//
//

/**
 @Brief   Base class for all module views
 */

#import <UIKit/UIKit.h>

@class LMUModule;

@interface LMUModuleView : UIView

/**
 Module being represented by view
 */
@property (nonatomic, assign, readonly) LMUModule*  module;

/**
 Default initializer for module view's. Subclasses might override.
 */
- (id)initWithFrame:(CGRect)frame withModule:(LMUModule*)module;

@end
