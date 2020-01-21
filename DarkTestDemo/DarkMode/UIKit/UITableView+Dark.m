//
//  UITableView+Dark.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "UITableView+Dark.h"
#import <UIKit/UIKit.h>
#import "TMapDarkVersionManager.h"
#import "UIColor+Dark.h"
@interface UITableView ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *pickers;

@end

@implementation UITableView (Dark)


- (UIColor *)dk_separatorColor{
    return self.separatorColor;
}

- (void)dk_setSeparatorColor:(UIColor *)separatorColor {
    NSAssert(separatorColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.separatorColor = separatorColor;
    [self.pickers setValue:separatorColor forKey:@"setSeparatorColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_sectionIndexColor {
    return self.sectionIndexColor;
}

- (void)dk_setSectionIndexColor:(UIColor *)sectionIndexColor {
    NSAssert(sectionIndexColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.sectionIndexColor = sectionIndexColor;
    [self.pickers setValue:sectionIndexColor forKey:@"setSectionIndexColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_sectionIndexBackgroundColor {
    return self.sectionIndexBackgroundColor;
}

- (void)dk_setSectionIndexBackgroundColor:(UIColor *)sectionIndexBackgroundColor {
    NSAssert(sectionIndexBackgroundColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.sectionIndexBackgroundColor = sectionIndexBackgroundColor;
    [self.pickers setValue:sectionIndexBackgroundColor forKey:@"setSectionIndexBackgroundColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

- (UIColor *)dk_sectionIndexTrackingBackgroundColor {
    return self.dk_sectionIndexTrackingBackgroundColor;
}

- (void)dk_setSectionIndexTrackingBackgroundColor:(UIColor *)sectionIndexTrackingBackgroundColor {
    NSAssert(sectionIndexTrackingBackgroundColor.colorName, @"not set colorName for UIColor,please using UIColor+Dark.h macro");
    self.sectionIndexTrackingBackgroundColor = sectionIndexTrackingBackgroundColor;
    [self.pickers setValue:sectionIndexTrackingBackgroundColor forKey:@"setSectionIndexTrackingBackgroundColor:"];
    [[TMapDarkVersionManager shareManager] addToHashTable:self];
}

@end
