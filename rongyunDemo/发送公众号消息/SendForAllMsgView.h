//
//  SendForAllMsgView.h
//  rongyunDemo
//
//  Created by 易博 on 2018/1/4.
//  Copyright © 2018年 易博. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SendForAllMsgViewDelegate <NSObject>

-(void)onSendForAllBtnClicked:(NSDictionary *)msgInfo;

-(void)onPicUploadBtnClicked:(NSDictionary *)picInfo;

@end

@interface SendForAllMsgView : UIView

@property (nonatomic,assign) id<SendForAllMsgViewDelegate> delegate;

@property (nonatomic,strong) NSString *thumb_media_id;

@end
