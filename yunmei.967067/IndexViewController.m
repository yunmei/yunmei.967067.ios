//
//  IndexViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-2.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "IndexViewController.h"
#import "YMGlobal.h"
#import "GoodsListViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "SBJson.h"
#import "GoodsModel.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

@synthesize adScrollView;
@synthesize adList;
@synthesize adPageView;
@synthesize adPageProgressView;
@synthesize goodsList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"首页", @"首页");
        self.navigationItem.title = @"齐鲁直销商城";
        [self.tabBarItem setImage:[UIImage imageNamed:@"tabbar_index"]];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_index"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_index_unselected"]];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    // 初始化广告
    self.adScrollView.contentSize = CGSizeMake(320, 129);
    self.adScrollView.pagingEnabled = TRUE;
    self.adScrollView.tag = 1;
    [self.adScrollView setDelegate:self];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 129)];
    [imageView setImage:[UIImage imageNamed:@"ad_default"]];
    [self.adScrollView addSubview:imageView];
    [self.adPageView setBackgroundColor:[UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1.0]];
    [self.adPageView addSubview:self.adPageProgressView];
    
    // 获取广告
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"ad_getAdList" forKey:@"act"];
    MKNetworkOperation* op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
        if ([[object objectForKey:@"errorMessage"] isEqualToString:@"success"]) {
            int i = 1;
            for (id o in [object objectForKey:@"data"]) {
                AdModel *adModel = [[AdModel alloc]init];
                adModel.adid = i;
                adModel.goodsIds = [o objectForKey:@"goodsIds"];
                adModel.imageUrl = [o objectForKey:@"imageUrl"];
                adModel.desc = [o objectForKey:@"desc"];
                i++;
                [self.adList addObject:adModel];
            }
            [self showAdList];
            [self setAdPage:1.0 countPage:(i-1)];
        }
        [HUD hide:YES];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"Error:%@", error);
        [HUD hide:YES];
    }];
    [ApplicationDelegate.appEngine enqueueOperation: op];
    
    // searchBgView
    UIImageView *searchBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 43)];
    [searchBgImageView setImage:[UIImage imageNamed:@"search_bg"]];
    [self.searchBgView addSubview:searchBgImageView];
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(8, 5, 207, 31)];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search_btn"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBgView addSubview:searchBtn];
    UIButton *tdbBtn = [[UIButton alloc]initWithFrame:CGRectMake(220, 4, 91, 32)];
    [tdbBtn setBackgroundImage:[UIImage imageNamed:@"tdc_btn"] forState:UIControlStateNormal];
    [tdbBtn addTarget:self action:@selector(tdbClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchBgView addSubview:tdbBtn];
    
    // imageAdView - getNewAdImage
    params = [NSMutableDictionary dictionaryWithObject:@"goods_getNewAdImage" forKey:@"act"];
    op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
        if ([[object objectForKey:@"errorMessage"] isEqualToString:@"success"]) {
            NSString *imageUrl = [[object objectForKey:@"data"]objectForKey:@"imageUrl"];
            UIButton *adImageBtn0 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 160, 80)];
            [adImageBtn0 setBackgroundImage:[UIImage imageNamed:@"ad_default"] forState:UIControlStateNormal];
            [adImageBtn0 addTarget:self action:@selector(newAdClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [YMGlobal loadImage:imageUrl andButton:adImageBtn0 andControlState:UIControlStateNormal];
            [self.imageAdView addSubview:adImageBtn0];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"Error:%@", error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation: op];

    // imageAdView - getHotAdImage
    params = [NSMutableDictionary dictionaryWithObject:@"goods_getHotAdImage" forKey:@"act"];
    op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
        if ([[object objectForKey:@"errorMessage"] isEqualToString:@"success"]) {
            NSString *imageUrl = [[object objectForKey:@"data"]objectForKey:@"imageUrl"];
            UIButton *adImageBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(160, 0, 160, 80)];
            [adImageBtn1 setBackgroundImage:[UIImage imageNamed:@"ad_default"] forState:UIControlStateNormal];
            [adImageBtn1 addTarget:self action:@selector(hotAdClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [YMGlobal loadImage:imageUrl andButton:adImageBtn1 andControlState:UIControlStateNormal];
            [self.imageAdView addSubview:adImageBtn1];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
         NSLog(@"Error:%@", error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation: op];
    
    // 产品推荐列表
    params = [NSMutableDictionary dictionaryWithObject:@"goods_getCommendList" forKey:@"act"];
    op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
        if ([[object objectForKey:@"errorMessage"] isEqualToString:@"success"]) {
            for (id o in [object objectForKey:@"data"]) {
                GoodsModel *goodsModel = [[GoodsModel alloc]init];
                goodsModel.goodsId = [o objectForKey:@"goodsId"];
                goodsModel.goodsName = [o objectForKey:@"goodsName"];
                goodsModel.goodsPrice = [o objectForKey:@"goodsPrice"];
                goodsModel.imageUrl = [o objectForKey:@"imageUrl"];
                [self.goodsList addObject:goodsModel];
            }
            [self showGoodsList];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"Error:%@", error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation: op];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setAdScrollView:nil];
    self.adPageView = nil;
    self.adList = nil;
    [self setSearchBgView:nil];
    [self setImageAdView:nil];
    [self setGoodsListView:nil];
    [super viewDidUnload];
}

// ScrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1) {
        int offset = (int)scrollView.contentOffset.x;
        int page = (int)(offset/320) + 1;
        if(offset%320 > 160) {
            page++;
        }
        int countPage = (int)(scrollView.contentSize.width/320);
        [self setAdPage:page countPage:countPage];
    }
}

// 展示广告图
- (void)showAdList
{
    int countAdList = [self.adList count];
    if (countAdList > 0) {
        for(UIView* subView in [self.adScrollView subviews])
        {
            [subView removeFromSuperview];
        }
        self.adScrollView.contentSize = CGSizeMake(countAdList * 320, 129);
        for (AdModel *o in self.adList) {
            UIButton *adImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(320 * (o.adid - 1), 0, 320, 129)];
            [adImageBtn setTag:o.adid];
            [adImageBtn setBackgroundImage:[UIImage imageNamed:@"ad_default"] forState:UIControlStateNormal];
            [adImageBtn addTarget:self action:@selector(adClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [YMGlobal loadImage:o.imageUrl andButton:adImageBtn andControlState:UIControlStateNormal];
            [self.adScrollView addSubview:adImageBtn];
        }
    }
}
// 展示推荐列表
- (void)showGoodsList
{
    int i = 1;
    int x = 0;
    int y = 0;
    for (GoodsModel *o in self.goodsList) {
        if (i <= 3) {
            x = (i - 1) * 105;
            y = 0;
        } else {
            x = (i - 4) * 105;
            y = 110;
        }
        UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(x, y, 100, 100)];
        
        UIButton *imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 80, 80)];
        [imageBtn setTag:i];
        [imageBtn setBackgroundImage:[UIImage imageNamed:@"goods_default"] forState:UIControlStateNormal];
        [imageBtn addTarget:self action:@selector(goodsClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [YMGlobal loadImage:o.imageUrl andButton:imageBtn andControlState:UIControlStateNormal];
        [tempView addSubview:imageBtn];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 100, 20)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setText:o.goodsName];
        [label setFont:[UIFont systemFontOfSize:12.0]];
        [tempView addSubview:label];
        
        [self.goodsListView addSubview:tempView];
        i++;
    }
}

// 搜索点击操作
- (void)searchClickAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"INeedToSearch" object:self];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}

// 二维码点击操作
- (void)tdbClickAction:(id)sender
{
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    
    [self presentModalViewController: reader
                            animated: YES];
}
// 解析二维码操作
- (void) imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    [reader dismissModalViewControllerAnimated: YES];
    NSString *url = symbol.data;
    NSString *regEx = @"wap-[0-9]+_1-index";
    NSRange r = [url rangeOfString:regEx options:NSRegularExpressionSearch];
    if (r.location != NSNotFound) {
        NSString *str = [[url substringWithRange:r] stringByReplacingOccurrencesOfString:@"wap-" withString:@""];
        str = [str stringByReplacingOccurrencesOfString:@"_1-index" withString:@""];
        // 这里还需要进行处理
        // 通过商品编码获取商品id，再加入到购物车里
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"商品的编码是:%@",str] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有对应的商品" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
    }
}

// 新品点击操作
- (void)newAdClickAction:(id)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    GoodsListViewController *goodsListViewController = [[GoodsListViewController alloc]init];
    goodsListViewController.requestDataType = @"newAdList";
    goodsListViewController.navigationItem.title = @"新品列表";
    [self.navigationController pushViewController:goodsListViewController animated:(YES)];
}

// 热销点击操作
- (void)hotAdClickAction:(id)sender
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    GoodsListViewController *goodsListViewController = [[GoodsListViewController alloc]init];
    goodsListViewController.requestDataType = @"hotAdList";
    goodsListViewController.navigationItem.title = @"热销商品";
    [self.navigationController pushViewController:goodsListViewController animated:(YES)];
}

// 产品点击
- (void)goodsClickAction:(id)sender
{
    GoodsInfoViewController *goodsInfoView = [[GoodsInfoViewController alloc]init];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;	
    goodsInfoView.navigationItem.title = @"商品详情";
    goodsInfoView.goodsId = @"1";
    [self.navigationController pushViewController:goodsInfoView animated:YES];
}

// 广告点击操作
- (void)adClickAction:(id)sender
{
    UIButton *adImageBtn = (UIButton *)sender;
    for (AdModel *o in self.adList) {
        if (adImageBtn.tag == o.adid) {
            NSLog(@"goodsIds:%@", o.goodsIds);
            // 获取到goodsIds 接下来执行pushView到产品列表操作，待完成
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            GoodsListViewController *goodsListViewController = [[GoodsListViewController alloc]init];
            goodsListViewController.requestId = o.goodsIds;
            goodsListViewController.requestDataType = @"goodsIds";
            goodsListViewController.navigationItem.title = @"商品列表";
            [self.navigationController pushViewController:goodsListViewController animated:(YES)];
            break;
        }
    }
}

// 设置广告分页
- (void)setAdPage:(float)page countPage:(float)countPage
{
    [self.adPageProgressView setFrame:CGRectMake((page-1)/countPage*320.0, 0, 1/countPage*320.0, 6)];
}

// 初始化操作
-(NSMutableArray *)adList
{
    if (adList == nil) {
        adList = [[NSMutableArray alloc]init];
    }
    return adList;
}
-(NSMutableArray *)goodsList
{
    if (goodsList == nil) {
        goodsList = [[NSMutableArray alloc]init];
    }
    return goodsList;
}
-(UIView *)adPageProgressView
{
    if (adPageProgressView == nil) {
        adPageProgressView = [[UIView alloc]initWithFrame:CGRectMake(320, 0, 320, 6)];
        [adPageProgressView setBackgroundColor:[UIColor colorWithRed:239/255.0 green:120/255.0 blue:0 alpha:1.0]];
    }
    return adPageProgressView;
}
@end
