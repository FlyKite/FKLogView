//
//  FKLogCell.h
//  FKLogView
//
//  Created by FlyKite on 2018/5/26.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FKLog.h"
#import "FKLogViewAppearance.h"

@interface FKLogCell : UITableViewCell
- (void)updateLog:(FKLog *)log withAppearnce:(FKLogViewAppearance *)appearance;
@end
