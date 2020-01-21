//
//  NSObject+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "NSObject+Dark.h"
#import "objc/runtime.h"
#import <UIKit/UIKit.h>
#import "UIColor+Dark.h"
@interface NSObject ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end
@implementation NSObject (Dark)

- (NSMutableDictionary<NSString *, id> *)pickers {
    NSMutableDictionary<NSString *, id> *pickers = objc_getAssociatedObject(self, @selector(pickers));
    if (!pickers) {
        pickers = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, @selector(pickers), pickers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return pickers;
}

- (void)dk_updateTheme
{
    [self.pickers enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull selector, id  _Nonnull picker, BOOL * _Nonnull stop) {
        SEL sel = NSSelectorFromString(selector);
        if ([picker isKindOfClass:[UIColor class]]) {
            if (((UIColor *)picker).colorName.length > 0) {
                UIColor * result = [UIColor colorWithName:(((UIColor *)picker).colorName)];
                //                id result = picker(self.dk_manager.themeVersion);
                        [UIView animateWithDuration:0.1
                                         animations:^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self performSelector:sel withObject:result];
#pragma clang diagnostic pop
                                                   }];
            }
        }
    }];
}
@end
