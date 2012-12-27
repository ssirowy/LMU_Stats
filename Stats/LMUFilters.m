//
//  LMUFilters.m
//  Stats
//
//  Created by Scott Sirowy on 5/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LMUFilters.h"
#import "LMUFilter.h"

@interface LMUFilters () 

@property (nonatomic, retain, readwrite) NSArray*   filters;

@end

@implementation LMUFilters

- (void)dealloc
{
    [_filters   release];
    
    [super dealloc];
}

- (id)initWithJSON:(NSDictionary *)json
{
    self = [super init];
    if(self)
    {
        NSMutableArray *filterArray = [NSMutableArray arrayWithCapacity:json.allKeys.count];
        for (NSString *filterTitle in json.allKeys)
        {
            LMUFilter *f = [[LMUFilter alloc] initWithTitle:filterTitle filterChoices:[json objectForKey:filterTitle]];
            [filterArray addObject:f];
            [f release];
        }
        
        self.filters = filterArray;
    }
    
    return self;
}

- (NSUInteger)count
{
    return self.filters.count;
}

- (LMUFilter *)filterAtIndex:(NSUInteger)index
{
    if (index >= self.filters.count) {
        return nil;
    }
    
    return [self.filters objectAtIndex:index];
}

- (NSUInteger)indexOfFilter:(LMUFilter*)filter
{
    return [self.filters indexOfObject:filter];
}

@end