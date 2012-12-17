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
//在用户选择完产品的规格以后，将需要更改显示的产品的属性作为该视图的一种属性
@property(strong,nonatomic)UILabel *nameLable;
@property(strong,nonatomic)UILabel *priceLable;
@property(strong,nonatomic)UILabel *marketPriceLable;
@property(strong,nonatomic)UIButton *quickBuyBtn;
@property(strong,nonatomic)NSMutableDictionary *selectedProduct;
//定义可选择属性
@property(strong,nonatomic)NSMutableArray *specArr;
@property(strong, nonatomic)NSString *goodsId;
@property(strong, nonatomic)GoodsModel *goodsModel;
@property(strong, nonatomic) IBOutlet UITableView *goodsTableView;
@property(strong,nonatomic)NSMutableArray *chooseParam;
//这个字典用来存放每个属性选择按钮存对应的spec标识
@property(strong,nonatomic)NSMutableDictionary *keyToSpec;
//这个字典用来存放从请求中获取的一种商品的不同货品
@property(strong,nonatomic)NSMutableDictionary *goodsDictionary;
//这个属性设置为最后一次点击的尺寸按钮的一个强引用
@property(strong,nonatomic)NSMutableDictionary *paramBtnDictionary;
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
