//
//  TMapDarkVersionManager.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMapDarkVersionManager.h"
#import "TMapViewController.h"
#import "NSObject+Dark.h"
NSString * const DKNightVersionCurrentThemeVersionKey = @"com.dknightversion.manager.themeversion";

@interface TMapDarkVersionManager()
//用于存放color数据
@property (nonatomic, strong) NSMutableDictionary *colorPlistDic;
@property (nonatomic, strong) NSHashTable<__kindof UIView *> *hashTable;
//@property (nonatomic, assign, readwrite) BOOL systemInterfaceStyleEnable;
@property (nonatomic, strong) TMapViewController *viewController;

@end

@implementation TMapDarkVersionManager
static TMapDarkVersionManager *shareManager;
static dispatch_once_t onceToken;
+ (instancetype)shareManager {
    dispatch_once(&onceToken, ^{
        shareManager = [[[self class] alloc] init];
    });
    return shareManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _supportsKeyboard = YES;
        _changeStatusBar = YES;
        _systemInterfaceStyleEnable = NO;
        
        TMapTheme theme = ((NSNumber *)[[NSUserDefaults standardUserDefaults] valueForKey:DKNightVersionCurrentThemeVersionKey]).intValue;
        _theme = theme ?: TMapThemeNormal;
        //读取plist
    }
    return self;
}

- (void)setTheme:(TMapTheme)theme {
    if (_theme == theme) {
           // if type does not change, don't execute code below to enhance performance.
        return;
    }
    
    _theme = theme;
    // Save current theme version to user default
    [[NSUserDefaults standardUserDefaults] setValue:@(_theme) forKey:DKNightVersionCurrentThemeVersionKey];
    //颜色更改,读取plist文件
    [self changeStatusBar];
    // 更新
    [self updateTheme];
}

- (void)setSystemInterfaceStyleEnable:(BOOL)systemInterfaceStyleEnable {
    _systemInterfaceStyleEnable = systemInterfaceStyleEnable;
    if (systemInterfaceStyleEnable) {
        __weak __typeof(self) weakSelf = self;
        _viewController = [[TMapViewController alloc] init];
        if (@available(iOS 12.0, *)) {
            _viewController.block = ^(UIUserInterfaceStyle style) {
                if (style == UIUserInterfaceStyleDark) {
                    weakSelf.theme = TMapThemeNight;
                }
                else {
                    weakSelf.theme = TMapThemeNormal;
                }
            };
        }
    } else {

        if (@available(iOS 12.0, *)) {
            _viewController.block = nil;
        } else {
            // Fallback on earlier versions
        }
        _viewController = nil;
    }
}

- (void)changeStatusBar {
       if (self.shouldChangeStatusBar) {
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
            if (self.theme == TMapThemeNight) {
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            } else {
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            }
    #pragma clang diagnostic pop
        }
}

- (void)readPlistWithTheme:(TMapTheme)theme {
    switch (theme) {
        case TMapThemeNormal:
            [self readPlist:@"default.plist"];
            break;
        case TMapThemeNight:
            [self readPlist:@"dark.plist"];
            break;
        default:
            break;
    }
}

- (void)readPlist:(NSString *)fileName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    //    NSString * filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:fileName];
    _colorPlistDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSLog(@"%@",_colorPlistDic);
}

- (void)addToHashTable:(__kindof NSObject *)view{
    [self.hashTable addObject:view];
}

- (NSHashTable *)hashTable {
    if (!_hashTable) {
        _hashTable = [NSHashTable weakObjectsHashTable];
    }
    return _hashTable;
}

- (void)updateTheme {
  CFTimeInterval start = [[NSDate date] timeIntervalSince1970] * 1000;
    for (NSObject *obj in [self.hashTable.objectEnumerator allObjects]) {
        //normalily for color update in NSObject category
        //other must override the method
        [obj dk_updateTheme];
    }
    CFTimeInterval end = [[NSDate date] timeIntervalSince1970] * 1000;
    NSLog(@"==========:%f", end - start);
}

- (void)nightFalling {
    self.theme = TMapThemeNight;
}

- (void)dawnComing {
    self.theme = TMapThemeNormal;
}
@end
