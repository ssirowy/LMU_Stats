//
//  LMUModuleView.m
//  Stats
//
//  Created by Scott Sirowy on 8/14/12.
//
//

#import "LMUModuleView.h"

@implementation LMUModuleView

@synthesize module   = _module;

- (void)dealloc
{
    [_module    release];
    [super      dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame withModule:nil];
}

- (id)initWithFrame:(CGRect)frame withModule:(LMUModule*)module
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _module = [module retain];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    
    return self;
}

@end
