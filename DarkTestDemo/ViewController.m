//
//  ViewController.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Dark.h"
#import "UIImage+Dark.h"
#import "TMapDarkVersionManager.h"
#import "UIButton+Dark.h"
#import "UIView+Dark.h"
#import "FPSLabel.h"
#import "UIImageView+Dark.h"
//#import "DKNightVersion.h"
@interface ViewController ()
@property (nonatomic, strong) FPSLabel *fpsLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试DarkMode";
    
//    self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    self.view.backgroundColor = [UIColor whiteColor];
    [TMapDarkVersionManager shareManager].systemInterfaceStyleEnable = YES;
    [self.view addSubview:self.btn];
    [self testFPSLabel];
    CFTimeInterval start = [[NSDate date] timeIntervalSince1970] * 1000;
    [self addVieForTest];
    [self testForImage];
    CFTimeInterval end = [[NSDate date] timeIntervalSince1970] * 1000;
    NSLog(@"INIT time:%f", end-start);
    // Do any additional setup after loading the view.
}

#pragma mark - FPS demo

- (void)testFPSLabel {
    _fpsLabel = [FPSLabel new];
    _fpsLabel.frame = CGRectMake(100, 120, 50, 30);
    [_fpsLabel sizeToFit];
    [self.view addSubview:_fpsLabel];
    
    // 如果直接用 self 或者 weakSelf，都不能解决循环引用问题

    // 移除也不能使 label里的 timer invalidate
    //        [_fpsLabel removeFromSuperview];
}

- (void)addVieForTest {
      int count = 10;
      for (int i = 0; i< count; i++) {
          CGRect rect = [UIScreen mainScreen].bounds;
          UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*1.0/rect.size.width,
                                                                  i* 1.0/count * (rect.size.height-204) + 204,
                                                                  rect.size.width- i*1.0/rect.size.width,
                                                                  rect.size.height- i*1.0/rect.size.height)];
         switch (i % 6) {
             case 0:
//                 view.backgroundColor = [UIColor redColor];
                 view.dk_backgroundColor = TMapAppearanceColor(BG);
  //               view.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
                 [view dk_setBackgroundColor:TMapAppearanceColor(BG)];
                 break;
             case 1:
 //                 view.dk_backgroundColorPicker = DKColorPickerWithKey(SEP);
                 [view dk_setBackgroundColor:TMapAppearanceColor(SEP)];
                 break;
             case 2:
//                  view.dk_backgroundColorPicker = DKColorPickerWithKey(TINT);
//                 [view dk_setBackgroundColor:TMapAppearanceColor(TINT)];
                 view.dk_backgroundColor = TMapAppearanceColor(TINT);
                 break;
             case 3:
//                view.dk_backgroundColorPicker = DKColorPickerWithKey(TEXT);
                 [view dk_setBackgroundColor:TMapAppearanceColor(TEXT)];
                 break;
             case 4:
//                 view.dk_backgroundColorPicker = DKColorPickerWithKey(BAR);
                 [view dk_setBackgroundColor:TMapAppearanceColor(BAR)];
                 break;
             case 5:
//                view.dk_backgroundColorPicker = DKColorPickerWithKey(HIGHLIGHTED);
                 [view dk_setBackgroundColor:TMapAppearanceColor(HIGHLIGHTED)];
                 break;
             default:
                 break;
         }
          [self.view addSubview:view];
      }
}

- (void)testForImage {
    UIImageView *imageView =  [[UIImageView alloc] init];
    imageView.frame = CGRectMake(200, 100, 200, 200);
    imageView.dk_image = TMapApperanceImage(ic_checkbox);
    [self.view addSubview:imageView];
}


- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(60, 160 , 100, 44);
        [_btn setTitle:@"改变模式" forState:UIControlStateNormal];
        _btn.backgroundColor = [UIColor lightGrayColor];
   //     [_btn dk_setTitleColorPicker: DKColorPickerWithKey(btn) forState:UIControlStateNormal];
     //   [_btn dk_setTitleColor:TMapAppearanceColor(btn) forState:UIControlStateNormal];
     
        UIColor *color = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return [UIColor orangeColor];
            }
            else {
                return [UIColor redColor];
            }
        }];
           [_btn dk_setTitleColor:color forState:UIControlStateNormal];
        
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

- (void)btnClicked:(UIButton *)btn {
    NSLog(@"TIME START:%f",[[NSDate date] timeIntervalSince1970] * 1000);
    [self change];
//    if ([TMapDarkVersionManager shareManager].theme == TMapThemeNormal) {
//
//    }
}


- (void)normal {
//    self.dk_manager.themeVersion = DKThemeVersionNormal;
    [TMapDarkVersionManager shareManager].theme = TMapThemeNormal;
}

- (void)night {
//    self.dk_manager.themeVersion = DKThemeVersionNight;
    [TMapDarkVersionManager shareManager].theme = TMapThemeNight;
}

- (void)change {
//    if(self.dk_manager.themeVersion == DKThemeVersionNight) {
//        self.dk_manager.themeVersion = DKThemeVersionNormal;
//    }
//    else {
//        self.dk_manager.themeVersion = DKThemeVersionNight;
//    }
    if (([TMapDarkVersionManager shareManager].theme == TMapThemeNight)) {
        [[TMapDarkVersionManager shareManager] dawnComing];
    } else {
        [[TMapDarkVersionManager shareManager] nightFalling];
    }
}



- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    NSLog(@"traitCollectionChanged:%ld",previousTraitCollection.userInterfaceStyle);
 //   [self iv2updateImage];
    
        [super traitCollectionDidChange:previousTraitCollection];
        if (@available(iOS 13.0, *)) {
            if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
                // 适配代码
                if (([TMapDarkVersionManager shareManager].theme == TMapThemeNight)) {
                    [[TMapDarkVersionManager shareManager] dawnComing];
                } else {
                    [[TMapDarkVersionManager shareManager] nightFalling];
                }
                
//                __weak __typeof(self) weakSelf = self;
//                if (self.block) {
//                    self.block(weakSelf.traitCollection.userInterfaceStyle);
//                }
            }
        } else {
    
        }
    
}
@end
