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

/**
 Filter that will be represented by view in view controller
 */
@property (nonatomic, retain, readonly) LMUFilter*              filter;

/**
 Filter Selection Delegate
 */
@property (nonatomic, assign) id<LMUFilterSelectionDelegate>    delegate;

- (id)initWithFilter:(LMUFilter *)filter;

@end

/**
 Filter Selection delegate informs deletgate when a filter choice has been picked. 
 A delegate can also defined the desired width of view controller
 */
@protocol LMUFilterSelectionDelegate <NSObject>

@optional

/**
 Lets delegate know which choice has been picked
 */
- (void)filterSelectionViewController:(LMUFilterSelectionViewController *)fsvc didChooseFilterChoice:(NSString *)choice;

/**
 Requests from delegate a desired width for view controller view
 */
- (CGFloat)desiredWidthForFilterSelectionViewController:(LMUFilterSelectionViewController*)fsvc;

@end
