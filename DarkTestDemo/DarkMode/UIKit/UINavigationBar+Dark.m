//
//  UINavigationBar+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "UINavigationBar+Dark.h"
#import <UIKit/UIKit.h>
#import "UIColor+Dark.h"
#import "TMapDarkVersionManager.h"
@interface UINavigationBar()
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end
@implementation UINavigationBar (Dark)
//- (void)didMoveToSuperview{
//    if (self.barTintColor.colorName.length || self.tintColor.colorName.length) {
//        [[TMapDarkVersionManager shareManager] addToHashTable:self];
//    }
//}

- (void)dk_setBarTintColor:(UIColor *)barTintColor {
     NSAssert(barTintColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.barTintColor = barTintColor;
    [self.pickers setValue:barTintColor forKey:@"setBarTintColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_barTintColor {
    return self.barTintColor;
}

- (void)dk_setTintColor:(UIColor *)tintColor {
    NSAssert(tintColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.tintColor = tintColor;
    [self.pickers setValue:tintColor forKey:@"setTintColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_tintColor {
    return self.tintColor;
}
//- (void)dk_updateTheme {
//    [self dk_setBarTintColor:self.barTintColor];
//    [self dk_setBarTintColor:self.tintColor];
//}

@end
