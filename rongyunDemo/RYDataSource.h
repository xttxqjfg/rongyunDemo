//
//  RYDataSource.h
//  SMA
//
//  Created by YIBO on 16/4/26.
//  Copyright © 2016年 smarthot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

#define RCDDataSource [RYDataSource shareInstance]

@interface RYDataSource : NSObject<RCIMUserInfoDataSource,RCIMGroupInfoDataSource,RCIMGroupMemberDataSource>

+(RYDataSource *) shareInstance;

@end
