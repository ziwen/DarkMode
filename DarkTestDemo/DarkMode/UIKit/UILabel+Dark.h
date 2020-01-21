//
//  UILabel+Dark.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Dark)
/**
 背景色
color 通过UIColor+Dark实现
*/
@property (nonatomic, strong, setter = dk_setBackgroundColor:) UIColor *dk_backgroundColor;
/**
 文本颜色
color 通过UIColor+Dark实现
*/
@property (nonatomic, strong, setter = dk_setTextColor:) UIColor *dk_textColor;

/**
 color 通过UIColor+Dark实现
 */
@property (nonatomic, strong, setter = dk_setTintColor:) UIColor *dk_tintColor;
/**
color 通过UIColor+Dark实现
*/
@property (nonatomic, strong, setter = dk_setShadowColor:) UIColor *dk_shadowColor;

@end

NS_ASSUME_NONNULL_END
