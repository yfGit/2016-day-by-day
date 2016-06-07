//
//  People+Associated.h
//  3. Category
//
//  Created by Wolf on 16/5/31.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "People.h"


typedef void(^CodingCallBack)();

@interface People (Associated)
{}

@property (nonatomic, strong) NSNumber       *associatedBust;

@property (nonatomic, copy  ) CodingCallBack associatedCallBack;



@end
