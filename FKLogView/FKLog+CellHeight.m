//
//  FKLog+CellHeight.m
//  FKLogView
//
//  Created by FlyKite on 2018/5/26.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import "FKLog+CellHeight.h"
#import <objc/runtime.h>

static NSString *widthKey = @"width";
static NSString *heightKey = @"height";

@implementation FKLog (CellHeight)

- (CGFloat)textHeightForCellWidth:(CGFloat)width font:(UIFont *)font {
    NSNumber *currentWidth = [self currentCellWidth];
    if ([currentWidth isEqualToNumber:@(width)]) {
        NSNumber *height = [self textHeight];
        if (height) {
            return CGFLOAT_IS_DOUBLE ? [height doubleValue] : [height floatValue];
        }
    }
    CGSize targetSize = CGSizeMake(width, MAXFLOAT);
    CGRect bounds = [self.description boundingRectWithSize:targetSize
                                                   options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName : font}
                                                   context:nil];
    CGFloat height = ceil(bounds.size.height);
    [self setCurrentCellWidth:width];
    [self setTextHeight:height];
    return height;
}

- (NSNumber *)currentCellWidth {
    return objc_getAssociatedObject(self, &widthKey);
}

- (void)setCurrentCellWidth:(CGFloat)width {
    objc_setAssociatedObject(self, &widthKey, @(width), OBJC_ASSOCIATION_COPY);
}

- (NSNumber *)textHeight {
    return objc_getAssociatedObject(self, &heightKey);
}

- (void)setTextHeight:(CGFloat)height {
    objc_setAssociatedObject(self, &heightKey, @(height), OBJC_ASSOCIATION_COPY);
}

@end
