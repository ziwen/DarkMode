//
//  UISwitch+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "UISwitch+Dark.h"
#import <UIKit/UIKit.h>
#import "TMapDarkVersionManager.h"
#import "UIColor+Dark.h"


@interface UISwitch()
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end
@implementation UISwitch (Dark)

//- (void)didMoveToSuperview {
//    if (self.thumbTintColor.colorName.length || self.onTintColor.colorName.length) {
//        [[TMapDarkVersionManager shareManager] addToHashTable:self];
//    }
//}

- (void)dk_setThumbTintColor:(UIColor *)thumbTintColor {
    NSAssert(thumbTintColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.thumbTintColor = thumbTintColor;
    [self.pickers setObject:thumbTintColor forKey:@"setThumbTintColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_thhumbTintColor {
    return self.thumbTintColor;
}

- (void)dk_setOnTintColor:(UIColor *)onTintColor {
    NSAssert(onTintColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.onTintColor = onTintColor;
    [self.pickers setObject:onTintColor forKey:@"setOnTintColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_onTintColor {
    return self.onTintColor;
}
//override
//- (void)dk_updateTheme {
//    [self dk_setOnTintColor:self.onTintColor];
//    [self dk_setThumbTintColor:self.thumbTintColor];
//}

@end
