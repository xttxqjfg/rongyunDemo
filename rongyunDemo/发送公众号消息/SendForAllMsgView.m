//
//  SendForAllMsgView.m
//  rongyunDemo
//
//  Created by 易博 on 2018/1/4.
//  Copyright © 2018年 易博. All rights reserved.
//

#import "SendForAllMsgView.h"

@interface SendForAllMsgView()
//群发消息的公众号id
@property (weak, nonatomic) IBOutlet UITextField *publicServerNumberTextField;
//图文标题
@property (weak, nonatomic) IBOutlet UITextField *msgTitleTextField;
//图文作者
@property (weak, nonatomic) IBOutlet UITextField *msgAuthorTextField;
//跳转地址
@property (weak, nonatomic) IBOutlet UITextField *msgSourceUrlTextField;
//内容
@property (weak, nonatomic) IBOutlet UITextField *msgContentTextField;
//摘要
@property (weak, nonatomic) IBOutlet UITextField *msgDigestTextField;
//是否显示封面
@property (weak, nonatomic) IBOutlet UITextField *msgCoverPicTextField;
//媒体文件id
@property (weak, nonatomic) IBOutlet UILabel *thumbMediaIdLabel;
//图文数目
@property (weak, nonatomic) IBOutlet UITextField *msgNumberTextField;

@end

@implementation SendForAllMsgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:@"SendForAllMsgView" owner:nil options:nil][0];
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

-(void)setThumb_media_id:(NSString *)thumb_media_id
{
    _thumb_media_id = thumb_media_id;
    
    self.thumbMediaIdLabel.text = thumb_media_id;
}

- (IBAction)picUploadBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(onPicUploadBtnClicked:)]) {
        [self.delegate onPicUploadBtnClicked:nil];
    }
}

- (IBAction)msgSendBtnClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(onSendForAllBtnClicked:)]) {
        [self.delegate onSendForAllBtnClicked:nil];
    }
}

@end
