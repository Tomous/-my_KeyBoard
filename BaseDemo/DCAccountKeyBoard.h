//
//  DCAccountKeyBoard.h
//  BaseDemo
//
//  Created by 大橙子 on 2018/11/16.
//  Copyright © 2018 中都格罗唯视. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//创建自定义键盘协议
@protocol My_KeyBoardDelegate <NSObject>
//创建协议方法
@required//必须执行的方法
- (void)numberKeyBoard:(NSInteger) number;
- (void)cancelKeyBoard;
- (void)finishKeyBoard;
- (void)periodKeyBoard;
- (void)timeKeyBoard;
@optional//不必须执行方法

@end
@interface DCAccountKeyBoard : UIView
{
@private//私有的协议方法
    id<My_KeyBoardDelegate> _delegate;
}
@property (nonatomic, strong) id<My_KeyBoardDelegate> delegate;
@property (nonatomic,strong) UIButton *timeBtn;
- (id)initWithNumber:(NSNumber *)number;
@end

NS_ASSUME_NONNULL_END
