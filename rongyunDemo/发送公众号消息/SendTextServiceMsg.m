//
//  SendTextServiceMsg.m
//  rongyunDemo
//
//  Created by 易博 on 2017/12/29.
//  Copyright © 2017年 易博. All rights reserved.
//

#import "SendTextServiceMsg.h"

#import "TextServiceMsgView.h"

#import <AFNetworking.h>
#import <CommonCrypto/CommonDigest.h>

@interface SendTextServiceMsg ()<TextServiceMsgViewDelegate>

@property (nonatomic,strong) TextServiceMsgView *textServiceMsgView;

@end

@implementation SendTextServiceMsg

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.title = @"发送文本消息";
    
    [self.view addSubview:self.textServiceMsgView];
}

-(void)onSendTextMsgBtnClicked:(NSDictionary *)msgInfo forAll:(BOOL)forAll
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
    
    NSDictionary *params = @{
                           @"fromuser":[NSString stringWithFormat:@"%@@ik1qhw09iv72p",[msgInfo objectForKey:@"fromuser"]],
                           @"touser":[NSString stringWithFormat:@"%@@ik1qhw09iv72p",[msgInfo objectForKey:@"touser"]],
                           @"msgtype":@"text",
                           @"text":@{@"content":[msgInfo objectForKey:@"content"]}
                           };
    
    [manager POST:@"https://api.ps.ronghub.com/message/send.json" parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
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

-(TextServiceMsgView *)textServiceMsgView
{
    if (!_textServiceMsgView) {
        _textServiceMsgView = [[TextServiceMsgView alloc]initWithFrame:self.view.bounds];
        _textServiceMsgView.delegate = self;
    }
    return _textServiceMsgView;
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
