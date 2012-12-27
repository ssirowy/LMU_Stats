//
//  LMUGridCell.h
//  Stats
//
//  Created by Scott Sirowy on 8/1/12.
//
//

/**
 @Brief
 */

#import "DTGridViewCell.h"

@interface LMUGridCell : DTGridViewCell

/**
 Label for given cell.
 TODO: Have string property instead that internally sets label?
 */
@property (nonatomic, retain, readonly) UILabel*    label;

/**
 Boolean to indicate whether to italicize label text
 */
@property (nonatomic, assign) BOOL      italicized;

@end
