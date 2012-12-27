//
//  LMUViewController.h
//  Stats
//
//  Created by Scott Sirowy on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

/**
 @Brief Main view controller container
 */

#import <UIKit/UIKit.h>

@interface LMUViewController : UIViewController

//TODO:  Remove all IBOutlets and programatically create UI

/**
 The main content view for the app
 */
@property (nonatomic, retain) IBOutlet UIView*              contentView;

/**
 Main UINavigationBar on top of screen
 */
@property (nonatomic, retain) IBOutlet UINavigationBar*     navBar;

/**
 Main UINavigationItem in |navBar|
 */
@property (nonatomic, retain) IBOutlet UINavigationItem*    navItem;

/**
 Logo view that shows our main logo
 */
@property (nonatomic, retain) IBOutlet UIImageView*         logoView;

/**
 Default initializer. Accepts an array of modules
 */
- (id)initWithModules:(NSArray*)modules;

@end
