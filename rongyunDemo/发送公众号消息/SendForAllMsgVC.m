//
//  SendForAllMsgVC.m
//  rongyunDemo
//
//  Created by 易博 on 2018/1/4.
//  Copyright © 2018年 易博. All rights reserved.
//

#import "SendForAllMsgVC.h"

#import "SendForAllMsgView.h"

#import <AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>

@interface SendForAllMsgVC ()<SendForAllMsgViewDelegate>

@property (nonatomic,strong) SendForAllMsgView *sendForAllMsgView;

@end

@implementation SendForAllMsgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.title = @"群发图文消息";
    
    [self.view addSubview:self.sendForAllMsgView];
}

-(void)onPicUploadBtnClicked:(NSDictionary *)picInfo
{
    NSString *randomNumber = [self getRandomNumber];
    NSString *timeStamp = [self getCurrentTimeStamp];
    NSString *signStr = [self getSHA1Str:[NSString stringWithFormat:@"OQ7Dwl5x3Mp%@%@",randomNumber,timeStamp]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15.f;
    
    //融云需要的请求头信息
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *postUrl = [NSString stringWithFormat:@"http://api.ps.ronghub.com/media/upload?type=thumb&RC-App-Key=ik1qhw09iv72p&RC-Nonce=%@&RC-Timestamp=%@&RC-Signature=%@",randomNumber,timeStamp,signStr];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/xml", nil];
    
    UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"2018010401.jpg" ofType:nil]];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0);
    
    [manager POST:postUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:imageData name:@"2018010401.jpg" fileName:@"2018010401.jpg" mimeType:@"image/jpeg"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //
        NSLog(@"请求成功:%@",responseObject);
        
        if ([responseObject objectForKey:@"media_id"]) {
            self.sendForAllMsgView.thumb_media_id = [responseObject objectForKey:@"media_id"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        NSLog(@"请求失败:%@",error.localizedDescription);
        
    }];
}

-(void)onSendForAllBtnClicked:(NSDictionary *)msgInfo
{
    [self sendMsg:@""];
    return;
    
    NSString *randomNumber = [self getRandomNumber];
    NSString *timeStamp = [self getCurrentTimeStamp];
    NSString *signStr = [self getSHA1Str:[NSString stringWithFormat:@"OQ7Dwl5x3Mp%@%@",randomNumber,timeStamp]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15.f;
    
    //融云需要的请求头信息
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *postUrl = [NSString stringWithFormat:@"http://api.ps.ronghub.com/media/uploadnews?type=thumb&RC-App-Key=ik1qhw09iv72p&RC-Nonce=%@&RC-Timestamp=%@&RC-Signature=%@",randomNumber,timeStamp,signStr];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/xml", nil];
    
    NSDictionary *params = @{@"articles":@[@{@"thumb_media_id":@"fe2f512216b54df78871ef2496fda879",@"author":@"管理员",@"title":@"这是一个测试图文消息群发一",@"content_source_url":@"http://www.baidu.com",@"content":@"这是一个测试图文消息群发一这是一个测试图文消息群发一这是一个测试图文消息群发一这是一个测试图文消息群发一这是一个测试图文消息群发一这是一个测试图文消息群发一这是一个测试图文消息群发一",@"digest":@"一",@"show_cover_pic":@"1"},
                                           @{@"thumb_media_id":@"edb2fe51225f47d49e07c8409861d59a",@"author":@"测试1",@"title":@"这是一个测试图文消息群发二",@"content_source_url":@"http://www.baidu.com",@"content":@"这是一个测试图文消息群发二这是一个测试图文消息群发二这是一个测试图文消息群发二这是一个测试图文消息群发二这是一个测试图文消息群发二这是一个测试图文消息群发二这是一个测试图文消息群发二这是一个测试图文消息群发二",@"digest":@"二",@"show_cover_pic":@"0"},
                                           @{@"thumb_media_id":@"fe2f512216b54df78871ef2496fda879",@"author":@"测试2",@"title":@"这是一个测试图文消息群发三",@"content_source_url":@"http://www.baidu.com",@"content":@"这是一个测试图文消息群发三这是一个测试图文消息群发三这是一个测试图文消息群发三这是一个测试图文消息群发三这是一个测试图文消息群发三这是一个测试图文消息群发三这是一个测试图文消息群发三",@"digest":@"三",@"show_cover_pic":@"1"}]};
    
    [manager POST:postUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"请求成功:%@",responseObject);
        
        if ([responseObject objectForKey:@"media_id"]) {
            [self sendMsg:[responseObject objectForKey:@"media_id"]];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败:%@",error.localizedDescription);
        
    }];
}

-(void)sendMsg:(NSString *)msgMediaId
{
    NSString *randomNumber = [self getRandomNumber];
    NSString *timeStamp = [self getCurrentTimeStamp];
    NSString *signStr = [self getSHA1Str:[NSString stringWithFormat:@"OQ7Dwl5x3Mp%@%@",randomNumber,timeStamp]];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15.f;
    
    //融云需要的请求头信息
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"ik1qhw09iv72p" forHTTPHeaderField:@"RC-App-Key"];
    [manager.requestSerializer setValue:randomNumber forHTTPHeaderField:@"RC-Nonce"];
    [manager.requestSerializer setValue:timeStamp forHTTPHeaderField:@"RC-Timestamp"];
    [manager.requestSerializer setValue:signStr forHTTPHeaderField:@"RC-Signature"];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/xml", nil];
    
    NSDictionary *params = @{@"fromuser":@"it_12306@ik1qhw09iv72p",
                             @"filter":@{@"is_to_all":@"true"},
                             @"mpnews":@{@"media_id":@"f22fcbdf1ba040a5b40a35930593a3a9"},
                             @"msgtype":@"mpnews"};
    
    [manager POST:@"https://api.ps.ronghub.com/message/sendall.json" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        NSLog(@"请求成功:%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"请求失败:%@",error.localizedDescription);
        
    }];
}

-(NSString *)getRandomNumber
{
    //1到9999的两位随机数
    int value = (arc4random() % 9999) + 1;
    
    return [NSString stringWithFormat:@"%d",value];
}

-(NSString *)getCurrentTimeStamp
{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time = [date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    
    return timeString;
}

-(NSString *)getSHA1Str:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

-(SendForAllMsgView *)sendForAllMsgView
{
    if (!_sendForAllMsgView) {
        _sendForAllMsgView = [[SendForAllMsgView alloc]initWithFrame:self.view.bounds];
        _sendForAllMsgView.delegate = self;
    }
    return _sendForAllMsgView;
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
