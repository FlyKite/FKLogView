//
//  FKLogView.m
//  FKLogView
//
//  Created by FlyKite on 2018/5/26.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import "FKLogView.h"
#import "FKLogCell.h"
#import "FKLog+CellHeight.h"

#define CELL_ID @"log_cell"

@protocol FKLogViewAppearanceDelegate
- (void)logViewAppearanceChanged;
@end

@interface FKLogView()<UITableViewDataSource, UITableViewDelegate, FKLogViewAppearanceDelegate>
@property (strong, nonatomic) NSMutableArray<FKLog *> *logs;
@property (strong, nonatomic) UITableView *logView;
@end

@interface FKLogViewAppearance()
@property (weak, nonatomic, setter=changeDelegate:) id<FKLogViewAppearanceDelegate> delegate;
@end

@implementation FKLogView

+ (instancetype)sharedLogView {
    static FKLogView *view;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[super allocWithZone:NULL] init];
    });
    return view;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [FKLogView sharedLogView];
}

- (id)copyWithZone:(struct _NSZone *)zone {
    return [FKLogView sharedLogView];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _logs = [NSMutableArray array];
        _appearance = [[FKLogViewAppearance alloc] init];
        _appearance.delegate = self;
        _enabled = YES;
        _maximumLogItemCount = 1000;
        self.backgroundColor = self.appearance.backgroundColor;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _logView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [_logView registerClass:FKLogCell.class forCellReuseIdentifier:CELL_ID];
    _logView.dataSource = self;
    _logView.delegate = self;
    _logView.backgroundColor = self.appearance.backgroundColor;
    _logView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_logView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.logView.frame = self.bounds;
}

// MARK: - Show and hide
- (void)showInWindow:(UIWindow *)window {
    [self resignFirstResponderInView:window];
    
    [window addSubview:self];
    
    CGRect frame = window.bounds;
    frame.origin.y = frame.size.height;
    self.frame = frame;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = window.bounds;
    }];
}

- (void)show {
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *window;
    if ([app.delegate respondsToSelector:@selector(window)]) {
        window = [app.delegate window];
    } else {
        window = [app keyWindow];
    }
    if (window) {
        [self showInWindow:window];
    }
}

- (BOOL)resignFirstResponderInView:(UIView *)view {
    if ([view isFirstResponder]) {
        return [view resignFirstResponder];
    }
    for (UIView *subview in view.subviews) {
        if ([self resignFirstResponderInView:subview]) {
            return YES;
        }
    }
    return NO;
}

- (void)hide {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.bounds;
        frame.origin.y = frame.size.height;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// MARK: - FKLoggerHandler
- (void)handleLog:(FKLog *)log {
    if (!self.enabled) {
        return;
    }
    [self.logs addObject:log];
    [self.logView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.logs.count - 1 inSection:0];
    [self.logView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.logView endUpdates];
}

// MARK: - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.logs.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FKLog *log = self.logs[indexPath.row];
    CGFloat textHeight = [log textHeightForCellWidth:tableView.bounds.size.width
                                                font:self.appearance.font];
    return textHeight + self.appearance.logInterval;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FKLogCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    [cell updateLog:self.logs[indexPath.row] withAppearnce:self.appearance];
    return cell;
}

// MARK: - FKLogViewAppearanceDelegate
- (void)logViewAppearanceChanged {
    self.backgroundColor = self.appearance.backgroundColor;
    self.logView.backgroundColor = self.appearance.backgroundColor;
    [self.logView reloadData];
}

@end
