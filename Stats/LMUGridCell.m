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
        
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:18.0f];
        _label.textColor = [UIColor whiteColor];
        [_label sizeToFit];
        _label.textAlignment = UITextAlignmentCenter;
        
        [self addSubview:_label];
        
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
