//
//  People.h
//  JSON转Model
//
//  Created by Wolf on 16/6/1.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject


@property (nonatomic, copy  ) NSString *name;// 姓名
@property (nonatomic, strong) NSNumber *age;// 年龄
@property (nonatomic, copy  ) NSString *occupation;// 职业
@property (nonatomic, copy  ) NSString *nationality;// 国籍


// 生成model
- (instancetype)initWithDictionary:(NSDictionary *)dict;


// 生成字典
- (NSDictionary *)covertToDictionary;

@end
