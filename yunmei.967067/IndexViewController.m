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
#import "AdModel.h"
#import "AppDelegate.h"
#import "SBJSON.h"
@interface IndexViewController ()

@end

@implementation IndexViewController

@synthesize adScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"首页", @"首页");
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_index"];
        self.navigationItem.title = @"齐鲁直销商城";
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStyleBordered target:self action:@selector(testFunction)];
        self.navigationItem.rightBarButtonItem = item;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Test MkNetworkKit and SBJson
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"ad_getAdList" forKey:@"act"];
    MKNetworkOperation* op = [YMGlobal getOperation:params];
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
        NSLog(@"Data:%@", [op responseString]);
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[op responseData]];
        NSLog(@"act:%@", object);
    } onError:^(NSError *error) {
        NSLog(@"Error:%@", error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation: op];
    
    // Test AdScrollView
    self.adScrollView.contentSize = CGSizeMake(960, 130);
    self.adScrollView.pagingEnabled = TRUE;
    NSLog(@"adScrollView width:%f", self.adScrollView.frame.size.width);
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 127)];
    [imageView setImage:[UIImage imageNamed:@"test_ad_1"]];
    [self.adScrollView addSubview:imageView];
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(320, 0, 320, 127)];
    [imageView2 setImage:[UIImage imageNamed:@"test_ad_2"]];
    [self.adScrollView addSubview:imageView2];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testFunction
{
//    UIButton *backButton = [YMUIButton navigationButton:@"搜索"];
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:nil
                                                                action:nil];
    
    self.navigationItem.backBarButtonItem = backItem;
    GoodsListViewController *goodsListViewController = [[GoodsListViewController alloc]init];
    goodsListViewController.navigationItem.title = @"商品列表";
    [self.navigationController pushViewController:goodsListViewController animated:(YES)];
        
}
- (void)viewDidUnload {
    [self setAdScrollView:nil];
    [super viewDidUnload];
}
@end
