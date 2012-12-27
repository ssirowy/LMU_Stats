//-----------------------------------------------------------------------------
//
//  GMButton.m
//
// Created by Gary Morris on 3/12/11.
//
// Copyright 2011 Gary A. Morris. http://mggm.net
//
// This file is part of SDK_Utilities.repo
//
// This is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This file is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this file. If not, see <http://www.gnu.org/licenses/>.
//-----------------------------------------------------------------------------

#import "GMButton.h"

@implementation GMButton

#define kBevelInset (1.25f)      /* in pixels */
#define kCornerRadius (0.20f)   /* as a fraction of height */

- (void)dealloc {
	[bevelLayer release];
	[colorLayer release];
	[glossLayer release];
    
    [super dealloc];
}

-(id)initWithFrame:(CGRect)newFrame
{
    GMButton* button = [super initWithFrame:newFrame];
    
    if ((self = (id)button)) {
        // initialize
        button.frame = newFrame;
        [self awakeFromNib];
    }
    return self;

}

+(id)buttonWithFrame:(CGRect)newFrame
{
    GMButton* button = [super buttonWithType:UIButtonTypeCustom];
    
    if ((self = (id)button)) {
        // initialize
        button.frame = newFrame;
        [self awakeFromNib];
    }
    return self;
}

//----------------------------------------------------------------------------
// NOTE: background color and title must be set in IB (Interface Builder)
//----------------------------------------------------------------------------
-(void)awakeFromNib {
    [super awakeFromNib];
    
	// Initialization code
	CGRect  bounds  = self.bounds;
	CGFloat cRadius = bounds.size.height * kCornerRadius;
	
	self.autoresizesSubviews = YES;
	self.layer.masksToBounds = YES;
	self.layer.cornerRadius  = cRadius;	
	self.layer.needsDisplayOnBoundsChange = YES;

	// remove background color provided and save it in bgColors[]
    // (but don't overwrite bgColors if backgroundColor is not set)
    if (super.backgroundColor) {
        bgColors[stNormal] = [super.backgroundColor retain];  // retain, bypassing setter
    }
	
	//---------------------------
	// add bevel layer
	//---------------------------
	bevelLayer = [[CAGradientLayer layer] retain];
	bevelLayer.colors = [NSArray arrayWithObjects: (id)
						 [UIColor colorWithWhite:0.05f alpha:0.5f].CGColor,
						 [UIColor colorWithWhite:0.40f alpha:0.5f].CGColor, nil];
	bevelLayer.locations = [NSArray arrayWithObjects:
							[NSNumber numberWithFloat:0],
							[NSNumber numberWithFloat:1], nil];		
	bevelLayer.frame = bounds;
	bevelLayer.needsDisplayOnBoundsChange = YES;
	[self.layer addSublayer:bevelLayer];

	//---------------------------
	// add color layer
	//---------------------------
	colorLayer = [[CALayer layer] retain];
    
    CGColorRef colorRef = bgColors[stNormal] ? bgColors[stNormal].CGColor : nil;
	colorLayer.backgroundColor = colorRef;
    
	colorLayer.frame = CGRectInset(bounds, kBevelInset, kBevelInset);
	colorLayer.cornerRadius = cRadius - kBevelInset;
	colorLayer.needsDisplayOnBoundsChange = YES;
	super.layer.backgroundColor = colorLayer.backgroundColor;
	[self.layer addSublayer:colorLayer];

	//---------------------------
	// add gloss layer
	//---------------------------
	glossLayer = [[CAGradientLayer layer] retain];
	glossLayer.colors = [NSArray arrayWithObjects: (id)
						 [UIColor colorWithWhite:1.00f alpha:0.20f].CGColor,
                         ///[UIColor colorWithWhite:1.00f alpha:0.00f].CGColor,
						 [UIColor colorWithWhite:0.40f alpha:0.20f].CGColor, nil];
	glossLayer.locations = [NSArray arrayWithObjects:
							[NSNumber numberWithFloat:0],
                            ///[NSNumber numberWithFloat:0.5],
							[NSNumber numberWithFloat:1], nil];		
	glossLayer.frame        = colorLayer.frame;
	glossLayer.cornerRadius = colorLayer.cornerRadius;
	glossLayer.needsDisplayOnBoundsChange = YES;
	[self.layer addSublayer:glossLayer];
	
    [self bringSubviewToFront:self.imageView];
	[self bringSubviewToFront:self.titleLabel];
}

//----------------------------------------------------------------------------
// stateFromUIControlState -- converts state bit flags into StateType enum
//----------------------------------------------------------------------------
StateType stateFromUIControlState(UIControlState aState) 
{
	StateType result = stNormal;
	
	if (aState & UIControlStateDisabled) {
		result = stDisabled;
	} else if (aState & UIControlStateSelected) {
		result = stSelected;
	} else if (aState & UIControlStateHighlighted) {
		result = stHighlighted;
	}
	
	return result;
}

//----------------------------------------------------------------------------
// updateColorLayerForCurrentState
//----------------------------------------------------------------------------
-(void)updateColorLayerForCurrentState
{
	// we may have updated the color that applies to the current state
	UIColor* curStateColor = [self colorForState:self.state];
	
	colorLayer.backgroundColor = curStateColor==nil ? nil : curStateColor.CGColor;
    ///super.layer.backgroundColor = colorLayer.backgroundColor;
}

//----------------------------------------------------------------------------
// backgroundColorForState: -- returns one of the colors
//----------------------------------------------------------------------------
-(UIColor*)colorForState:(UIControlState)aState
{
	UIColor* color = bgColors[stateFromUIControlState(aState)];

	if (color==nil) {
		color = bgColors[stNormal];
	}
	
	return [[color retain] autorelease];
}

// override backgroundColor, use colorForState: instead
-(UIColor*)backgroundColor
{
    return [self colorForState:UIControlStateNormal];
}

//----------------------------------------------------------------------------
// setColor:forState:  -- sets the color for a states
//----------------------------------------------------------------------------
-(void)setColor:(UIColor *)newColor forState:(UIControlState)aState
{
	StateType curState = stateFromUIControlState(aState);
	
	[newColor retain];		// retain before release, in case it's the same obj
	[bgColors[curState] release];	
	bgColors[curState] = newColor;

	// we may have updated the color that applies to the current state
	[self updateColorLayerForCurrentState];
}

// override setBackgroundColor:, use setColor:forState: instead
-(void)setBackgroundColor:(UIColor *)newColor
{
    [self setColor:newColor forState:UIControlStateNormal];
}

//----------------------------------------------------------------------------
// Override state setter methods so we can update the colorLayer
// when there is a state change.  
//----------------------------------------------------------------------------
-(void)setSelected:(BOOL)newSelected
{
	if (super.isSelected != newSelected) {
		[super setSelected:newSelected];
		[self updateColorLayerForCurrentState];
	}
}

-(void)setEnabled:(BOOL)newEnabled
{
	if (super.isEnabled != newEnabled) {
		[super setEnabled:newEnabled];
        [self updateColorLayerForCurrentState];
	}
}

-(void)setHighlighted:(BOOL)newHighlighted
{
	if (super.isHighlighted != newHighlighted) {
		[super setHighlighted:newHighlighted];
        [self updateColorLayerForCurrentState];
	}
}

@end
