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
#import "BLAvailableLocksCell.h"

@interface BLMainController ()<YYlockApiDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
//@property (weak, nonatomic) IBOutlet UIImageView *huandengpian;
@property (weak, nonatomic) IBOutlet UITableView *deviceTableView;
@property (copy, nonatomic) NSArray *devices;
@property (weak, nonatomic) IBOutlet UIButton *unlockButton;

/** 设备id */
@property (nonatomic, retain) NSMutableArray *peripheralArray;
@property (nonatomic) BOOL isFirstLauch;
@end

static NSString *kDeviceCellID = @"MainControllerDeviceCellID";

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
    
    // 注册 cell xib
    NSString *cellClassName = NSStringFromClass([BLAvailableLocksCell class]);
    [self.deviceTableView registerNib:[UINib nibWithNibName:cellClassName bundle:nil/*这里写nil就是默认[UIBundle mainBundle]*/] forCellReuseIdentifier:kDeviceCellID];
    // 简易方法干掉底部多余的空白cell。
    self.deviceTableView.tableFooterView = [UIView new];
    
    // 初始化锁列表数组（不可变数组，服务器获取的数组可能需要转化一下格式。）
    self.devices = @[];
   
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 开锁按钮设置了自适应，不能写固定数值的圆角了。
    CGFloat unlockButtonHeight = self.unlockButton.frame.size.height;
    self.unlockButton.layer.cornerRadius = unlockButtonHeight / 2;
    self.unlockButton.layer.masksToBounds = YES;
}

- (IBAction)loginButtonAction:(UIButton *)sender {
    [self presentLoginViewController];
}

- (void)presentLoginViewController {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Enrollment" bundle:nil];
    BLLoginController *loginVC = [sb instantiateViewControllerWithIdentifier:NSStringFromClass([BLLoginController class])];
    
    [self presentViewController:loginVC animated:NO completion:nil];
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 这里要根据你服务器返回的锁的数量来返回对应的列表数量。
    // 我就简单的用 self.devices 代表了。
    // return self.devices.count;
    return 4;
}

- (__kindof UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BLAvailableLocksCell *cell = [tableView dequeueReusableCellWithIdentifier:kDeviceCellID forIndexPath:indexPath];
    // 这里有一种是带indexPath的，另一种是不带的。在viewDidLoad中注册cell的就用当前这种带indexPath写法。
    // 然后根据返回的锁的名称给每个cell赋值。
    // [cell updateCellWithModel:self.devices[indexPath.row]];
    // 因为还没有数据，也没有给数据变成model，你就直接给cell赋值就好了。
    cell.lockNameLabel.text = @"啥？";
    cell.lockSwitch.on = YES;
    return cell;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {return 1;}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {return 44;}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 按一下之后立刻反选。
    // 或者要push某些页面，在这里操作。
    // 如果要禁止cell点击， 不在这里操作。在tableview的设置里操作。
}
@end
