//
//  ViewController.m
//  UINavigationController
//
//  Created by allen_Chan on 16/8/11.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置导航栏的颜色
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    //设置导航栏标题的字体以及颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    //字体颜色
    titleAttr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //字体
    titleAttr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [self.navigationController.navigationBar setTitleTextAttributes:titleAttr];
    
//    设置电池栏的颜色
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //设置电池栏的颜色
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
