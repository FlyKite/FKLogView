//
//  FKLogViewAppearance.h
//  FKLogView
//
//  Created by FlyKite on 2018/5/26.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FKLogViewAppearance : NSObject

/**
 Font of logs in FKLoggerView, default is [UIFont systemFontOfSize:15]
 */
@property (strong, nonatomic) UIFont *font;

/**
 Interval between cells, default is 8.
 */
@property (assign, nonatomic) CGFloat logInterval;

/**
 Background color of FKLoggerView, default is black.
 */
@property (strong, nonatomic) UIColor *backgroundColor;

/**
 Color of log header, default is darkGray.
 */
@property (strong, nonatomic) UIColor *logHeaderColor;

/**
 Color of verbose logs, default is lightGray.
 */
@property (strong, nonatomic) UIColor *verboseTextColor;

/**
 Color of debug logs, default is blue.
 */
@property (strong, nonatomic) UIColor *debugTextColor;

/**
 Color of info logs, default is green.
 */
@property (strong, nonatomic) UIColor *infoTextColor;

/**
 Color of warning logs, default is yellow.
 */
@property (strong, nonatomic) UIColor *warningTextColor;

/**
 Color of error logs, default is red.
 */
@property (strong, nonatomic) UIColor *errorTextColor;

@end
