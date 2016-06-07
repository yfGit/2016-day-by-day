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
@property (weak, nonatomic) IBOutlet MyTextField *myTextField;
@property (weak, nonatomic) IBOutlet UITextField *systemTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _myTextField.delegate = self;
    _systemTextField.delegate = self;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"%s",__func__);
    return YES;
}
@end
