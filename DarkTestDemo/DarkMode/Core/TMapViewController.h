//
//  TMapViewController.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(ios(12.0))
typedef void(^TMapUserInterfaceStyleBlock)(UIUserInterfaceStyle style);

@interface TMapViewController : UIViewController

@property (nonatomic, copy, nullable) TMapUserInterfaceStyleBlock block API_AVAILABLE(ios(12.0));

@end

NS_ASSUME_NONNULL_END
