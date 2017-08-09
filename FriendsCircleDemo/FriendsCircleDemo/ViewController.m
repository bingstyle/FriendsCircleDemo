//
//  ViewController.m
//  FriendsCircleDemo
//
//  Created by weixb on 2017/8/7.
//  Copyright © 2017年 weixb. All rights reserved.
//

#import "ViewController.h"
#import "FriendsCircleViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
    UIViewController *vc = [FriendsCircleViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
