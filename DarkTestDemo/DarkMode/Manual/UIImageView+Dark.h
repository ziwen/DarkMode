//
//  UIImageView+Dark.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Dark)
- (instancetype)dk_initWithImage:(UIImage *)image;

@property (nullable, nonatomic, strong, setter = dk_setImage:) UIImage *dk_image;

//@property (nonatomic, strong, setter = dk_setAlpha:)  dk_alphaPicker;

@end

NS_ASSUME_NONNULL_END
