//
//  FKLogView.h
//  FKLogView
//
//  Created by FlyKite on 2018/5/26.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FKLogger.h"
#import "FKLogViewAppearance.h"

@interface FKLogView : UIView<FKLoggerHandler>

+ (instancetype)sharedLogView;

/**
 Appearance of FKLoggerView
 */
@property (readonly, strong, nonatomic) FKLogViewAppearance *appearance;

/**
 Enable log output, default is YES
 */
@property (assign, nonatomic) BOOL enabled;

/**
 Defaults to 1000
 */
@property (assign, nonatomic) NSUInteger maximumLogItemCount;

/**
 Show FKLogView in target window
 
 @param window target window
 */
- (void)showInWindow:(UIWindow *)window;

/**
 Find the window which is key and visible
 Show FKLogView in this window
 */
- (void)show;

/**
 Hide FKLogView and remove from window
 */
- (void)hide;

@end
