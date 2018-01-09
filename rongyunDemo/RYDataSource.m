//
//  RYDataSource.m
//  SMA
//
//  Created by YIBO on 16/4/26.
//  Copyright © 2016年 smarthot. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>
#import "RYDataSource.h"

#define DEFAULTS [NSUserDefaults standardUserDefaults]

@interface RYDataSource ()

@end

@implementation RYDataSource

+ (RYDataSource*)shareInstance{
    static RYDataSource* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
        
    });
    return instance;
}

#pragma mark - GroupInfoFetcherDelegate
- (void)getGroupInfoWithGroupId:(NSString*)groupId completion:(void (^)(RCGroup*))completion{
    if ([groupId length] == 0)
        return;
}

#pragma mark - RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString*)userId completion:(void (^)(RCUserInfo*))completion{
    NSLog(@"getUserInfoWithUserId ----- %@", userId);
    
    NSMutableArray *userlist = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ryUserList.plist" ofType:nil]];
    
    BOOL mark = NO;
    NSInteger i = 0;
    for (NSDictionary *dic in userlist) {
        i++;
        if([[dic objectForKey:@"userId"] isEqualToString:userId])
        {
            mark = YES;
            break;
        }
    }
    
    if (mark) {
        NSDictionary *dic = [userlist objectAtIndex:i];
        RCUserInfo *userInfo = [[RCUserInfo alloc]init];
        userInfo.userId = [dic objectForKey:@"userId"];
        userInfo.name = [dic objectForKey:@"userName"];
        completion(userInfo);
    }
    else
    {
        completion(nil);
    }
}

#pragma mark - RCIMGroupMemberDataSource
-(void)getAllMembersOfGroup:(NSString *)groupId result:(void (^)(NSArray<NSString *> *))resultBlock{
    NSLog(@"getAllMembersOfGroup ----- %@", groupId);
    
}

//#pragma mark - RCIMGroupUserInfoDataSource
///**
// *  获取群组内的用户信息。
// *  如果群组内没有设置用户信息，请注意：1，不要调用别的接口返回全局用户信息，直接回调给我们nil就行，SDK会自己巧用用户信息提供者；2一定要调用completion(nil)，这样SDK才能继续往下操作。
// *
// *  @param groupId  群组ID.
// *  @param completion 获取完成调用的BLOCK.
// */
//- (void)getUserInfoWithUserId:(NSString *)userId inGroup:(NSString *)groupId
//                   completion:(void (^)(RCUserInfo *userInfo))completion {
//    //在这里查询该group内的群名片信息，如果能查到，调用completion返回。如果查询不到也一定要调用completion(nil)
//    if ([groupId isEqualToString:@"22"] && [userId isEqualToString:@"30806"]) {
//        completion([[RCUserInfo alloc] initWithUserId:@"30806" name:@"我在22群中的名片" portrait:nil]);
//    } else {
//        completion(nil);//融云demo中暂时没有实现，以后会添加上该功能。app也可以自己实现该功能。
//    }
//}

@end
