//
//  UIButton+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "UIButton+Dark.h"

#import <UIKit/UIKit.h>
#import "UIColor+Dark.h"
#import "UIImage+Dark.h"
#import "TMapDarkVersionManager.h"
@interface UIButton()
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation UIButton (Dark)
- (void)dk_setTitleColor:(UIColor *)titleColor forState:(UIControlState)state {
    [self setTitleColor:titleColor forState:state]; //支持iOS 13新写法
    //UIDynamicProviderColor
    // rgb UIExtendedSRGBColorSpace  UICachedDeviceRGBColor
    if ([titleColor isKindOfClass:[[UIColor whiteColor] class]]) {
        NSAssert(titleColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h");
        
        NSString *key = [NSString stringWithFormat:@"%@", @(state)];
        NSMutableDictionary *dictionary = [self.pickers valueForKey:key];
        if (!dictionary) {
            dictionary = [[NSMutableDictionary alloc] init];
        }
        [dictionary setValue:titleColor forKey:NSStringFromSelector(@selector(setTitleColor:forState:))];
        [self.pickers setValue:dictionary forKey:key];
        [[TMapDarkVersionManager shareManager] addToHashTable:self];
    }

}

- (void)dk_setBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state {
    NSAssert(backgroundImage.imageName, @"not set imageName for UIImage,please using UIImage+Dark.h");
    
    [self setBackgroundImage:backgroundImage forState:state];
    
    NSString *key = [NSString stringWithFormat:@"%@", @(state)];
    NSMutableDictionary *dictionary = [self.pickers valueForKey:key];
    if (!dictionary) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    [dictionary setValue:backgroundImage forKey:NSStringFromSelector(@selector(setBackgroundImage:forState:))];
    [self.pickers setValue:dictionary forKey:key];
     [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (void)dk_setImage:(UIImage *)image forState:(UIControlState)state {
    NSAssert(image.imageName, @"not set imageName for UIImage,please using UIImage+Dark.h default macro init method");
    [self setImage:image forState:state];
    NSString *key = [NSString stringWithFormat:@"%@", @(state)];
    NSMutableDictionary *dictionary = [self.pickers valueForKey:key];
    if (!dictionary) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    [dictionary setValue:image forKey:NSStringFromSelector(@selector(setImage:forState:))];
    [self.pickers setValue:dictionary forKey:key];
     [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (void)dk_updateTheme {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSDictionary<NSString *, id> *dictionary = (NSDictionary *)obj;
            [dictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, id  _Nonnull picker, BOOL * _Nonnull stop) {
                UIControlState state = [key integerValue];
//                [UIView animateWithDuration:0.1
//                                 animations:^{
                    if ([selector isEqualToString:NSStringFromSelector(@selector(setTitleColor:forState:))]) {
                        UIColor *resultColor = [UIColor colorWithName:((UIColor *)picker).colorName];
                        [self setTitleColor:resultColor forState:state];
                    } else if ([selector isEqualToString:NSStringFromSelector(@selector(setBackgroundImage:forState:))]) {
                        UIImage *resultImage = [UIImage imageWithName:((UIImage *)picker).imageName];
                        [self setBackgroundImage:resultImage forState:state];
                    } else if ([selector isEqualToString:NSStringFromSelector(@selector(setImage:forState:))]) {
                        UIImage *resultImage = [UIImage imageWithName:((UIImage *)picker).imageName];
                        [self setImage:resultImage forState:state];
                    }
//                }];
            }];
        } else {
            SEL sel = NSSelectorFromString(key);
            UIColor *picker = (UIColor *)obj;
            UIColor *resultColor = [UIColor colorWithName:picker.colorName];
            [UIView animateWithDuration:0.1
                             animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self performSelector:sel withObject:resultColor];
#pragma clang diagnostic pop
            }];
            
        }
    }];
}

@end
