//
//  RootViewController.m
//  DarkTestDemo
//
//  Created by elwin on 2020/1/16.
//  Copyright © 2020 elwin. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Dark Mode";
    [self.view addSubview:self.btn];
    // Do any additional setup after loading the view.
}

- (UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.frame = CGRectMake(60, 160 , 100, 44);
        [_btn setTitle:@"白天模式" forState:UIControlStateNormal];
        _btn.backgroundColor = [UIColor lightGrayColor];
   //     [_btn dk_setTitleColorPicker: DKColorPickerWithKey(btn) forState:UIControlStateNormal];
     //   [_btn dk_setTitleColor:TMapAppearanceColor(btn) forState:UIControlStateNormal];
        [_btn setBackgroundColor:[UIColor redColor]];
         //  [_btn dk_setTitleColor:color forState:UIControlStateNormal];
        
        [_btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}



- (void)btnClicked:(UIButton *)sender {
    UIViewController *vc = [[ViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
