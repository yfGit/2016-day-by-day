//
//  People.h
//  3. Category
//
//  Created by Wolf on 16/5/31.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject<NSCoding>
{
    NSString *_occupation;
}

@property (nonatomic, copy  ) NSString *name;
@property (nonatomic, assign) int      age;

@property (nonatomic, copy  ) NSString *occupation;  // 职业
@property (nonatomic, copy  ) NSString *nationality; // 国籍

@end
