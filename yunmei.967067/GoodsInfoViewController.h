//
//  GoodsInfoViewController.h
//  yunmei.967067
//
//  Created by ken on 12-12-3.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMGlobal.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "AppDelegate.h"
#import "GoodsModel.h"
#import <QuartzCore/QuartzCore.h>
#import "YMUIButton.h"
@interface GoodsInfoViewController : UIViewController<
    UITableViewDataSource,
    UITableViewDelegate,
    UITabBarDelegate,
    UITextFieldDelegate,
    UIScrollViewDelegate
>

@property(strong, nonatomic)NSString *goodsId;
@property(strong, nonatomic)GoodsModel *goodsModel;
@property (strong, nonatomic) IBOutlet UITableView *goodsTableView;
//这个属性设置为最后一次点击的尺寸按钮的一个强引用
@property(strong,nonatomic)UIButton *sizeBtn;
//这个属性设置为最后一次点击的颜色按钮的一个强引用
@property(strong,nonatomic)UIButton *colorBtn;

//为这个页添加一个toolbar
@property(strong, nonatomic)UIToolbar *textControlToolbar;
//尺寸按钮绑定事件

//这个属性作为数量输入框textFeild一个引用
@property(strong,nonatomic)UITextField *firstResponderTextFeild;

//定义头部的ScrollView
@property(strong,nonatomic)UIScrollView *goodsImageScrollView;
//定义商品详情部分的section
@property(strong,nonatomic)UITableView *goodsDetailTableView;
//定义商品所有图片的数组
@property(strong,nonatomic)NSMutableArray *goodsImagesArr;
-(void)chiMaCliked:(id)sender;
//颜色按钮绑定事件
-(void)colorBtnClicked:(id)sender;
@end
