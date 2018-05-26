//
//  FKLog+CellHeight.h
//  FKLogView
//
//  Created by FlyKite on 2018/5/26.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FKLog.h"

@interface FKLog (CellHeight)
- (CGFloat)textHeightForCellWidth:(CGFloat)width font:(UIFont *)font;
@end
