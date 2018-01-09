//
//  PublicServiceVC.m
//  rongyunDemo
//
//  Created by 易博 on 2017/12/29.
//  Copyright © 2017年 易博. All rights reserved.
//

#import "PublicServiceVC.h"

#import <RongIMKit/RongIMKit.h>
#import "SendTextServiceMsg.h"
#import "SendMulMediaServiceMsg.h"

@interface PublicServiceVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *pubTableView;

@property (nonatomic,strong) NSMutableArray *pubList;
@end

@implementation PublicServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.pubTableView];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //系统导航栏自带的返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    
    if (0 == indexPath.row) {
        // 启动已关注的公众号列表功能
        RCPublicServiceListViewController *publicServiceVC = [[RCPublicServiceListViewController alloc] init];
        publicServiceVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:publicServiceVC  animated:YES];
    }
    else if(1 == indexPath.row)
    {
        // 启动搜索公众号功能
        RCPublicServiceSearchViewController *searchFirendVC = [[RCPublicServiceSearchViewController alloc] init];
        searchFirendVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchFirendVC  animated:YES];
    }
    else if(2 == indexPath.row)
    {
        //公众号发送文本信息
        SendTextServiceMsg *textMsgVC = [[SendTextServiceMsg alloc] init];
        textMsgVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:textMsgVC  animated:YES];
    }
    else if(3 == indexPath.row)
    {
        //公众号发送图文信息
        SendMulMediaServiceMsg *mulMsgVC = [[SendMulMediaServiceMsg alloc] init];
        mulMsgVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mulMsgVC  animated:YES];
    }
    else
    {
        //
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pubCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"pubCell"];
    }
    
    NSDictionary *pubInfo = [[NSDictionary alloc]initWithDictionary:[self.pubList objectAtIndex:indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[pubInfo objectForKey:@"name"]];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pubList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark - get
-(UITableView *)pubTableView
{
    if (!_pubTableView) {
        _pubTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _pubTableView.delegate = self;
        _pubTableView.dataSource = self;
        _pubTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _pubTableView;
}

-(NSMutableArray *)pubList
{
    if (!_pubList) {
        _pubList = [[NSMutableArray alloc] initWithObjects:@{@"name":@"我的关注列表"},@{@"name":@"公众号搜索"},@{@"name":@"文本公众号消息"},@{@"name":@"图文公众号消息"},nil];
    }
    return _pubList;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
