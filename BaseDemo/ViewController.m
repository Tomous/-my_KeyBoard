//
//  ViewController.m
//  BaseDemo
//
//  Created by 大橙子 on 2018/9/29.
//  Copyright © 2018年 中都格罗唯视. All rights reserved.
//

#import "ViewController.h"
#import "DCAccountKeyBoard.h"
#import "DCDatePickerView.h"
@interface ViewController ()<My_KeyBoardDelegate,UITextFieldDelegate>
@property (nonatomic,strong) DCAccountKeyBoard *my_keyboard;
@property (nonatomic,strong)  UIView *inputView;
@property (nonatomic, strong) UITextField *inputTextField;
@end

@implementation ViewController

#pragma -----IQKeyboardManager----
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [[IQKeyboardManager sharedManager] setEnable:NO];
//}
//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [[IQKeyboardManager sharedManager] setEnable:YES];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor cyanColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 300, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(btnDidClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    [self setUpInputView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
    [NOTIFICATION addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [NOTIFICATION addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
 
    
}
-(void)setUpInputView {
    self.inputView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, 40)];
    self.inputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.inputView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
    titleLabel.text = @"备注：";
    titleLabel.font = FONT(16);
    titleLabel.backgroundColor = [UIColor whiteColor];
    [self.inputView addSubview:titleLabel];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(titleLabel.right, 0, self.inputView.width - titleLabel.width - 2, 40)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.text = @"0";
    textField.font = FONT(20);
    self.inputTextField = textField;
    [self.inputView addSubview:textField];
}

-(void)btnDidClick
{
    [self showKeyBoard];
}
/**
 UIKeyBoardAction--键盘处理
 */
-(void)showKeyBoard {
    [self.inputTextField becomeFirstResponder];
    self.inputTextField.text = nil;
    [self keyBoardTypeAction];
}

- (void)keyBoardTypeAction {
    self.my_keyboard = [[DCAccountKeyBoard alloc] initWithNumber:@1];
    self.inputTextField.inputView = self.my_keyboard;
    self.my_keyboard.delegate = self;
    [self.inputTextField reloadInputViews];
}
- (void)hidenKeyBoard {
    [self.inputTextField resignFirstResponder];
}

- (void)numberKeyBoard:(NSInteger)number {
    NSString *str = self.inputTextField.text;
    self.inputTextField.text = [NSString stringWithFormat:@"%@%ld",str,(long)number];
}
- (void)cancelKeyBoard {
    NSMutableString *muStr = [[NSMutableString alloc] initWithString:self.inputTextField.text];
    if (muStr.length <= 0) {
        return;
    }
    [muStr deleteCharactersInRange:NSMakeRange([muStr length] - 1, 1)];
    self.inputTextField.text = muStr;
}
#pragma 输入点
-(void)periodKeyBoard {
    if ([self.inputTextField.text isEqualToString:@""]) {
        return;
    }
    //判断当前时候存在一个点
    if ([self.inputTextField.text rangeOfString:@"."].location == NSNotFound) {
        //输入中没有点
        NSMutableString  *mutableString=[[NSMutableString alloc]initWithFormat:@"%@%@",self.inputTextField.text,@"."];
        self.inputTextField.text=mutableString;
    }
}
-(void)timeKeyBoard {
    [self hidenKeyBoard];
    DCDatePickerView *pickerDate = [[DCDatePickerView alloc]initWithIsisAddYetSelect:NO isShowDay:YES];
    [pickerDate show];
    __weak typeof(self) weakself = self;
    pickerDate.block = ^(NSString *timeString) {
        NSLog(@"timeString%@",timeString);
        [weakself showKeyBoard];
        [weakself.my_keyboard.timeBtn setTitle:timeString forState:UIControlStateNormal];
    };
}
-(void)finishKeyBoard{
    [self hidenKeyBoard];
    NSLog(@"text-%@-time:%@",self.inputTextField.text,self.my_keyboard.timeBtn.titleLabel.text);
}

// 根据键盘状态，调整_mainView的位置
- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyBoardSize = value.CGRectValue.size;
    self.inputView.frame = CGRectMake(0, ScreenHeight - keyBoardSize.height - 40, ScreenWidth, 40);
}
-(void)keyboardWillHide:(NSNotification *)notification {
    self.inputView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 40);
}
@end
