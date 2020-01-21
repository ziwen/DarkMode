//
//  CALayer+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "CALayer+Dark.h"

#import <UIKit/UIKit.h>
#import "TMapDarkVersionManager.h"
#import "UIColor+Dark.h"

@interface CALayer ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, UIColor *> *pickers;

@end
@implementation CALayer (Dark)
- (UIColor *)dk_shadowColor {
    return [self.pickers objectForKey:NSStringFromSelector(@selector(setShadowColor:))];
}

- (void)dk_setShadowColor:(UIColor *)shadowColor {
     NSAssert(shadowColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.shadowColor = shadowColor.CGColor;
    [self.pickers setValue:shadowColor forKey:NSStringFromSelector(@selector(setShadowColor:))];
  [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_borderColor {
     return [self.pickers objectForKey:NSStringFromSelector(@selector(setBorderColor:))];
}

- (void)dk_setBorderColor:(UIColor *)borderColor {
     NSAssert(borderColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.borderColor = borderColor.CGColor;
    [self.pickers setValue:borderColor forKey:NSStringFromSelector(@selector(setBorderColor:))];
     [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_backgroundColor {
    return [self.pickers objectForKey:NSStringFromSelector(@selector(setBackgroundColor:))];
}

- (void)dk_setBackgroundColor:(UIColor *)backgroundColor {
    NSAssert(backgroundColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.backgroundColor = backgroundColor.CGColor;
    [self.pickers setValue:backgroundColor forKey:NSStringFromSelector(@selector(setBackgroundColor:))];
     [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (void)dk_updateTheme {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, UIColor *  _Nonnull picker, BOOL * _Nonnull stop) {
        CGColorRef result = [UIColor colorWithName:picker.colorName].CGColor;
        [UIView animateWithDuration:0.1
                         animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                             if ([selector isEqualToString:NSStringFromSelector(@selector(setShadowColor:))]) {
                                 [self setShadowColor:result];
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setBorderColor:))]) {
                                 [self setBorderColor:result];
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setBackgroundColor:)) ]) {
                                 [self setBackgroundColor:result];
                             }
#pragma clang diagnostic pop
                         }];
    }];
}

@end
