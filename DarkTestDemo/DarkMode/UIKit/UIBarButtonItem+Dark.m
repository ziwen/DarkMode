//
//  UIBarButtonItem+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "UIBarButtonItem+Dark.h"
#import <UIKit/UIKit.h>
#import "objc/runtime.h"
#import "UIColor+Dark.h"
@interface UIBarButtonItem()
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;
@end

@implementation UIBarButtonItem (Dark)

- (UIColor *)dk_tintColor {
    return self.tintColor;
}

- (void)dk_setTintColor:(UIColor *)tintColor {
    NSAssert(tintColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.tintColor = tintColor;
    [self.pickers setValue:tintColor forKey:@"setTintColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}
 
@end
