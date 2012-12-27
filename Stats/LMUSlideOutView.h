//
//  LMUSlideOutView.h
//  
//
//  Created by Scott Sirowy

/**
 @Brief
 */

#import <UIKit/UIKit.h>

@protocol SlideOutViewDelegate;

@interface LMUSlideOutView : UIView

@property (nonatomic, retain) UIView*                   inputView;
@property (nonatomic, assign) BOOL                      expanded;
@property (nonatomic, retain) id<SlideOutViewDelegate>  delegate;

-(id)initWithFrame:(CGRect)frame adjacentView:(UIView *)view;

-(void)setExpanded:(BOOL)expanded animated:(BOOL)animated;

@end

@protocol SlideOutViewDelegate <NSObject>

-(void)slideOutViewShouldToggle:(LMUSlideOutView *)slideView;

@end

