//
//  ViewController.m
//  rongyunDemo
//
//  Created by 易博 on 2017/12/28.
//  Copyright © 2017年 易博. All rights reserved.
//

#import "ViewController.h"

#import <RongIMKit/RongIMKit.h>
#import "ExtendConversationVC.h"
#import "PublicServiceVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *userTableView;

@property (nonatomic,strong) NSMutableArray *userList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.title = @"用户列表";
    
    [self.view addSubview:self.userTableView];
}

#pragma mark 融云相关
-(void)loginRongClould:(NSDictionary *)dic
{
    [[RCIM sharedRCIM] connectWithToken:[NSString stringWithFormat:@"%@",[dic objectForKey:@"userToken"]] success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
        
        UITabBarController *rootTabVC = [self createTabbarVC];
        [self presentViewController:rootTabVC animated:YES completion:^{
            
        }];
        
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%d", status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}

-(UITabBarController *)createTabbarVC
{
    ExtendConversationVC *chatListVC = [[ExtendConversationVC alloc]init];
    chatListVC.title = @"会话列表";
    chatListVC.tabBarItem.title = @"消息";
    chatListVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"chat_room"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    chatListVC.tabBarItem.image = [[UIImage imageNamed:@"chat_room_inactive"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *firstNavVC = [[UINavigationController alloc]
                                          initWithRootViewController:chatListVC];
    
    PublicServiceVC *publicServiceVC = [[PublicServiceVC alloc]init];
    publicServiceVC.title = @"公众号";
    publicServiceVC.tabBarItem.title = @"公众号";
    publicServiceVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"icon_Contacts_hover"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    publicServiceVC.tabBarItem.image = [[UIImage imageNamed:@"icon_Contacts"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *secondNavVC = [[UINavigationController alloc]
                                          initWithRootViewController:publicServiceVC];
    
    UITabBarController *tabVC = [[UITabBarController alloc] init];
    tabVC.viewControllers = @[firstNavVC,secondNavVC];
    [tabVC setSelectedIndex:0];
    
    return tabVC;
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *userInfo = [[NSDictionary alloc]initWithDictionary:[self.userList objectAtIndex:indexPath.row]];
    [self loginRongClould:userInfo];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"userCell"];
    }
    
    NSDictionary *userInfo = [[NSDictionary alloc]initWithDictionary:[self.userList objectAtIndex:indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"userId:%@----userName:%@",[userInfo objectForKey:@"userId"],[userInfo objectForKey:@"userName"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[userInfo objectForKey:@"userToken"]];
    cell.detailTextLabel.numberOfLines = 0;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *markLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
    markLable.numberOfLines = 0;
    markLable.textAlignment = NSTextAlignmentCenter;
    markLable.textColor = [UIColor redColor];
    markLable.text = @"请选择对应的用户账号登录\n确保列表中的用户均已经在融云后台注册";
    
    return markLable;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

#pragma mark - get
-(UITableView *)userTableView
{
    if (!_userTableView) {
        _userTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
        _userTableView.delegate = self;
        _userTableView.dataSource = self;
        _userTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _userTableView;
}

-(NSMutableArray *)userList
{
    if (!_userList) {
        _userList = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ryUserList.plist" ofType:nil]];
    }
    return _userList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
