//
//  LMUViewController.h
//  Stats
//
//  Created by Scott Sirowy on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/**
 @Brief
 */

#import <UIKit/UIKit.h>

@interface LMUViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIView*              contentView;
@property (nonatomic, retain) IBOutlet UINavigationBar*     navBar;
@property (nonatomic, retain) IBOutlet UINavigationItem*    navItem;
@property (nonatomic, retain) IBOutlet UIImageView*         logoView;

- (id)initWithModules:(NSArray *)modules;

@end
