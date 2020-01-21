//
//  CALayer+Dark.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Dark)

@property (nonatomic, strong, setter = dk_setShadowColor:) UIColor *dk_shadowColor;
@property (nonatomic, strong, setter = dk_setBorderColor:) UIColor *dk_borderColor;
@property (nonatomic, strong, setter = dk_setBackgroundColor:) UIColor *dk_backgroundColor;

@end

NS_ASSUME_NONNULL_END
