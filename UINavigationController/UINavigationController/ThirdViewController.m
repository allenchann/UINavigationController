//
//  ThirdViewController.m
//  UINavigationController
//
//  Created by allen_Chan on 16/8/11.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"第三个控制器";

    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];

    
    self.view.backgroundColor = [UIColor colorWithRed:17.0/255 green:107.0/255 blue:173.0/255 alpha:1];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 20)];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitle:@"返回首页" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(popToroot) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
}

- (void)popToroot
{
    [[self.navigationController navigationBar] setBarTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[self.navigationController navigationBar] setBarTintColor:[UIColor orangeColor]];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
