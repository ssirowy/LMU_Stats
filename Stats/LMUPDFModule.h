//
//  LMUPDFModule.h
//  Stats
//
//  Created by Scott Sirowy on 8/13/12.
//
//

/**
 @Brief
 */

#import "LMUModule.h"

@interface LMUPDFModule : LMUModule

/**
 File name of PDF being displayed
 */
@property (nonatomic, copy, readonly) NSString* fileName;

@end
