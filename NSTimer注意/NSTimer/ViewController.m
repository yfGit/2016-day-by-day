//
//  ViewController.m
//  NSTimer
//
//  Created by Wolf on 16/6/15.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "ViewController.h"
#import "NSTimer+Extra.h"
#import "CustomView.h"
@interface ViewController ()
{}
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) CustomView *customView;
@end

@implementation ViewController

/*
    1. NSTimer scheduledTimerWithTimeInterval 默认 RunLoop为defalut
    如果涉及到 UIScrollView, 用 [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    2. 一般情况 NSTimer 和 VC等 会相互引用
    3. Repeats == YES 时, NSTimer不知道什么时候结束, 而一般情况下VC互相强引用了NSTimer, 所有要NSTimer为被释放时才行
    4. VC 释放了, VC里的变量不一定会释放, 只要还有其他强引用引用着

 */

- (void)viewDidLoad {
    [super viewDidLoad];

    // repeats:YES 也会自动释放
    /*
     VC strong->  NSTimer
     Block strong->  strongSelf weak -> VC
     */
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer ex_scheduledTimerWithTimeInterval:1 block:^id{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf stop];
        return strongSelf;
    } repeats:YES];


    _customView = [[CustomView alloc] initWithFrame:CGRectMake(20, 60, 100, 100)];
    _customView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_customView];



}
- (void)stop
{
    NSLog(@"%s",__func__);
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 当 _customView 没有其它的东西指向时才会Dealloc
//    [_customView removeFromSuperview];
//    _customView = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
