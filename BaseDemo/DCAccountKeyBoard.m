//
//  DCAccountKeyBoard.m
//  BaseDemo
//
//  Created by 大橙子 on 2018/11/16.
//  Copyright © 2018 中都格罗唯视. All rights reserved.
//

#import "DCAccountKeyBoard.h"
@implementation DCAccountKeyBoard

-(id)initWithNumber:(NSNumber *)number {
    if (self = [super init]) {
        self.backgroundColor = DCColor(244, 245, 244);
        self.frame = CGRectMake(0, ScreenHeight - 150, ScreenHeight, 150);
        [self initKeyBoardNumber_1];
    }
    return self;
}

/**
 setUpUI
 */
- (void)initKeyBoardNumber_1 {
    self.frame=CGRectMake(0, ScreenHeight-203, ScreenWidth, 203);
    CGFloat kWidth = ScreenWidth/4;
    CGFloat kHeight = 50;
    int space=1;
    
    //number 1-9
    for (int i=0; i<9; i++) {
        NSString *str=[NSString stringWithFormat:@"%d",i+1];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
        if (i<3) {
            button.frame=CGRectMake(i%3*kWidth+space,i/3*(kHeight+space), kWidth-space, kHeight);
        }
        else{
            button.frame=CGRectMake(i%3*kWidth+space,i/3*(kHeight+space), kWidth-space, kHeight);
        }
        button.backgroundColor=[UIColor whiteColor];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font=[UIFont systemFontOfSize:24];
        [button setTitle:str forState:UIControlStateNormal];
        button.tag=i+1;
        [button addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
    
    //点
    UIButton *dian=[UIButton buttonWithType:UIButtonTypeSystem];
    dian.frame=CGRectMake(space,(kHeight+1)*3 , kWidth-space, kHeight);
    dian.backgroundColor=[UIColor whiteColor];
    [dian setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    dian.titleLabel.font=[UIFont systemFontOfSize:24];
    [dian addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
    [dian setTitle:@"." forState:UIControlStateNormal];
    dian.tag=11;
    [self addSubview:dian];
    
    // 0
    UIButton *ling=[UIButton buttonWithType:UIButtonTypeSystem];
    ling.frame=CGRectMake(dian.right+space,dian.y, kWidth-space, kHeight);
    ling.backgroundColor=[UIColor whiteColor];
    [ling setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    ling.titleLabel.font=[UIFont systemFontOfSize:24];
    [ling setTitle:@"0" forState:UIControlStateNormal];
    ling.tag=0;
    [ling addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:ling];
    
    //时间按钮
    self.timeBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    self.timeBtn.frame=CGRectMake(kWidth*3+space,0, kWidth-1, kHeight*2+space);
    self.timeBtn.backgroundColor=[UIColor whiteColor];
    [self.timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.timeBtn setTitle:@"今天" forState:UIControlStateNormal];
    self.timeBtn.tag=12;
    [self.timeBtn addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.timeBtn];
    
    //删除键
    UIButton *delete=[UIButton buttonWithType:UIButtonTypeSystem];
    delete.frame=CGRectMake(ling.right+space,ling.y, kWidth-1, kHeight);
    [delete addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
    delete.tag=10;
    [delete setImage:IMAGENAME(@"键盘删除") forState:UIControlStateNormal];
    delete.backgroundColor = [UIColor whiteColor];
    [self addSubview:delete];
    
    //完成键
    UIButton *confirm=[UIButton buttonWithType:UIButtonTypeSystem];
    confirm.frame=CGRectMake(delete.right+space,self.timeBtn.bottom+space, kWidth-1, kHeight*2+space);
    confirm.backgroundColor=BlueColor;
    [confirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    confirm.titleLabel.font=[UIFont systemFontOfSize:20];
    [confirm setTitle:@"完 成" forState:UIControlStateNormal];
    [confirm addTarget:self action:@selector(keyBoardAciont:) forControlEvents:UIControlEventTouchUpInside];
    confirm.tag=13;
    [self addSubview:confirm];
}
#pragma 键盘点击按钮事件
- (void)keyBoardAciont:(UIButton *)sender {
    UIButton* btn = (UIButton*)sender;
    NSInteger number = btn.tag;
    if (nil == _delegate) {
        
        return;
    }
    
    if (number <=9 && number >= 0) {
        [_delegate numberKeyBoard:number];
        return;
    }
    
    if (number == 10) {
        [_delegate cancelKeyBoard];
        return;
    }
    
    if (11==number) {
        [_delegate periodKeyBoard];
        return;
    }
    
    if (12==number) {
        [_delegate timeKeyBoard];
        return;
    }
    
    if (13==number) {
        [_delegate finishKeyBoard];
        return;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
