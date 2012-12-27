//
//  LMUFilterSelectionViewController.m
//  Stats
//
//  Created by Scott Sirowy on 6/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LMUFilterSelectionViewController.h"
#import "LMUFilters.h"
#import "LMUFilter.h"

@interface LMUFilterSelectionViewController ()

@property (nonatomic, retain, readwrite) LMUFilter* filter;

@end

@implementation LMUFilterSelectionViewController

@synthesize delegate    = _delegate;
@synthesize filter      = _filter;

- (void)dealloc
{
    [_filter    release];
    [super      dealloc];
}

- (id)initWithFilter:(LMUFilter *)filter
{
    self = [super init];
    if(self)
    {
        self.filter  = filter;
    }
    
    return self;
}

- (void)loadView
{ 
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 200) style:UITableViewStylePlain];
    tv.delegate = self;
    tv.dataSource = self;
    
    self.view = tv;
    [tv release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (CGSize)contentSizeForViewInPopover
{
    CGSize contentSize = self.view.bounds.size;
    if ([self.delegate respondsToSelector:@selector(desiredWidthForFilterSelectionViewController:)]) {
        contentSize.width = [self.delegate desiredWidthForFilterSelectionViewController:self];
    }
    
    return contentSize;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filter.numberOfChoices;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"Filter Choice Id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    NSString *choiceName = [self.filter choiceNameAtIndex:indexPath.row];
    
    cell.textLabel.text = choiceName;
    
    //Show which one is selected. If it matches selected, show a checkmark, else show nothing
    cell.accessoryType = [choiceName isEqualToString:self.filter.selectedFilterString] ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone; 
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //Controller is taking the onus of updating the filter's selected choice
    self.filter.selectedFilterString = [self.filter choiceNameAtIndex:indexPath.row];
    
    if([self.delegate respondsToSelector:@selector(filterSelectionViewController:didChooseFilterChoice:)])
    {
        [self.delegate filterSelectionViewController:self didChooseFilterChoice:self.filter.selectedFilterString];
    }
}


@end
