//
//  BLMainController.m
//  kaisuo
//
//  Created by 苗壮 on 2017/6/4.
//  Copyright © 2017年 苗壮. All rights reserved.
//

#import "BLMainController.h"
#import "BLLoginController.h"
#import "OneKeyApi.h"
#import "BLAppDelegate.h"

@interface BLMainController ()<YYlockApiDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIImageView *huandengpian;
@property (weak, nonatomic) IBOutlet UITableView *deviceTableView;

/** 设备id */
@property (nonatomic, retain) NSMutableArray *peripheralArray;
@property (nonatomic) BOOL isFirstLauch;
@end

@implementation BLMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _isFirstLauch  = true;
    //注册开门设备信息
    
    [self registerYYlock];
    
    //初始化蓝牙列表数组
    self.peripheralArray = [NSMutableArray array];
    
    //设置执行回调代理
    [OneKeyApi shareInstance].delegate = self;
    
 
    
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    //通过图片初始化UIImageview，这样ImageView的宽高就跟图片宽高一样了
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self.scroll addSubview:imageView];
    //self.scroll.frame.size  UIScrollView控件的大小（可视范围）
    //设置内容的宽高（可滚动范围）
    self.scroll.contentSize = image.size;
    //为UIScrollView设置上下左右额外的可拖动范围（空隙）
    self.scroll.contentInset = UIEdgeInsetsMake(10, 20, 30, 40);
    self.scroll.backgroundColor = [UIColor lightGrayColor];
    self.scroll.showsHorizontalScrollIndicator = NO;
    //self.scroll.contentOffset.x += 10;//不能直接修改对象的结构体属性的成员
    //修改UIScrollView当前拖动的位置（相对于内容左上角的坐标）
    CGPoint offset = self.scroll.contentOffset;
    
    //向左移动（查看右边的内容）
    offset.x += 50;
    //执行动画
    [UIView animateWithDuration:0.3 animations:^{
        self.scroll.contentOffset = offset;
    }];
   
}

- (IBAction)loginButtonAction:(UIButton *)sender {
    [self presentLoginViewController];
}

- (void)presentLoginViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Enrollment" bundle:nil];
    BLLoginController *loginVC = [sb instantiateViewControllerWithIdentifier:NSStringFromClass([BLLoginController class])];
    
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *) getImageFromURL:(NSString *)fileURL
{
    
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

//注册YYlock
-(void)registerYYlock
{
    keyObject *keyModel = [[keyObject alloc]init];
    keyModel.deviceId = @"F36862EA";
    keyModel.password = @"12345678";
    keyModel.RSSI = -80;
    
    keyObject *keyModel2 = [[keyObject alloc]init];
    keyModel2.deviceId = @"F3690036";
    keyModel2.password = @"12345678";
    keyModel2.RSSI = -90;
    
    keyObject *keyModel3 = [[keyObject alloc]init];
    keyModel3.deviceId = @"F3690036";
    keyModel3.password = @"68549632";
    keyModel3.RSSI = -90;
    
    NSArray *keyArray = [NSArray arrayWithObjects:keyModel,keyModel2,keyModel3,nil];
    
    //NSArray *keyArray = @[keyModel,keyModel2];
    
    //获取单例
    OneKeyApi *yylockApi = [OneKeyApi shareInstance];
    
    //初始化设备信息
    float devVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    [yylockApi registerDeviceWithMode:LOCK_MODE_MANUL andDeviceInfos:keyArray andNeedCmpRssi:NO supportBeacon:NO deviceVersion:devVersion];
     
}



//扫描设备回调
- (void)scanDeviceCallBack:(CBPeripheral *)peripheral RSSI:(int)level
{
    int i =0;
    for (CBPeripheral *peripher in [self peripheralArray]) {
        DHBle * dhBleInstance = [DHBle shareInstance];
        NSString *deviceId = [dhBleInstance getDeviceIdForStringValue:peripher];
        if( [deviceId isEqualToString:[dhBleInstance getDeviceIdForStringValue:peripheral]]){
            [self.peripheralArray replaceObjectAtIndex:i withObject:peripher];
            return;
        }
        i++;
    }
    [self.peripheralArray addObject:peripheral];
    [[OneKeyApi shareInstance] oneKeyOpenDevice:peripheral andDevicePassword:@"12345678"];

    
}
 

- (IBAction)kaisuoAction:(UIButton *)sender {
    [OneKeyApi shareInstance].delegate = self;
    [self.peripheralArray removeAllObjects];
    
    
    [[OneKeyApi shareInstance] scanDeviceWithUUID:2.0f];
    
//    NSURL *photourl = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496606994746&di=623fbda4332614d4d1dbee09f09a705b&imgtype=0&src=http%3A%2F%2Fimg.tupianzj.com%2Fuploads%2Fallimg%2F160520%2F9-160520091319.jpg"];
//    //url请求实在UI主线程中进行的
//    UIImage *images = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];//通过网络url获取uiimage
//    self.huandengpian.image = images;
    
    
    UIImageView *headview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    NSURL *photourl = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496606994746&di=623fbda4332614d4d1dbee09f09a705b&imgtype=0&src=http%3A%2F%2Fimg.tupianzj.com%2Fuploads%2Fallimg%2F160520%2F9-160520091319.jpg"];
    //url请求实在UI主线程中进行的
    UIImage *images = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];//通过网络url获取uiimage
    headview.image = images;
}

@end
