//
//  FKLogViewAppearance.m
//  FKLogView
//
//  Created by FlyKite on 2018/5/26.
//  Copyright © 2018年 Doge Studio. All rights reserved.
//

#import "FKLogViewAppearance.h"
#import <objc/runtime.h>

@protocol FKLogViewAppearanceDelegate
- (void)logViewAppearanceChanged;
@end

@interface FKLogViewAppearance()
@property (weak, nonatomic, setter=changeDelegate:) id<FKLogViewAppearanceDelegate> delegate;
@end

@implementation FKLogViewAppearance

+ (void)load {
    [super load];
    unsigned int outCount = 0;
    objc_property_t *property_list = class_copyPropertyList(self.class, &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
        objc_property_t property = property_list[i];
        const char *property_name = property_getName(property);
        
        NSString *pName = [NSString stringWithUTF8String:property_name];
        NSString *setterName = [NSString stringWithFormat:@"set%@%@:", [pName substringToIndex:1].uppercaseString, [pName substringFromIndex:1]];
        NSString *fkSetterName = [NSString stringWithFormat:@"fk_%@:", setterName];
        
        SEL setter = NSSelectorFromString(setterName);
        SEL fkSetter = NSSelectorFromString(fkSetterName);
        
        Method method1 = class_getInstanceMethod(self.class, setter);
        if (method1 == NULL) {
            continue;
        }
        
        class_addMethod(self.class, fkSetter, (IMP)fk_setter, "v@:@");
        Method method2 = class_getInstanceMethod(self.class, fkSetter);
        
        method_exchangeImplementations(method1, method2);
    }
}

void fk_setter(id self, SEL _cmd, id var) {
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *fkSetterName = [NSString stringWithFormat:@"fk_%@:", setterName];
    SEL fkSetter = NSSelectorFromString(fkSetterName);
    [self performSelector:fkSetter withObject:var];
    [self performSelector:@selector(appearanceChanged) withObject:nil];
}

- (instancetype)init {
    if (self = [super init]) {
        _font = [UIFont systemFontOfSize:15];
        _logInterval = 8;
        _backgroundColor = UIColor.blackColor;
        _logHeaderColor = UIColor.darkGrayColor;
        _verboseTextColor = UIColor.lightGrayColor;
        _debugTextColor = [UIColor colorWithRed:0 green:0.627 blue:0.745 alpha:1];
        _infoTextColor = [UIColor colorWithRed:0.514 green:0.753 blue:0.341 alpha:1];
        _warningTextColor = [UIColor colorWithRed:1 green:0.913 blue:0 alpha:1];
        _errorTextColor = UIColor.redColor;
    }
    return self;
}

- (void)changeDelegate:(id<FKLogViewAppearanceDelegate>)delegate {
    _delegate = delegate;
}

- (void)appearanceChanged {
    [self.delegate logViewAppearanceChanged];
}

@end
