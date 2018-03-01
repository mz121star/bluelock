//
//  KCStatusTableViewCell.m
//  kaisuo
//
//  Created by 苗壮 on 2018/3/1.
//  Copyright © 2018年 苗壮. All rights reserved.
//

#import "KCStatusTableViewCell.h"
#import "BLUserModel.h"
#define KCColor(r,g,b) [UIColor colorWithHue:r/255.0 saturation:g/255.0 brightness:b/255.0 alpha:1] //颜色宏定义
#define kStatusTableViewCellControlSpacing 10 //控件间距
#define kStatusTableViewCellBackgroundColor KCColor(251,251,251)
#define kStatusGrayColor KCColor(50,50,50)
#define kStatusLightGrayColor KCColor(120,120,120)

#define kStatusTableViewCellAvatarWidth 40 //头像宽度
#define kStatusTableViewCellAvatarHeight kStatusTableViewCellAvatarWidth
#define kStatusTableViewCellUserNameFontSize 14
#define kStatusTableViewCellMbTypeWidth 13 //会员图标宽度
#define kStatusTableViewCellMbTypeHeight kStatusTableViewCellMbTypeWidth
#define kStatusTableViewCellCreateAtFontSize 12
#define kStatusTableViewCellSourceFontSize 12
#define kStatusTableViewCellTextFontSize 14


@interface KCStatusTableViewCell(){
    UIImageView *_avatar;//头像
    UIImageView *_mbType;//会员类型
    UILabel *_userName;
    UILabel *_createAt;
    UILabel *_source;
    UILabel *_text;
}

@end

@implementation KCStatusTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubView];
    }
    return self;
}

#pragma mark 初始化视图
-(void)initSubView{
    //头像控件
    _avatar=[[UIImageView alloc]init];
    [self.contentView addSubview:_avatar];
    //用户名
    _userName=[[UILabel alloc]init];
    _userName.textColor=kStatusGrayColor;
    _userName.font=[UIFont systemFontOfSize:kStatusTableViewCellUserNameFontSize];
    [self.contentView addSubview:_userName];
    //会员类型
    _mbType=[[UIImageView alloc]init];
    [self.contentView addSubview:_mbType];
    //日期
    _createAt=[[UILabel alloc]init];
    _createAt.textColor=kStatusLightGrayColor;
    _createAt.font=[UIFont systemFontOfSize:kStatusTableViewCellCreateAtFontSize];
    [self.contentView addSubview:_createAt];
    //设备
    _source=[[UILabel alloc]init];
    _source.textColor=kStatusLightGrayColor;
    _source.font=[UIFont systemFontOfSize:kStatusTableViewCellSourceFontSize];
    [self.contentView addSubview:_source];
    //内容
    _text=[[UILabel alloc]init];
    _text.textColor=kStatusGrayColor;
    _text.font=[UIFont systemFontOfSize:kStatusTableViewCellTextFontSize];
    _text.numberOfLines=0;
    //    _text.lineBreakMode=NSLineBreakByWordWrapping;
    [self.contentView addSubview:_text];
}

#pragma mark 设置微博
-(void)setDevice:(BLDeviceModel *)device{
    //设置头像大小和位置
    CGFloat avatarX=10,avatarY=10;
    CGRect avatarRect=CGRectMake(avatarX, avatarY, kStatusTableViewCellAvatarWidth, kStatusTableViewCellAvatarHeight);
    _avatar.image=[UIImage imageNamed:device.deviceImg];
    _avatar.frame=avatarRect;
    
    
    //设置会员图标大小和位置
    CGFloat userNameX= CGRectGetMaxX(_avatar.frame)+kStatusTableViewCellControlSpacing ;
    CGFloat userNameY=avatarY;
    //根据文本内容取得文本占用空间大小
    CGSize userNameSize=[device.deviceName sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kStatusTableViewCellUserNameFontSize]}];
    CGRect userNameRect=CGRectMake(userNameX, userNameY, userNameSize.width,userNameSize.height);
    _userName.text=device.deviceName;
    _userName.frame=userNameRect;
    
    
    //设置会员图标大小和位置
    CGFloat mbTypeX=CGRectGetMaxX(_userName.frame)+kStatusTableViewCellControlSpacing;
    CGFloat mbTypeY=avatarY;
    CGRect mbTypeRect=CGRectMake(mbTypeX, mbTypeY, kStatusTableViewCellMbTypeWidth, kStatusTableViewCellMbTypeHeight);
    _mbType.image=[UIImage imageNamed:device.deviceImg];
    _mbType.frame=mbTypeRect;
    
    
    //设置发布日期大小和位置
    CGSize createAtSize=[device.deviceId sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kStatusTableViewCellCreateAtFontSize]}];
    CGFloat createAtX=userNameX;
    CGFloat createAtY=CGRectGetMaxY(_avatar.frame)-createAtSize.height;
    CGRect createAtRect=CGRectMake(createAtX, createAtY, createAtSize.width, createAtSize.height);
    _createAt.text=device.deviceId;
    _createAt.frame=createAtRect;
    
    
    //设置设备信息大小和位置
    CGSize sourceSize=[device.devicePSW sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kStatusTableViewCellSourceFontSize]}];
    CGFloat sourceX=CGRectGetMaxX(_createAt.frame)+kStatusTableViewCellControlSpacing;
    CGFloat sourceY=createAtY;
    CGRect sourceRect=CGRectMake(sourceX, sourceY, sourceSize.width,sourceSize.height);
    _source.text=device.devicePSW;
    _source.frame=sourceRect;
    
    
    //设置微博内容大小和位置
    CGFloat textX=avatarX;
    CGFloat textY=CGRectGetMaxY(_avatar.frame)+kStatusTableViewCellControlSpacing;
    CGFloat textWidth=self.frame.size.width-kStatusTableViewCellControlSpacing*2;
    CGSize textSize=[device.deviceName boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:kStatusTableViewCellTextFontSize]} context:nil].size;
    CGRect textRect=CGRectMake(textX, textY, textSize.width, textSize.height);
    _text.text=device.deviceName;
    _text.frame=textRect;
    
    _height=CGRectGetMaxY(_text.frame)+kStatusTableViewCellControlSpacing;
}

#pragma mark 重写选择事件，取消选中
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
}
@end

