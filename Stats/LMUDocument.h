//
//  LMUDocument.h
//  Stats
//
//  Created by Scott Sirowy on 12/27/12.
//
//

/**
 @Brief  Represents one document on disk
 */

#import <Foundation/Foundation.h>

typedef enum
{
    LMUDocumentTypePDF = 0,
    LMUDocumentTypePPT,
    LMUDocumentTypeUnknown,
} LMUDocumentType;

@interface LMUDocument : NSObject

/**
 Title of document, for display purposes
 */
@property (nonatomic, copy, readonly) NSString* title;

/**
 Name of file on disk
 */
@property (nonatomic, copy, readonly) NSString* fileName;

/**
 Type of Document
 */
@property (nonatomic, assign, readonly) LMUDocumentType type;

/**
 Default initializer. Accepts a title, file name, and document type
 */
- (id)initWithTitle:(NSString*)title fileName:(NSString*)fileName type:(LMUDocumentType)type;

@end
