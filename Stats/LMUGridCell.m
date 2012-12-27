//
//  LMUGridCell.m
//  Stats
//
//  Created by Scott Sirowy on 8/1/12.
//
//

#import "LMUGridCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation LMUGridCell

- (void)dealloc
{
    [_label release];
    [super  dealloc];
}

- (id)initWithReuseIdentifier:(NSString *)identifier
{
    self = [super initWithReuseIdentifier:identifier];
    if(self)
    {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        UILabel* l = [[UILabel alloc] initWithFrame:CGRectZero];
        l.backgroundColor = [UIColor clearColor];
        l.font = [UIFont systemFontOfSize:18.0f];
        l.textColor = [UIColor whiteColor];
        [l sizeToFit];
        l.textAlignment = UITextAlignmentCenter;
        self.label = l;
        [l release];
        
        [self addSubview:self.label];
        
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = self.bounds;
    self.label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;        
}

- (void)setItalicized:(BOOL)italicized
{
    _italicized = italicized;
    self.label.font = italicized ? [UIFont italicSystemFontOfSize:18.0f] : [UIFont systemFontOfSize:18.0f];
}
@end
