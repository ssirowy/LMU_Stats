//
//  LMULibraryModule.m
//  Stats
//
//  Created by Scott Sirowy on 12/27/12.
//
//

#import "LMULibraryModule.h"

@implementation LMULibraryModule

- (void)dealloc
{
    [_documents release];
    [super      dealloc];
}

@end
