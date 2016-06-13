//
//  ViewController.m
//  extra-5. 交换方法的注意点
//
//  Created by Wolf on 16/6/13.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "ViewController.h"
#import "OriginBtn.h"
#import "SubBtn.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)originAction:(OriginBtn *)sender {
    [sender des_name];
}
- (IBAction)subAction:(SubBtn *)sender {
    [sender des_name];
}


@end
