//
//  LMUCoding.h
//  Stats
//
//  Created by Scott Sirowy on 12/27/12.
//
//

/**
 @brief Anything defined in files on disk can be initiliazed with JSON representatons
 
 */

#import <Foundation/Foundation.h>

@protocol LMUCoding <NSObject>

- (id)initWithJSON:(NSDictionary*)json;

@end
