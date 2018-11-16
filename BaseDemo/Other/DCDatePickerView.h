//
//  DCDatePickerView.h
//  自定义选择器
//
//  Created by 大橙子 on 2018/7/17.
//  Copyright © 2018年 WOSHIPM. All rights reserved.
//

#import "DCBasePickerView.h"

typedef void(^pickerViewBlock)(NSString *timeSring);

@interface DCDatePickerView : DCBasePickerView

@property (nonatomic,copy) pickerViewBlock block;
@property(nonatomic, assign)BOOL isAddYetSelect;//是否增加至今的选项
@property(nonatomic, assign)BOOL isShowDay;//是否显示日

-(instancetype)initWithIsisAddYetSelect:(BOOL)isAddYetSelect isShowDay:(BOOL)isShowDay;
@end
