//
//  UIImage+Dark.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#define TMapApperanceImage(imageName) [UIImage imageWithName:@ #imageName]

@interface UIImage (Dark)
@property (nonatomic, copy, readonly) NSString *imageName;

+ (instancetype)imageWithName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
