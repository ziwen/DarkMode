//
//  UINavigationBar+Dark.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (Dark)
/**
color 通过UIColor+Dark实现
*/
@property (nonatomic, strong, setter = dk_setBarTintColor:) UIColor *dk_barTintColor;

/**
color 通过UIColor+Dark实现
*/
@property (nonatomic, strong, setter = dk_setTintColor:) UIColor *dk_tintColor;

@end

NS_ASSUME_NONNULL_END
