//
//  TextServiceMsgView.h
//  rongyunDemo
//
//  Created by 易博 on 2017/12/29.
//  Copyright © 2017年 易博. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextServiceMsgViewDelegate <NSObject>

-(void)onSendTextMsgBtnClicked:(NSDictionary *)msgInfo forAll:(BOOL) forAll;

@end

@interface TextServiceMsgView : UIView

@property (nonatomic,assign) id<TextServiceMsgViewDelegate> delegate;

@end
