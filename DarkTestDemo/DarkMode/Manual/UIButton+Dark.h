//
//  UIButton+Dark.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Dark)

- (void)dk_setTitleColor:(UIColor *)titleColor forState:(UIControlState)state;

- (void)dk_setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state;

- (void)dk_setImage:(UIImage *)image forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
