//
//  UIImage+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "UIImage+Dark.h"
#import "TMapDarkVersionManager.h"
#import "objc/runtime.h"

@implementation UIImage (Dark)
- (NSString *)imageName{
     return objc_getAssociatedObject(self, @selector(imageName));
}

- (void)setImageName:(NSString * _Nonnull)imageName {
      objc_setAssociatedObject(self, @selector(imageName), imageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

+ (instancetype)imageWithName:(NSString *)imageName
{
    UIImage *image;
  if ([TMapDarkVersionManager shareManager].theme == TMapThemeNormal) {
        image = [UIImage imageNamed:imageName];
    } else if([TMapDarkVersionManager shareManager].theme == TMapThemeNight) {
        NSString *nightImageName = [NSString stringWithFormat:@"%@_night", imageName];
        image = [UIImage imageNamed:nightImageName];
    }
    image.imageName = imageName;
    return image;
}
@end
