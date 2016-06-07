//
//  ViewController.m
//  2. 获取属性, 成员变量, 方法
//
//  Created by Wolf on 16/6/3.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "ViewController.h"
#import "People.h"
@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self fetchData];
}


- (void)fetchData
{
    NSDictionary *properties = [[[People alloc] init] allProperties];
    NSDictionary *ivars      = [[[People alloc] init] allIvars];
    NSDictionary *methods    = [[[People alloc] init] allMethods];

    NSLog(@"%@\n",properties);
    NSLog(@"%@\n",ivars);
    NSLog(@"%@\n",methods);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self fetchData];
}

@end
