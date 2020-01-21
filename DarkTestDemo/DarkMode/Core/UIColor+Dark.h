//
//  UIColor+Dark.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMapDarkVersionManager.h"
NS_ASSUME_NONNULL_BEGIN

#define TMapAppearanceColor(colorName) [UIColor colorWithName:@#colorName]
//#define TMapAppearanceColor2(rgbaNormalString, rgbaNightString) [UIColor colorWithNormal:@#rgbaNormalString rgbaNightString:@#rgbaNightString]
//#define TMapAppearanceColor3(rgbaNormalColor, rgbaNightColor) [UIColor colorWithName:colorName]
@protocol UIColorProtocool <NSObject>

@property (nonatomic, copy, readonly) NSString *colorName;
/**
 通过颜色分类，初始化颜色
 @param name the name of the color category
 @return UIColor
 */
+ (instancetype)colorWithName:(NSString *)name;

@end


@interface UIColor (Dark) <UIColorProtocool>

@property (nonatomic, copy, readonly) NSString *colorName;
//@property (nonatomic, copy) TMapColorPicker picker;

/**
 通过颜色分类，初始化颜色
 @param name the name of the color category
 @return UIColor
 */
+ (instancetype)colorWithName:(NSString *)name;
/**
 通过颜色分类
 */
//+ (instancetype)colorWithNormal:(NSString *)rgbaNormalString rgbaNightString:(NSString *)rgbaNightString;
/**
通过颜色分类，初始化颜色
@param hexStr 0x2345ff #45679AAB 或者带透明度 0x2345ff88 #234567aa
@return UIColor
*/
+ (instancetype)colorFromHexString:(NSString *)hexStr;

- (instancetype)tmapColor;
@end

NS_ASSUME_NONNULL_END
