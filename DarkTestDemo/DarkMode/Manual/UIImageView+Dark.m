//
//  UIImageView+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "UIImageView+Dark.h"
#import "UIImage+Dark.h"
#import "TMapDarkVersionManager.h"
#import "UIColor+Dark.h"
@interface UIImageView()
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end
@implementation UIImageView (Dark)
- (instancetype)dk_initWithImage:(UIImage *)image {
    [self dk_setImage:image];
    return self;
}

- (UIImage *)dk_image {
    return self.image;
}

- (void)dk_setImage:(UIImage *)image {
     NSAssert(image.imageName, @"not set imageName for UIImage,please using UIImage+Dark.h default macro init method");
    self.image = image;
    [self.pickers setValue:image forKey:@"setImage:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

//- (DKAlphaPicker)dk_alphaPicker {
//    return objc_getAssociatedObject(self, @selector(dk_alphaPicker));
//}
//
//- (void)dk_setAlphaPicker:(DKAlphaPicker)picker {
//    objc_setAssociatedObject(self, @selector(dk_alphaPicker), picker, OBJC_ASSOCIATION_COPY_NONATOMIC);
//    self.alpha = picker(self.dk_manager.themeVersion);
//    [self.pickers setValue:[picker copy] forKey:@"setAlpha:"];
//}

- (void)dk_updateTheme {
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqualToString:@"setAlpha:"]) {
            //            DKAlphaPicker picker = (DKAlphaPicker)obj;
            //            CGFloat alpha = picker(self.dk_manager.themeVersion);
            //            [UIView animateWithDuration:DKNightVersionAnimationDuration
            //                             animations:^{
            //                                ((void (*)(id, SEL, CGFloat))objc_msgSend)(self, NSSelectorFromString(key), alpha);
            //                             }];
        } else if([key isEqualToString:@"setImage:"]){
            SEL sel = NSSelectorFromString(key);
            UIImage *image = (UIImage *)obj;
            if (image.imageName.length) {
                  UIImage *resultImage = [UIImage imageWithName:image.imageName];
                            [UIView animateWithDuration:0.1
                                             animations:^{
                #pragma clang diagnostic push
                #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                [self performSelector:sel withObject:resultImage];
                #pragma clang diagnostic pop
                            }];
            }
        }
        else {
            SEL sel = NSSelectorFromString(key);
            UIColor *color = (UIColor *)obj;
            
            if (color.colorName.length) {
                         UIColor *resultColor = [UIColor colorWithName:color.colorName];
                            [UIView animateWithDuration:0.1
                                             animations:^{
                #pragma clang diagnostic push
                #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                                [self performSelector:sel withObject:resultColor];
                #pragma clang diagnostic pop
                            }];
            }
        }
    }];
}
@end
