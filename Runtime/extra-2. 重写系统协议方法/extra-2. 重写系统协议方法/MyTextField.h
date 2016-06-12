//
//  MyTextField.h
//  TextFeildDelegate
//
//  Created by Wolf on 16/6/3.
//  Copyright © 2016年 Vincent-Xu. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^block_id_t)(id obj);

@interface MyTextField : UITextField

@property (nonatomic, copy) block_id_t searchCallback;




@end
