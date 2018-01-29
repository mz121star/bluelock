//
//  BLLoginController.m
//  kaisuo
//
//  Created by XenonChau on 29/01/2018.
//  Copyright © 2018 苗壮. All rights reserved.
//

#import "BLLoginController.h"
#import "XCNetworkHandler.h"

@interface BLLoginController ()

@end

@implementation BLLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSDictionary *params = @{
//                             @"phone": @"",
//                             @"idcard": @"",
//                             @"time": @"",
//                             @"sign": @""
//                             };
    NSInteger timestamp = ceil([[NSDate date] timeIntervalSince1970]);
    
    
    /**
     由于后端需要固定顺序的签名，而无序的字典没办法做到。所以只能用数组来控制参数顺序。
     */
    
    NSArray *paramsArray = @[@{@"phone":@"从用户输入框里拿"},@{@"idcard":@"从用户登录输入框里拿"},@{@"key":privateKey},@{@"time":@(timestamp).stringValue}];
    
    [XCNetworkHandler xc_post:RequestURL[ReqSignIn] // 可视化API地址
                      paramas:paramsArray   // 参数列表
                    withToken:NO    // 是否带 user.token ，我们的业务逻辑是先去请求用户表，获取到当前用户的token再把token加上。
                 andSignature:YES   // 是否加签名
                      success:^(id  _Nullable success) {
                          // 成功返回值
                          
                      } failure:^(id  _Nullable failure) {
                          // 失败返回值
                          
                      } error:^(NSError * _Nullable error) {
                          // 服务器500、客户端网络断线的返回值
                          
                      }];
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
