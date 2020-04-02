//
//  TMapViewController.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "TMapViewController.h"

@interface TMapViewController ()

@end

@implementation TMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

#pragma mark - Dark mode Adapter
//#ifdef __IPHONE_13_0
//-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
//    [super traitCollectionDidChange:previousTraitCollection];
//    if (@available(iOS 13.0, *)) {
//        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
//            // 适配代码
//            __weak __typeof(self) weakSelf = self;
//            if (self.block) {
//                self.block(weakSelf.traitCollection.userInterfaceStyle);
//            }
//        }
//    } else {
//
//    }
//}

- (void)traitCollectionDidChange:(UITraitCollection *)traitCollection{
    NSLog(@"traitCollectionChanged:%ld",traitCollection.userInterfaceStyle);
 //   [self iv2updateImage];
    
}

//- (void)willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator{
//    // 适配代码
//            __weak __typeof(self) weakSelf = self;
//            if (self.block) {
//                self.block(weakSelf.traitCollection.userInterfaceStyle);
//            }
//}

//#endif

@end
