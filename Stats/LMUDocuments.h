//
//  LMUDocuments.h
//  Stats
//
//  Created by Scott Sirowy on 12/27/12.
//
//

/**
 @Brief
 */

#import <Foundation/Foundation.h>
#import "LMUCoding.h"

@class LMUDocument;

@interface LMUDocuments : NSObject <LMUCoding>

/**
 Returns total number of documents. Use in same way as [NSArray count].
 */
- (NSUInteger)count;

/**
 Returns LMUDocument at specified index
 */
- (LMUDocument*)documentAtIndex:(NSUInteger)index;

@end
