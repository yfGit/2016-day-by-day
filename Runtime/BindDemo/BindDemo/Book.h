//
//  Book.h
//  BindDemo
//
//  Created by Vincent on 2017/3/13.
//  Copyright © 2017年 Vincent. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Author;

@interface Book : NSObject


@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) Author *author;

@property (nonatomic, assign) float price;


@end
