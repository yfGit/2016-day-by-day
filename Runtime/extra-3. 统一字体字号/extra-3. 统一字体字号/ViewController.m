//
//  ViewController.m
//  extra-3. 统一字体字号
//
//  Created by Wolf on 16/6/6.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController
- (IBAction)a:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];

    _label.text = @"测试文本框文字ABCabc";
    [_btn setTitle:@"测试按钮文字ABCabc" forState:UIControlStateNormal];

    UIButton *btn = [[UIButton alloc ]initWithFrame:CGRectMake(10, 400, 400, 50)];
    [self.view addSubview:btn];
    [btn setTitle:@"测试按钮文字ABCabc" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:25];
}



@end
