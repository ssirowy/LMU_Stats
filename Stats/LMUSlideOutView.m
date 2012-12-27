//
//  LMUSlideOutView.m
//  
//
//  Created by Scott Sirowy


#import "LMUSlideOutView.h"

@interface LMUSlideOutView ()
{
	CGSize  _margin;
	CGFloat _inputWidth;
}

@property (nonatomic, retain) UIButton*     slideButton;
@property (nonatomic, retain) UIImageView*  whiteTriangleView;
@property (nonatomic, retain) UIView*       contentView;
@property (nonatomic, assign) UIView*       adjacentView;

@end

@implementation LMUSlideOutView

@synthesize contentView         = _contentView;
@synthesize inputView           = _inputView;
@synthesize expanded            = _expanded;
@synthesize slideButton         = _slideButton;
@synthesize whiteTriangleView   = _whiteTriangleView;
@synthesize adjacentView        = _adjacentView;
@synthesize delegate            = _delegate;

static float kMaximumContentViewWidth = 320.0;
static float kExpansionAnimationLength = 0.5;

- (void)dealloc
{
    [_contentView       release];
    [_inputView         release];
    [_slideButton       release];
    [_whiteTriangleView release];
    
    [super dealloc];
}

-(id)initWithFrame:(CGRect)frame adjacentView:(UIView *)view
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.adjacentView = view;
        
		_expanded = NO;
		
		_margin = CGSizeMake(2, 0);
		
		self.backgroundColor = [UIColor clearColor];
        
		// main view. Account for the margin since we want the contentView
        //to be 320 in width and set nice with a margin
        CGFloat width = kMaximumContentViewWidth + (2*_margin.width);
        
        // slide button
		self.slideButton = [UIButton buttonWithType:UIButtonTypeCustom];
		self.slideButton.frame =  CGRectMake(width, 0, 30, 90);    
        [self.slideButton setImage:[UIImage imageNamed:@"ModulesTab.png"] forState:UIControlStateNormal];
        
		[self.slideButton addTarget:self action:@selector(slideButtonTapped) forControlEvents:UIControlEventTouchUpInside];
		self.slideButton.center = CGPointMake(width + self.slideButton.frame.size.width/2, self.frame.size.height/2);
		self.slideButton.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        
        //White triangle
        self.whiteTriangleView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WhiteTriangle.png"]] autorelease];
        self.whiteTriangleView.frame = CGRectMake(4, 39, 8, 13);
        [self.slideButton addSubview:self.whiteTriangleView];
        
        //hide it just off screen
		CGRect f = CGRectMake(-width, frame.origin.y, width + self.slideButton.frame.size.width, frame.size.height);
		self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
		self.frame = f;
		
		// contentView
		CGRect fcv = CGRectMake(0, 0, width, self.frame.size.height);
		self.contentView = [[[UIView alloc] initWithFrame:fcv]autorelease];
		self.contentView.backgroundColor = [UIColor colorWithRed:(121.0f/255.0f) green:(123.0f/255.0f) blue:(125.0f/255.0f) alpha:0.7f];
		self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
		
		// add subviews
		[self addSubview:self.contentView];
        [self addSubview:self.slideButton];
    }
    return self;
}

-(void)slideButtonTapped{
	if([self.delegate respondsToSelector:@selector(slideOutViewShouldToggle:)])
    {
        [self.delegate slideOutViewShouldToggle:self];
    }
}

-(void)setExpanded:(BOOL)expanded animated:(BOOL)animated
{
    if (_expanded == expanded)
        return;
    
	_expanded = expanded;
	
	if (_expanded){
        
        if(animated)
        {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [UIView setAnimationDuration:kExpansionAnimationLength];
        }
        
        //doesn't account for the button width, which we want to keep overlayed on map
        CGFloat width = kMaximumContentViewWidth + (2*_margin.width);
        
        self.frame = CGRectMake(0, self.frame.origin.y, self.frame.size.width, self.frame.size.height);        
        self.adjacentView.frame = CGRectMake(width, self.adjacentView.frame.origin.y, self.adjacentView.frame.size.width - width, self.adjacentView.frame.size.height);
        
        if (animated) {
            [UIView commitAnimations];
        }
        
        self.whiteTriangleView.transform = CGAffineTransformMakeScale(-1, 1);
        
	}
	else {
		
        if (animated) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:.5];
        }
		
		self.contentView.alpha = 0;
        
        CGFloat width = kMaximumContentViewWidth + (2*_margin.width);
        
		self.frame = CGRectMake(-width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        
        CGRect newFrame = CGRectMake(0, self.adjacentView.frame.origin.y, self.adjacentView.superview.bounds.size.width, self.adjacentView.frame.size.height);
        self.adjacentView.frame = newFrame;
		
		if (animated) {
            [UIView commitAnimations];
        }
        
        self.whiteTriangleView.transform = CGAffineTransformIdentity;
	}

}

//allows to pass through touches only when needed. Limiting touches to subviews whose alpha > 0
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    for (UIView *view in self.subviews)
    {
        if([view pointInside:[self convertPoint:point toView:view] withEvent:event] && view.alpha != 0){
            return YES;
        }
    }
    
    return NO;
}

-(void)setInputView:(UIView*)inputView
{
	
	if (_inputView){
		[_inputView removeFromSuperview];
	}
	
	[_inputView autorelease];
	_inputView = [inputView retain];
	
	_inputView.frame = CGRectMake(_margin.width, _margin.height, _inputView.frame.size.width, self.frame.size.height - (2*_margin.height));
	[self insertSubview:_inputView atIndex:1]; // insert below button
	
	[self setExpanded:self.expanded animated:NO];
}


@end
