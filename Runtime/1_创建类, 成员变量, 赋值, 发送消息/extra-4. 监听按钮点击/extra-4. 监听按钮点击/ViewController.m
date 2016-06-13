//
//  ViewController.m
//  extra-4. 监听按钮点击
//
//  Created by Wolf on 16/6/12.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)btn2:(UIButton *)sender {
    NSLog(@"btn2");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%s",__func__);
}

@end
