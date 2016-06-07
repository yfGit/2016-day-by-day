//
//  ViewController.m
//  extra-1. 交换方法, 越界不Crash
//
//  Created by Wolf on 16/6/3.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *arr = @[@1, @2];

    NSNumber *a = arr[3];

    NSMutableArray *mArr = [NSMutableArray array];
    [mArr addObject:@"124"];
    [mArr addObject:@"124"];

    NSString *str = mArr[5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
