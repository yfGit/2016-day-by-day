//
//  main.m
//  JSON转Model
//
//  Created by Wolf on 16/5/31.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "People.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {


        NSDictionary *dict = @{
                               @"name"        : @"苍井空",
                               @"age"         : @"18",
                               @"occupation"  : @"老师",
                               @"nationality" : @"日本",
                               };
        People *people = [[People alloc] initWithDictionary:dict];
        NSLog(@"%@",people);


        NSDictionary *dictionary = [people covertToDictionary];
        NSLog(@"%@",dictionary);

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
