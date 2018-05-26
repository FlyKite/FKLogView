//
//  FKLogCell.m
//  FKLogView
//
//  Created by FlyKite on 2018/5/26.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import "FKLogCell.h"

@interface FKLogCell()
@property (strong, nonatomic) UILabel *logLabel;
@end

@implementation FKLogCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _logLabel = [[UILabel alloc] init];
    _logLabel.numberOfLines = 0;
    [self addSubview:_logLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.logLabel.frame = self.bounds;
}

- (void)updateLog:(FKLog *)log withAppearnce:(FKLogViewAppearance *)appearance {
    self.backgroundColor = appearance.backgroundColor;
    switch (log.logLevel) {
        case FKLogLevelVerbose:
            self.logLabel.textColor = appearance.verboseTextColor;
            break;
        case FKLogLevelDebug:
            self.logLabel.textColor = appearance.debugTextColor;
            break;
        case FKLogLevelInfo:
            self.logLabel.textColor = appearance.infoTextColor;
            break;
        case FKLogLevelWarning:
            self.logLabel.textColor = appearance.warningTextColor;
            break;
        case FKLogLevelError:
            self.logLabel.textColor = appearance.errorTextColor;
            break;
        default:
            self.logLabel.textColor = appearance.verboseTextColor;
            break;
    }
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:log.description];
    [text addAttribute:NSForegroundColorAttributeName
                 value:appearance.logHeaderColor
                 range:NSMakeRange(0, log.logHeader.length)];
    self.logLabel.attributedText = text;
    self.logLabel.font = appearance.font;
}

@end
