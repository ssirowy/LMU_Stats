//
//  LMUFilterSelectionViewController.h
//  Stats
//
//  Created by Scott Sirowy on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/**
 @Brief
 */

#import <UIKit/UIKit.h>

@class LMUFilter;
@protocol LMUFilterSelectionDelegate;

@interface LMUFilterSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain, readonly) LMUFilter*              filter;
@property (nonatomic, assign) id<LMUFilterSelectionDelegate>    delegate;

- (id)initWithFilter:(LMUFilter *)filter;

@end

@protocol LMUFilterSelectionDelegate <NSObject>

@optional
- (void)filterSelectionViewController:(LMUFilterSelectionViewController *)fsvc didChooseFilterChoice:(NSString *)choice;
- (CGFloat)desiredWidthForFilterSelectionViewController:(LMUFilterSelectionViewController*)fsvc;

@end
