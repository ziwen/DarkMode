//
//  UISwitch+Dark.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISwitch (Dark)
/**
color 通过UIColor+Dark实现
*/
@property (nonatomic, strong, setter=dk_setThumbTintColor:) UIColor *dk_thhumbTintColor;

/**
color 通过UIColor+Dark实现
*/
@property (nonatomic, strong, setter=dk_setOnTintColor:) UIColor *dk_onTintColor;

@end

NS_ASSUME_NONNULL_END
