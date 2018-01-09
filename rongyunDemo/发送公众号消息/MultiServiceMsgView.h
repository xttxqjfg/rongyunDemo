//
//  MultiServiceMsgView.h
//  rongyunDemo
//
//  Created by 易博 on 2017/12/29.
//  Copyright © 2017年 易博. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MultiServiceMsgViewDelegate <NSObject>

-(void)onSendMultiMsgBtnClicked:(NSDictionary *)msgInfo forAll:(BOOL) forAll;

-(void)onSwitchBtnChanged:(BOOL) forAll;

@end

@interface MultiServiceMsgView : UIView

@property (nonatomic,assign) id<MultiServiceMsgViewDelegate> delegate;

@end
