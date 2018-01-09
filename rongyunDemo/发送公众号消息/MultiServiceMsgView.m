//
//  MultiServiceMsgView.m
//  rongyunDemo
//
//  Created by 易博 on 2017/12/29.
//  Copyright © 2017年 易博. All rights reserved.
//

#import "MultiServiceMsgView.h"

@interface MultiServiceMsgView()

@property (weak, nonatomic) IBOutlet UITextField *pubServiceIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *reciveUserIdTextField;
@property (weak, nonatomic) IBOutlet UISwitch *sendToAllSwitch;
@property (weak, nonatomic) IBOutlet UITextView *msgContentTextView;

@end

@implementation MultiServiceMsgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"MultiServiceMsgView" owner:nil options:nil][0];
        self.frame = frame;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyBoard)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)hideKeyBoard
{
    [self endEditing:YES];
}

- (IBAction)switchBtnChanged:(UISwitch *)sender {
    
    if ([self.delegate respondsToSelector:@selector(onSwitchBtnChanged:)]) {
        [self.delegate onSwitchBtnChanged:[self.sendToAllSwitch isOn]];
    }
}


- (IBAction)sendBtnClicked:(UIButton *)sender {
    NSDictionary *params = @{@"fromuser":self.pubServiceIdTextField.text,
                             @"touser":self.reciveUserIdTextField.text
                             };
    
    if ([self.delegate respondsToSelector:@selector(onSendMultiMsgBtnClicked:forAll:)]) {
        [self.delegate onSendMultiMsgBtnClicked:params forAll:[self.sendToAllSwitch isOn]];
    }
}

@end
