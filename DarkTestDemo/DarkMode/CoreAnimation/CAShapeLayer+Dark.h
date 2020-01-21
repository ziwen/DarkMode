//
//  CAShapeLayer+Dark.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAShapeLayer (Dark)

@property (nonatomic, strong, setter=dk_setStrokeColor:) UIColor *dk_strokeColor;
@property (nonatomic, strong, setter=dk_setFillColor:) UIColor *dk_fillColor;

@end

NS_ASSUME_NONNULL_END
