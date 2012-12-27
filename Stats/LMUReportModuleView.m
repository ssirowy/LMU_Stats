//
//  LMUModuleView.m
//  Stats
//
//  Created by Scott Sirowy on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LMUReportModuleView.h"
#import "LMUReportModule.h"
#import "LMUHeader.h"
#import "LMUFilter.h"
#import "LMUFilters.h"
#import "LMUFilterSelectionViewController.h"
#import "LMUReports.h"
#import "LMUReportView.h"
#import "GMButton.h"
#import "UIColor+LMUColors.h"

/*
  Constants for placing buttons
 */
enum {
    kMaxButtonsPerRow       = 2,
    kSpaceBetweenButtons    = 5,
    kButtonHeight           = 50,
    kTopMargin              = 50,
    kSideMargin             = 50,
    kReportViewMargin       = 23,
};

@interface LMUReportModuleView () <UITableViewDataSource, UITableViewDelegate, UIPopoverControllerDelegate, LMUFilterSelectionDelegate>
{
    CGFloat _buttonWidth;
}

@property (nonatomic, retain) UIPopoverController*  filterChoicePopover;
@property (nonatomic, retain) LMUReportView*        reportGrid;
@property (nonatomic, retain) LMUReport*            currentReport;
@property (nonatomic, retain) NSMutableArray*       buttons;

- (LMUReportModule*)reportModule;
- (void)filterButtonPressed:(UIButton*)sender;
- (void)refreshReportTable;

@end

@implementation LMUReportModuleView

@synthesize filterChoicePopover = _filterChoicePopover;
@synthesize reportGrid          = _reportGrid;
@synthesize currentReport       = _currentReport;
@synthesize buttons             = _buttons;

- (void)dealloc
{
    [_filterChoicePopover   release];
    [_buttons               release];
    [_reportGrid            release];
    [_currentReport         release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame withModule:(LMUReportModule*)module
{
    self = [super initWithFrame:frame withModule:module];
    if(self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat width = (frame.size.width - 2*kSideMargin);
        CGRect buttonViewRect = CGRectMake(kSideMargin, kTopMargin, width, 190.0);
        UIView* buttonView = [[UIView alloc] initWithFrame:buttonViewRect];
        buttonView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        
        buttonView.backgroundColor = [UIColor clearColor];
        
        _buttonWidth = (width - (module.filters.count-1)*kSpaceBetweenButtons)/kMaxButtonsPerRow;
        
        self.buttons = [NSMutableArray arrayWithCapacity:module.filters.count];
        for (int i = 0; i < module.filters.count; i++)
        {
            CGRect buttonRect = CGRectZero;
            buttonRect.origin = [self originForButtonAtIndex:i];
            buttonRect.size = CGSizeMake(_buttonWidth, kButtonHeight);
            
            //Tag button so we know what filter it is associated with
            LMUFilter* filter = [module.filters filterAtIndex:i];
            GMButton* button = [GMButton buttonWithFrame:buttonRect];
            [button setColor:[UIColor LMURedColor] forState:UIControlStateNormal];
            button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            button.tag = i;
            [button setTitle:[filter displayString] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
            [button addTarget:self action:@selector(filterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.buttons addObject:button];
            
            [buttonView addSubview:button];
        }
        
        
        [self addSubview:buttonView];
        [buttonView release];
        
        CGFloat statsOriginY = 1.5*kTopMargin + buttonView.frame.size.height;
        CGRect statsRect = CGRectMake(kReportViewMargin, statsOriginY, frame.size.width - 2*kReportViewMargin, frame.size.height - (statsOriginY + kReportViewMargin));
        
        LMUReportView* grid = [[LMUReportView alloc] initWithFrame:statsRect withHeader:self.reportModule.header withReport:nil];
        grid.backgroundColor = [UIColor LMUGreyColor];
        grid.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.reportGrid = grid;
        [grid release];
                
        [self addSubview:self.reportGrid];
        
        [self refreshReportTable];
    }
    
    return self;
}

//Returns index for button based on how many buttons can be on a given row
- (CGPoint)originForButtonAtIndex:(NSUInteger)index
{
    //calculate its frame here
    int row    = index / kMaxButtonsPerRow;
    int column = index % kMaxButtonsPerRow;
    
    //Assumes button width has been calculated elsewhere
    CGFloat xOrigin = (column * _buttonWidth) + //account for map icons
    ((column + 1) * kSpaceBetweenButtons);     //account for margins
    
    
    CGFloat yOrigin = (row * kButtonHeight) +   //account for map icons
    (row * kSpaceBetweenButtons);               //account for margins
    
    return CGPointMake(xOrigin, yOrigin);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //reset button width
    UIButton* button = [self.buttons objectAtIndex:0];
    _buttonWidth = button.frame.size.width;
}

- (LMUReportModule*)reportModule
{
    return (LMUReportModule*)self.module;
}

#pragma mark -
#pragma mark Button Press
- (void)filterButtonPressed:(UIButton*)sender
{
    LMUFilter* f = [self.reportModule.filters filterAtIndex:sender.tag];
    
    LMUFilterSelectionViewController *fsvc = [[LMUFilterSelectionViewController alloc] initWithFilter:f];
    fsvc.delegate = self;
    
    self.filterChoicePopover = [[[UIPopoverController alloc] initWithContentViewController:fsvc] autorelease];
    self.filterChoicePopover.delegate = self;
    [fsvc release];
    
    CGRect rect = [sender convertRect:sender.bounds toView:self];
    
    [self.filterChoicePopover presentPopoverFromRect:rect
                                              inView:self
                            permittedArrowDirections:UIPopoverArrowDirectionUp
                                            animated:YES];
}

#pragma mark -
#pragma mark UIPopoverController
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.filterChoicePopover = nil;
}

#pragma mark -
#pragma LMUFilterSelectionDelegate
- (void)filterSelectionViewController:(LMUFilterSelectionViewController *)fsvc didChooseFilterChoice:(NSString *)choice
{
    //get rid of popover
    [self.filterChoicePopover dismissPopoverAnimated:YES];
    self.filterChoicePopover = nil;
    
    //Change button string
    NSUInteger buttonIndex = [self.reportModule.filters indexOfFilter:fsvc.filter];
    UIButton* selectedButton = [self.buttons objectAtIndex:buttonIndex];
    [selectedButton setTitle:[fsvc.filter displayString] forState:UIControlStateNormal];
    
    [self refreshReportTable];
}

//Implement so we can popover the same width as button
- (CGFloat)desiredWidthForFilterSelectionViewController:(LMUFilterSelectionViewController*)fsvc
{
    return _buttonWidth;
}

#pragma mark -
#pragma mark Internal
- (void)refreshReportTable
{
    //build encoded filter string
    NSString *reportEncoding = [self.reportModule.filters filterAtIndex:0].selectedFilterEncoding;
    for(int i = 1; i < self.reportModule.filters.count; i++)
    {
        reportEncoding = [reportEncoding stringByAppendingFormat:@"_%@", [self.reportModule.filters filterAtIndex:i].selectedFilterEncoding];
    }
    
    NSLog(@"Report Encoding: %@", reportEncoding);
    self.reportGrid.report = [self.reportModule.reports reportForEncodedString:reportEncoding];
}

@end
