//
//  ViewController.m
//  extra-2. 重写系统协议方法
//
//  Created by Wolf on 16/6/6.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "ViewController.h"
#import "MyTextField.h"

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet MyTextField *textField_1;

@property (weak, nonatomic) IBOutlet MyTextField *textField_2;

@property (weak, nonatomic) IBOutlet UITextField *textField_3;

@property (weak, nonatomic) IBOutlet UITextField *textField_4;


// 可以添加其他的类来管理代理, 只要实现了方法
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // 不实现代理, 交换的方法运行
    // 实现代理, 有回调, 调回调

    self.textField_3.delegate = self;
    self.textField_4.delegate = self;
    self.textField_1.delegate = self;
    self.textField_2.delegate = self.textField_2;
    self.textField_2.searchCallback = ^(NSString *text) {
        NSLog(@"%@", text);
    };
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%s--%@", __func__, textField.delegate);
    return YES;
}
@end
