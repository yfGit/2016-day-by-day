//
//  People+Associated.h
//  3. Category
//
//  Created by Wolf on 16/5/31.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import "People.h"


typedef void(^CodingCallBack)();

typedef NS_ENUM(NSUInteger, PolygonType) {
    PolygonTypeThree = 3,
    PolygonTypeFour,
    PolygonTypeFive,
    PolygonTypeSix
};

@interface People (Associated)


@property (nonatomic, strong) NSNumber       *associatedBust;

@property (nonatomic, copy  ) CodingCallBack associatedCallBack;

@property (nonatomic, assign) PolygonType    polygonType;


@end
