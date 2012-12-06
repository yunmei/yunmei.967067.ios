//
//  GoodsListViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-8.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "GoodsListViewController.h"
#import "GoodsCell.h"
#import "MBProgressHUD.h"
#import "YMGlobal.h"
#import "SBJson.h"
#import "GoodsModel.h"
#import "AppDelegate.h"

@interface GoodsListViewController ()

@end

@implementation GoodsListViewController
@synthesize refreshTableView;
@synthesize requestDataType;
@synthesize requestId;
@synthesize goodsList;
@synthesize currentPage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.refreshTableView];
    self.refreshTableView.delegate = self;
    self.refreshTableView.dataSource = self;
    self.currentPage = 1;
    // 开始加载数据
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if ([self.requestDataType isEqualToString:@"category"]) {
        [params setObject:@"goods_getListByCatId" forKey:@"act"];
        [params setObject:self.requestId forKey:@"catId"];
    } else if ([self.requestDataType isEqualToString:@"goodsIds"]) {
        [params setObject:@"goods_getListById" forKey:@"act"];
        [params setObject:self.requestId forKey:@"goodsId"];
    } else if ([self.requestDataType isEqualToString:@"hotAdList"]) {
        [params setObject:@"goods_getHotList" forKey:@"act"];
    } else if ([self.requestDataType isEqualToString:@"newAdList"]) {
        [params setObject:@"goods_getNewList" forKey:@"act"];
    } else if ([self.requestDataType isEqualToString:@"search"]) {
        [params setObject:@"goods_getListByKeywords" forKey:@"act"];
        [params setObject:self.requestId forKey:@"keywords"];
    }
    MKNetworkOperation* op = [YMGlobal getOperation:params];
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
        }
        if ([self.requestDataType isEqualToString:@"category"]) {
            [self.refreshTableView reloadData:YES];
        } else {
            [self.refreshTableView reloadData:NO];
        }
        [HUD hide:YES];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"Error:%@", error);
        [HUD hide:YES];
    }];
    [ApplicationDelegate.appEngine enqueueOperation: op];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.refreshTableView tableViewDidDragging];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    int state = [self.refreshTableView tableViewDidEndDragging];
    if (state == k_RETURN_LOADMORE) {
        self.currentPage++;
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
        [params setObject:@"goods_getListByCatId" forKey:@"act"];
        [params setObject:self.requestId forKey:@"catId"];
        [params setObject:[NSString stringWithFormat:@"%i", self.currentPage] forKey:@"page"];
        [params setObject:@"10" forKey:@"num"];
        MKNetworkOperation* op = [YMGlobal getOperation:params];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            //NSLog(@"goodsList:%@", [completedOperation responseString]);
            SBJsonParser *parser = [[SBJsonParser alloc]init];
            NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
            if ([[object objectForKey:@"errorMessage"] isEqualToString:@"success"]) {
                int i = 0;
                for (id o in [object objectForKey:@"data"]) {
                    GoodsModel *goodsModel = [[GoodsModel alloc]init];
                    goodsModel.goodsId = [o objectForKey:@"goodsId"];
                    goodsModel.goodsName = [o objectForKey:@"goodsName"];
                    goodsModel.goodsPrice = [o objectForKey:@"goodsPrice"];
                    goodsModel.imageUrl = [o objectForKey:@"imageUrl"];
                    [self.goodsList addObject:goodsModel];
                    i++;
                }
                if (i < 10) {
                    [self.refreshTableView reloadData:NO];
                } else {
                    [self.refreshTableView reloadData:YES];
                }
            } else {
                NSLog(@"goodsList:%@", [completedOperation responseString]);
                [self.refreshTableView reloadData:NO];
            }
            [HUD hide:YES];
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            NSLog(@"Error:%@", error);
            [HUD hide:YES];
        }];
        [ApplicationDelegate.appEngine enqueueOperation: op];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.goodsList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"goodsCell";
    GoodsCell *cell = (GoodsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"GoodsCell" owner:self options:nil];
        for(id o in nibs) {
            if([o isKindOfClass:[GoodsCell class]]) {
                cell = (GoodsCell *)o;
            }
        }
    }
    
    GoodsModel *goodsModel = [self.goodsList objectAtIndex:indexPath.row];
    cell.goodsNameLabel.text = goodsModel.goodsName;
    cell.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@", goodsModel.goodsPrice];
    [YMGlobal loadImage:goodsModel.imageUrl andImageView:cell.goodsImageView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (PullToRefreshTableView *)refreshTableView
{
    if (refreshTableView == nil) {
        refreshTableView = [[PullToRefreshTableView alloc]initWithFrame:CGRectMake(0, 0, 320, 406)];
        [refreshTableView setRowHeight:76.0];
    }
    return refreshTableView;
}
-(NSMutableArray *)goodsList
{
    if (goodsList == nil) {
        goodsList = [[NSMutableArray alloc]init];
    }
    return goodsList;
}
- (NSString *)requestDataType
{
    if (requestDataType == nil) {
        requestDataType = [[NSString alloc]init];
    }
    return requestDataType;
}
- (NSString *)requestId
{
    if (requestId == nil) {
        requestId = [[NSString alloc]init];
    }
    return requestId;
}
@end
