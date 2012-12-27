//
//  LMUDocument.m
//  Stats
//
//  Created by Scott Sirowy on 12/27/12.
//
//

#import "LMUDocument.h"

@implementation LMUDocument

- (void)dealloc
{
    [_title     release];
    [_fileName  release];
    
    [super      dealloc];
}

/**
 Default initializer. Accepts a title, file name, and document type
 */
- (id)initWithTitle:(NSString*)title fileName:(NSString*)fileName type:(LMUDocumentType)type
{
    self = [super init];
    if(self){
        _title      = [title copy];
        _fileName   = [fileName copy];
        _type       = type;
    }
    
    return self;
}

@end
