//
//  UILabel+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "UILabel+Dark.h"

#import <UIKit/UIKit.h>
#import "UIColor+Dark.h"

@interface UILabel()
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end
@implementation UILabel (Dark)
//- (void)didMoveToSuperview {
//    if (self.backgroundColor.colorName.length || self.shadowColor.colorName.length || self.textColor.colorName.length || self.tintColor.colorName.length) {
//        [[TMapDarkVersionManager shareManager] addToHashTable:self];
//    }
//}

- (void)dk_setBackgroundColor:(UIColor *)backgroundColor {
    NSAssert(backgroundColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.backgroundColor = backgroundColor;
    [self.pickers setObject:backgroundColor forKey:@"setBackgroundColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_backgroundColor {
    return self.backgroundColor;
}

- (void)dk_setShadowColor:(UIColor *)shadowColor {
    NSAssert(shadowColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.shadowColor = shadowColor;
    [self.pickers setObject:shadowColor forKey:@"setShadowColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_shadowColor {
    return self.shadowColor;
}

- (void)dk_setTextColor:(UIColor *)textColor {
    NSAssert(textColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.textColor = textColor;
    [self.pickers setObject:textColor forKey:@"setTextColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_textColor {
   return self.textColor;
}

- (void)dk_setTintColor:(UIColor *)tintColor {
    NSAssert(tintColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.tintColor = tintColor;
    [self.pickers setObject:tintColor forKey:@"setTintColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_tintColor {
    return self.tintColor;
}
////override
//- (void)dk_updateTheme {
//    [self dk_setBackgroundColor:self.backgroundColor];
//    [self dk_setShadowColor:self.shadowColor];
//    [self dk_setTextColor:self.textColor];
//    [self dk_setTintColor:self.tintColor];
//}
@end
