//
//  ExtendChatVC.m
//  rongyunDemo
//
//  Created by 易博 on 2017/12/28.
//  Copyright © 2017年 易博. All rights reserved.
//

#import "ExtendChatVC.h"

@implementation ExtendChatVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if (ConversationType_APPSERVICE == self.conversationType) {
        [self.chatSessionInputBarControl setInputBarType:RCChatSessionInputBarControlPubType style:RC_CHAT_INPUT_BAR_STYLE_CONTAINER];
        
        CGRect containFrame = self.chatSessionInputBarControl.menuContainerView.bounds;
        CGFloat btnW = containFrame.size.width / 3;
        CGFloat btnH = containFrame.size.height;
        
        UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, btnW, btnH)];
        [btn1 setTitle:@"时事新闻" forState:(UIControlStateNormal)];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.chatSessionInputBarControl.menuContainerView addSubview:btn1];
        
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(btnW, 0, btnW, btnH)];
        [btn2 setTitle:@"政策资讯" forState:(UIControlStateNormal)];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.chatSessionInputBarControl.menuContainerView addSubview:btn2];
        
        UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(btnW*2, 0, btnW, btnH)];
        [btn3 setTitle:@"关于我们" forState:(UIControlStateNormal)];
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.chatSessionInputBarControl.menuContainerView addSubview:btn3];
    }
}

@end
