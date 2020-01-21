//
//  UITableView+Dark.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Dark)
@property (nonatomic, strong, setter = dk_setSeparatorColor:) UIColor *dk_separatorColor;
@property (nonatomic, strong, setter = dk_setSectionIndexColor:) UIColor *dk_sectionIndexColor;
@property (nonatomic, strong, setter = dk_setSectionIndexBackgroundColor:) UIColor *dk_sectionIndexBackgroundColor;
@property (nonatomic, strong, setter = dk_setSectionIndexTrackingBackgroundColor:) UIColor  *dk_sectionIndexTrackingBackgroundColor;

@end

NS_ASSUME_NONNULL_END
