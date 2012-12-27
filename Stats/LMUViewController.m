//
//  LMUViewController.m
//  Stats
//
//  Created by Scott Sirowy on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LMUViewController.h"
#import "LMUSlideOutView.h"
#import "UIColor+LMUColors.h"

#import "LMUModule.h"
#import "LMUReportModule.h"
#import "LMUPDFModule.h"

#import "LMUModuleView.h"

#import <QuartzCore/QuartzCore.h>

@interface LMUViewController () <SlideOutViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) LMUSlideOutView*  slideOutView;
@property (nonatomic, retain) UITableView*      tableView;

@property (nonatomic, retain) NSArray*          modules;
@property (nonatomic, retain) LMUModule*        currentModule;
@property (nonatomic, retain) LMUModuleView*    moduleView;

- (void)showCurrentModuleAnimated:(BOOL)animated;
- (void)hideCurrentModuleAnimated:(BOOL)animated;

@end

@implementation LMUViewController

- (void)dealloc
{
    [_navBar        release];
    [_navItem       release];
    [_contentView   release];
    [_logoView      release];
    [_slideOutView  release];
    [_tableView     release];
    [_modules       release];
    [_currentModule release];
    [_moduleView    release];
    
    [super dealloc];
}

- (id)initWithModules:(NSArray *)modules
{
    self = [super initWithNibName:@"LMUViewController" bundle:nil];
    if(self)
    {
        self.modules = modules;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navBar.tintColor = [UIColor LMURedColor];
    self.navItem.title = @"LMU Official Statistics";
        
    [self.view addSubview:self.slideOutView];
    self.slideOutView.inputView = self.tableView;

    self.currentModule = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"Frame: %@", NSStringFromCGRect(self.contentView.frame));
}

#pragma mark -
#pragma mark Lazy Loads
-(LMUSlideOutView *)slideOutView
{
    if(_slideOutView == nil)
    {
        CGRect fsv = CGRectMake(0, self.contentView.frame.origin.y, self.view.frame.size.width, self.contentView.frame.size.height);
        
        //initializing slide out with the container that the map view is in. This will ensure
        //all elements with the map view also resize properly
        self.slideOutView = [[[LMUSlideOutView alloc]initWithFrame:fsv adjacentView:self.contentView]autorelease];
        _slideOutView.delegate = self;
    }
    
    return _slideOutView; 
}

- (UITableView *)tableView
{
    if(_tableView == nil)
    {
        UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) style:UITableViewStylePlain];
        tv.dataSource = self;
        tv.delegate   = self;
        self.tableView = tv;
        [tv release];
    }
    
    return _tableView;
}

#pragma mark -
#pragma mark Slide Out View Delegate
-(void)slideOutViewShouldToggle:(LMUSlideOutView *)slideView
{
    if (slideView.expanded) {
        [slideView setExpanded:NO animated:YES];
    }
    else {
        [self hideCurrentModuleAnimated:YES];
    }
    
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modules.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
        cell.textLabel.textColor = [UIColor LMUBlueColor];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    LMUModule   *module = [self.modules objectAtIndex:indexPath.row];
    cell.textLabel.text = module.title;
    cell.imageView.image = module.icon;
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.currentModule = [self.modules objectAtIndex:indexPath.row];
    
    [self showCurrentModuleAnimated:YES];
}

- (void)showCurrentModuleAnimated:(BOOL)animated
{
    [self.slideOutView setExpanded:NO animated:animated];
    self.navItem.title = self.currentModule.title;
    
    CGFloat time = (animated) ? 0.5 : 0.0f;
    
    //Use dynamic creation to create the proper module view class
    NSString* viewClassName = [NSString stringWithFormat:@"%@View", [self.currentModule class]];
    Class viewClass = NSClassFromString(viewClassName);
    
    //Make sure we have one
    if (viewClass) {
        self.moduleView = [[[viewClass alloc] initWithFrame:self.contentView.bounds withModule:self.currentModule] autorelease];
        self.moduleView.alpha = 0.0;
        [self.contentView addSubview:self.moduleView];
        
        [UIView animateWithDuration:time animations:^
         {
             self.logoView.alpha = 0.0;
         }
                         completion:^(BOOL completed)
         {
             [UIView animateWithDuration:time animations:^
              {
                  self.moduleView.alpha = 1.0f;
              }
              ];
         }
         ];
    }
    else{
        NSLog(@"No class name called %@", viewClassName);
    }
}

- (void)hideCurrentModuleAnimated:(BOOL)animated
{
    [self.slideOutView setExpanded:YES animated:animated];
    self.navItem.title = @"LMU Official Statistics";
    
    CGFloat time = (animated) ? 0.5 : 0.0f;
    
    [UIView animateWithDuration:time animations:^
     {
         self.moduleView.alpha = 0.0;
     }
     completion:^(BOOL completed)
     {
         [self.moduleView removeFromSuperview];
         self.moduleView     = nil;
         
         [UIView animateWithDuration:time animations:^
          {
              self.logoView.alpha = 1.0;
          }
          ];
         
     }
     ];
    
    self.currentModule = nil;
}

@end
