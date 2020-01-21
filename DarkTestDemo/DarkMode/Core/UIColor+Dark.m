//
//  UIColor+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "UIColor+Dark.h"
#import <UIKit/UIKit.h>
#import "objc/runtime.h"
#import "TMapColorTable.h"
#import "TMapDarkVersionManager.h"

UIColor *TMapColorFromRGB(NSUInteger hex) {
    return [UIColor colorWithRed:((CGFloat)((hex >> 16) & 0xFF)/255.0)
                           green:((CGFloat)((hex >> 8) & 0xFF)/255.0)
                            blue:((CGFloat)(hex & 0xFF)/255.0)
                           alpha:1.0];
}

UIColor *TMapColorFromRGBA(NSUInteger hex) {
    return [UIColor colorWithRed:((CGFloat)((hex >> 24) & 0xFF)/255.0)
                           green:((CGFloat)((hex >> 16) & 0xFF)/255.0)
                            blue:((CGFloat)((hex >> 8) & 0xFF)/255.0)
                           alpha:((CGFloat)(hex & 0xFF)/255.0)];
}

@implementation UIColor (Dark)

+ (instancetype)colorWithName:(NSString *)name {
    UIColor *color = nil;
    if (name.length > 0) {
        //优先配置文件
       color = [self darkColorName:name];
        //颜色分类
    }
    return color;
}

- (instancetype)tmapColor {
    UIColor *retColor = nil;
    if (self.colorName) {
        //优先配置文件
       retColor = [[self class] darkColorName:self.colorName];
        //picker
//        if (self.picker) {
//            retColor = self.picker([TMapDarkVersionManager shareManager].theme);
//            retColor.picker = self.picker;
//        }
        retColor.colorName = self.colorName;
    }
    return retColor;
}

+ (instancetype)darkColorName:(NSString *)name {
    UIColor *retColor = nil;
    TMColorPicker picker = [[TMapColorTable shareColorTable] colorWithKey:name];
     if ([TMapDarkVersionManager shareManager].theme == TMapThemeNight) {
         retColor = picker(@"NIGHT");
     } else if([TMapDarkVersionManager shareManager].theme == TMapThemeNormal){
         retColor = picker(@"NORMAL");
     }
    retColor.colorName = name;
    return retColor;
}

//+ (instancetype)colorWithNormal:(NSString *)rgbaNormalString rgbaNightString:(NSString *)rgbaNightString {
//    NSParameterAssert(rgbaNormalString);
//    NSParameterAssert(rgbaNormalString);
//    UIColor *color = nil;
//    UIColor *normalColor = [UIColor colorFromString:rgbaNormalString];
//    UIColor *nightColor = [UIColor colorFromString:rgbaNightString];
//    
//    if ([TMapDarkVersionManager shareManager].theme == TMapThemeNight) {
//        color = nightColor;
//    } else  {
//        color = normalColor;
//    }
//    //赋值
//    color.colorName = rgbaNightString;
//    color.picker = ^(TMapTheme theme) {
//        if (theme == TMapThemeNight) {
//               return nightColor;
//           } else  {
//               return normalColor;
//           }
//    };
//    return color;
//}


#pragma mark - getter & setter
- (NSString *)colorName{
     return objc_getAssociatedObject(self, @selector(colorName));
}

- (void)setColorName:(NSString * _Nonnull)colorName {
      objc_setAssociatedObject(self, @selector(colorName), colorName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//-(TMapColorPicker)picker{
//     return objc_getAssociatedObject(self, @selector(picker));
//}
//
//- (void)setPicker:(TMapColorPicker _Nonnull)picker{
//    objc_setAssociatedObject(self, @selector(picker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}

#pragma mark - Helper
+ (UIColor *)colorFromHexString:(NSString *)hexStr {
    hexStr = [hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([hexStr hasPrefix:@"0x"]) {
        hexStr = [hexStr substringFromIndex:2];
    }
    if([hexStr hasPrefix:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
    }

    NSUInteger hex = [self intFromHexString:hexStr];
    if(hexStr.length > 6) {
        return TMapColorFromRGBA(hex);
    }

    return TMapColorFromRGB(hex);
}

+ (NSUInteger)intFromHexString:(NSString *)hexStr {
    unsigned int hexInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    [scanner scanHexInt:&hexInt];
    return hexInt;
}

@end
