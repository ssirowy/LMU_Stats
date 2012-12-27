//
//  LMUReportView.m
//  Stats
//
//  Created by Scott Sirowy on 8/6/12.
//
//

#import "LMUReportView.h"
#import "DTGridView.h"
#import "LMUGridCell.h"
#import "LMUReport.h"
#import "LMUHeader.h"
#import "LMUAttributedString.h"
#import "UIColor+LMUColors.h"
#import <QuartzCore/QuartzCore.h>

enum {
    kRowHeight = 44,
    };

@interface LMUReportView () <DTGridViewDataSource>

@property (nonatomic, assign) LMUHeader*    header;
@property (nonatomic, retain) UILabel*      headerLabel;
@property (nonatomic, retain) DTGridView*   gridView;

/*
 As described in LMU iPad Schema (N).  Describes the width of the first column.
 First column width should be 1/columnWidthRatio.  All other columns should consume (columnWidthRatio -1)/columnWidthRatio.
 Changes when in landscape or portrait
 */
@property (nonatomic, assign) NSUInteger    columnWidthRatio;

/*
 As described in LMU iPad Schema (M) Number of data columns that show.
 Changes when in lanscape or portrait
 */
@property (nonatomic, assign) NSUInteger    numberDataColumns;

- (LMUAttributedString*)gridValueForRow:(NSInteger)rowIndex column:(NSInteger)columnIndex;

- (void)updateRenderingConstants;

@end

@implementation LMUReportView

- (void)dealloc
{
    [_report        release];
    [_headerLabel   release];
    [_gridView      release];
    
    [super      dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame withHeader:nil withReport:nil];
}

- (id)initWithFrame:(CGRect)frame withHeader:(LMUHeader*)header withReport:(LMUReport*)report
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.header = header;
        
        //so custom header isn't called
        _report = [report retain];
        
        //set rendering constants before adding grid view
        [self updateRenderingConstants];
        
        //Header Label       
        UILabel* headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kRowHeight)];
        headerLabel.textAlignment = UITextAlignmentCenter;
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        self.headerLabel = headerLabel;
        [headerLabel release];
        
        LMUAttributedString* titleString = [LMUAttributedString attributedStringWithString:self.header.title];
        self.headerLabel.text = titleString.plainText;
        self.headerLabel.font = (titleString.italicized) ? [UIFont italicSystemFontOfSize:18.0f] : [UIFont systemFontOfSize:18.0f];
        
        //Internal Grid View drives whole report. Place directly below header
        CGRect gridViewFrame = self.bounds;
        gridViewFrame.origin.y += self.headerLabel.frame.size.height;
        gridViewFrame.size.height -= self.headerLabel.frame.size.height;
        DTGridView* gv = [[DTGridView alloc] initWithFrame:gridViewFrame];
        gv.dataSource = self;
        gv.backgroundColor = [UIColor clearColor];
        gv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.gridView = gv;
        [gv release];
        
        //Once we have grid view set up,  adjust header label so it directly over data
        CGRect headerLabelRect = self.headerLabel.frame;
        CGFloat pointWhereDataStarts = [self gridView:self.gridView widthForCellAtRow:0 column:0];
        headerLabelRect.origin.x = pointWhereDataStarts;
        headerLabelRect.size.width -= pointWhereDataStarts;
        self.headerLabel.frame = headerLabelRect;
        
        [self addSubview:self.headerLabel];
        [self addSubview:self.gridView];
        
        self.layer.shadowOffset  = CGSizeMake(2,2);
        self.layer.shadowOpacity = 0.7f;
        self.layer.shadowColor   = [[UIColor blackColor] CGColor];
        self.layer.shadowRadius  = 2;
    }
    
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.headerLabel.backgroundColor = backgroundColor;
    self.gridView.backgroundColor = backgroundColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateRenderingConstants];
    
    [self.gridView reloadData];
}

#pragma mark -
#pragma mark Custom Setter
- (void)setReport:(LMUReport*)report
{
    [_report autorelease];
    _report = [report retain];
    
    [self.gridView reloadData];
}

#pragma mark -
#pragma mark DTGridViewDataSource
- (NSInteger)numberOfRowsInGridView:(DTGridView *)gridView
{
    if (self.report.numberOfRows == 0)
    {
        return 0;
    }
    
    return (self.report.numberOfRows + 1);
}

- (NSInteger)numberOfColumnsInGridView:(DTGridView *)gridView forRowWithIndex:(NSInteger)index
{
    return (self.header.numValues + 1);
}

- (CGFloat)gridView:(DTGridView *)gridView heightForRow:(NSInteger)rowIndex
{
    //return gridView.frame.size.height/self.report.numberOfRows;
    return kRowHeight;
}

- (CGFloat)gridView:(DTGridView *)gridView widthForCellAtRow:(NSInteger)rowIndex column:(NSInteger)columnIndex
{
    CGFloat defaultColumnWidth = gridView.bounds.size.width/self.columnWidthRatio;
    
    if (columnIndex == 0)
    {
        return defaultColumnWidth;
    }

    
    NSUInteger columns = MIN(self.header.numValues, self.numberDataColumns);
    return (gridView.bounds.size.width-defaultColumnWidth)/columns; 
}

- (DTGridViewCell *)gridView:(DTGridView *)gridView viewForRow:(NSInteger)rowIndex column:(NSInteger)columnIndex
{
    static NSString* cellId = @"Cell";
    
    LMUGridCell *cell = (LMUGridCell*)[gridView dequeueReusableCellWithIdentifier:cellId];
	
	if (!cell)
    {
        cell = [[[LMUGridCell alloc] initWithReuseIdentifier:cellId] autorelease];
        cell.backgroundColor = [UIColor LMUBlueColor];
    }
    
    LMUAttributedString* attString = [self gridValueForRow:rowIndex column:columnIndex];
    
    cell.label.text = attString.plainText;
    cell.label.textAlignment = attString.textAlignment;
    cell.italicized = attString.underlined;
    
	return cell;
}

- (NSInteger)spacingBetweenRowsInGridView:(DTGridView *)gridView
{
    return 2;
}

- (NSInteger)spacingBetweenColumnsInGridView:(DTGridView *)gridView
{
    return 2;
}

#pragma mark -
#pragma mark Internal Methods
- (LMUAttributedString*)gridValueForRow:(NSInteger)rowIndex column:(NSInteger)columnIndex
{
    //Top Left. No text
    if (rowIndex == 0 && columnIndex == 0)
    {
        return nil;
    }
    //Need to grab values for column headers
    else if(rowIndex == 0)
    {
        return [self.header valueAtColumnIndex:columnIndex-1];
    }
    
    //Regular values. Pull from current stats (offset by 1 in column)
    return [self.report stringValueForRow:rowIndex-1 column:columnIndex];
}

- (void)updateRenderingConstants
{
    UIInterfaceOrientation  orientation = [UIDevice currentDevice].orientation;
    if(UIInterfaceOrientationIsPortrait(orientation))
    {
        self.columnWidthRatio = 3;
        self.numberDataColumns = 5;
    }
    //landscape
    else
    {
        self.columnWidthRatio = 4;
        self.numberDataColumns = 8;
    }
}


@end
