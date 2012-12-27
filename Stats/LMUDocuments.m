//
//  LMUDocuments.m
//  Stats
//
//  Created by Scott Sirowy on 12/27/12.
//
//

#import "LMUDocuments.h"

@interface LMUDocuments ()

/**
 Array of all LMUDocument's of type |pdf|
 */
@property (nonatomic, retain) NSArray* pdfs;

/**
 Array of all LMUDocument's of type |ppt|
 
 */
@property (nonatomic, retain) NSArray* ppts;

@end

@implementation LMUDocuments

- (void)dealloc
{
    [_pdfs  release];
    [_ppts  release];
    
    [super  dealloc];
}

- (id)initWithJSON:(NSDictionary *)json
{
    self = [super init];
    if (self) {
        NSLog(@"Initializing");
    }
    
    return self;
}

//Combines all document types into one number
- (NSUInteger)count
{
    return self.pdfs.count + self.ppts.count;
}

- (LMUDocument*)documentAtIndex:(NSUInteger)index
{
    return nil;
}

@end
