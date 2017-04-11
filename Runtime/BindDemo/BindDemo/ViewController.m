//
//  ViewController.m
//  BindDemo
//
//  Created by Vincent on 2017/3/13.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "Book.h"
#import "Author.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSObject+Model_AutoInitializ.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UITextField *bookField;

@property (weak, nonatomic) IBOutlet UITextField *authorField;

@property (nonatomic, strong) User *user;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self bindModel];
}


- (void) bindModel
{
    RAC(self.user, name)             = self.userField.rac_textSignal;
    RAC(self.user, age)              = self.pwdField.rac_textSignal;
    RAC(self.user.book, name)        = self.bookField.rac_textSignal;
    RAC(self.user.book.author, name) = self.authorField.rac_textSignal;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
     NSLog(@"\n user_name -> %@   \n use_age -> %@  \n book_name -> %@ \n author_name -> %@",self.user.name, self.user.age ,self.user.book.name, self.user.book.author.name);
}


- (User *)user
{
    if (!_user) {
        _user = [[User alloc] init];
        [_user initializeModelProperty];
    }
    return _user;
}


@end
