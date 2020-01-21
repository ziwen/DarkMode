//
//  CAShapeLayer+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "CAShapeLayer+Dark.h"
#import <UIKit/UIKit.h>
#import "UIColor+Dark.h"

@interface CAShapeLayer ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation CAShapeLayer (Dark)

- (UIColor *)dk_strokeColor {
    return [self.pickers objectForKey:NSStringFromSelector(@selector(setStrokeColor:))];
}

- (void)dk_setStrokeColor:(UIColor *)strokeColor {
     NSAssert(strokeColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.strokeColor = strokeColor.CGColor;
    [self.pickers setValue:strokeColor forKey:NSStringFromSelector(@selector(setStrokeColor:))];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_fillColor {
      return [self.pickers objectForKey:NSStringFromSelector(@selector(setFillColor:))];
}

- (void)dk_setFillColor:(UIColor *)fillColor {
     NSAssert(fillColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.fillColor = fillColor.CGColor;
    [self.pickers setValue:fillColor forKey:NSStringFromSelector(@selector(setFillColor:))];
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
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setStrokeColor:)) ]) {
                                 [self setStrokeColor:result];
                             } else if ([selector isEqualToString:NSStringFromSelector(@selector(setFillColor:)) ]) {
                                 [self setFillColor:result];
                             }
#pragma clang diagnostic pop
                         }];
    }];
}
@end
