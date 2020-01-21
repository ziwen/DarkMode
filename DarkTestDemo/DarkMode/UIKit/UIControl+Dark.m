//
//  UIControl+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "UIControl+Dark.h"

#import <UIKit/UIKit.h>
#import "TMapDarkVersionManager.h"
#import "UIColor+Dark.h"
@interface UIControl()
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation UIControl (Dark)

//- (void)didMoveToSuperview {
//    if (self.tintColor.colorName) {
//        [[TMapDarkVersionManager shareManager] addToHashTable:self];
//    }
//}


- (void)dk_setTintColor:(UIColor *)tintColor {
    NSAssert(tintColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.tintColor = tintColor;
    [self.pickers setObject:tintColor forKey:@"setTintColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_tintColor {
    return self.tintColor;
}

//override
//- (void)dk_updateTheme {
//    [self dk_setTintColor:self.tintColor];
//}

@end
