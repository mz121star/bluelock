//
//  BLLoginController.m
//  kaisuo
//
//  Created by XenonChau on 29/01/2018.
//  Copyright © 2018 苗壮. All rights reserved.
//

#import "BLLoginController.h"
#import "XCNetworkHandler.h"
#import "BLUserModel.h"


@interface BLLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTxt;
@property (weak, nonatomic) IBOutlet UITextField *idcardTxt;

@end

@implementation BLLoginController
- (IBAction)closeViewController:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginButtonAction:(UIButton *)sender {
    
    NSInteger timestamp = ceil([[NSDate date] timeIntervalSince1970]);
    
    
    /**
     由于后端需要固定顺序的签名，而无序的字典没办法做到。所以只能用数组来控制参数顺序。
     */
    
    NSArray *paramsArray = @[@{@"phone":self.phoneTxt.text},@{@"idcard":self.idcardTxt.text},@{@"key":privateKey},@{@"time":@(timestamp).stringValue}];
    
    [XCNetworkHandler xc_post:RequestURL[ReqSignIn] // 可视化API地址
                      paramas:paramsArray   // 参数列表
                    withToken:NO    // 是否带 user.token ，我们的业务逻辑是先去请求用户表，获取到当前用户的token再把token加上。
                 andSignature:YES   // 是否加签名
                      success:^(id  _Nullable success) {
                          // 成功返回值
                          NSLog(@"成功");
                          
                          [BLUserModel mj_setupObjectClassInArray:^NSDictionary *{
                              return @{
                                  @"devices":@"BLDeviceModel"
                              };
                          }];
                          
                          BLUserModel *userModel = [[BLUserModel alloc] initWithDictionary:success];
                          
                          
                          NSLog(@"小区名称：%@", userModel.residential.name);
                          NSLog(@"物业名称：%@", userModel.residential.enterpriseName);
                          
                          NSLog(@"设备列表：%@", userModel.devices);
                          if (userModel.devices.count) {
                              BLDeviceModel *device = userModel.devices[0];
                              NSLog(@"设备ID：%@", device.deviceId);
                              NSLog(@"设备名称：%@", device.deviceName);
                              NSLog(@"设备密码：%@", device.devicePSW);
                          }
                          
                          
                          // 然后这里你就可以写一个本地存储来保存用户信息。在后面开锁的时候会用到。
                          // 最简单的方法就是用 NSUserDefaults => 到 XCUtils 里去写比较好，我里面写了一堆公司用的samples了。哈哈哈哈
                          // 也可以用 NSKeyedArchiver / NSKeyedUnarchiver
                          // 或者 第三方sqlite管理工具： FMDB。
                          // ❌不推荐用 苹果自带 的那个坑爹玩意：CoreData。
                          
                          [self closeViewController:nil];
                      } failure:^(id  _Nullable failure) {
                          // 失败返回值
                          NSLog(@"失败");
                      } error:^(NSError * _Nullable error) {
                          // 服务器500、客户端网络断线的返回值
                          NSLog(@"错误");
                      }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

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
