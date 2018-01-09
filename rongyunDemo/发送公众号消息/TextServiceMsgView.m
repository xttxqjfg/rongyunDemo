//
//  TextServiceMsgView.m
//  rongyunDemo
//
//  Created by 易博 on 2017/12/29.
//  Copyright © 2017年 易博. All rights reserved.
//

#import "TextServiceMsgView.h"

@interface TextServiceMsgView()
@property (weak, nonatomic) IBOutlet UITextField *pubServiceIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *reciveUserIdTextField;
@property (weak, nonatomic) IBOutlet UISwitch *sendToAllSwitch;
@property (weak, nonatomic) IBOutlet UITextView *msgContentTextView;

@end

@implementation TextServiceMsgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"TextServiceMsgView" owner:nil options:nil][0];
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

- (IBAction)sendBtnClicked:(UIButton *)sender {
    
    NSDictionary *params = @{@"fromuser":self.pubServiceIdTextField.text,
                             @"touser":self.reciveUserIdTextField.text,
                             @"content":self.msgContentTextView.text
                             };
    
    if ([self.delegate respondsToSelector:@selector(onSendTextMsgBtnClicked:forAll:)]) {
        [self.delegate onSendTextMsgBtnClicked:params forAll:[self.sendToAllSwitch isOn]];
    }
}

@end
