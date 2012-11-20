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

@interface IndexViewController ()

@end

@implementation IndexViewController

@synthesize adScrollView;
@synthesize adList;
@synthesize adPageView;
@synthesize adPageProgressView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"首页", @"首页");
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_index"];
        self.navigationItem.title = @"齐鲁直销商城";
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
    
    [self.view addSubview:self.adPageView];
    [self.adPageView addSubview:self.adPageProgressView];
    
    // 获取广告
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"ad_getAdList" forKey:@"act"];
    MKNetworkOperation* op = [YMGlobal getOperation:params];

    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        //NSLog(@"Data:%@", [op responseString]);
        NSMutableDictionary *object = [op responseJSON];
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
    } onError:^(NSError *error) {
        NSLog(@"Error:%@", error);
        [HUD hide:YES];
    }];
    
    [ApplicationDelegate.appEngine enqueueOperation: op];
    
    // Do any additional setup after loading the view from its nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)adClickAction:(id)sender
{
    UIButton *adImageBtn = (UIButton *)sender;
    for (AdModel *o in self.adList) {
        if (adImageBtn.tag == o.adid) {
            NSLog(@"goodsIds:%@", o.goodsIds);
            // 获取到goodsIds 接下来执行pushView到产品列表操作，待完成
            //UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
            //self.navigationItem.backBarButtonItem = backItem;
            //GoodsListViewController *goodsListViewController = [[GoodsListViewController alloc]init];
            //goodsListViewController.navigationItem.title = @"商品列表";
            //[self.navigationController pushViewController:goodsListViewController animated:(YES)];
            break;
        }
    }
}

- (void)setAdPage:(float)page countPage:(float)countPage
{
    [self.adPageProgressView setFrame:CGRectMake((page-1)/countPage*320.0, 0, 1/countPage*320.0, 6)];
}

- (void)viewDidUnload {
    [self setAdScrollView:nil];
    self.adPageView = nil;
    self.adList = nil;
    [super viewDidUnload];
}

// 初始化操作
-(NSMutableArray *)adList
{
    if (adList == nil) {
        adList = [[NSMutableArray alloc]init];
    }
    return adList;
}
-(UIView *)adPageView
{
    if (adPageView == nil) {
        adPageView = [[UIView alloc]initWithFrame:CGRectMake(0, 129, 320, 6)];
        [adPageView setBackgroundColor:[UIColor colorWithRed:122/255.0 green:122/255.0 blue:122/255.0 alpha:1.0]];
    }
    return adPageView;
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
