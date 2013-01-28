//
//  CategoryViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-2.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

@synthesize categoryTableView;
@synthesize catItemList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"商品分类", @"商品分类");
        self.navigationItem.title = @"商品分类";
        [self.tabBarItem setImage:[UIImage imageNamed:@"tabbar_category"]];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) {
            [self.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tabbar_category"] withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_category_unselected"]];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    self.catItemList = [[NSMutableArray alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"category_getList" forKey:@"act"];
    MKNetworkOperation * op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSLog(@"%@",[completedOperation responseString]);
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
        if([[object objectForKey:@"errorMessage"]isEqualToString:@"success"])
        {
            for(id i in [object objectForKey:@"data"])
            {
                CategoryModel *catModel =[[CategoryModel alloc]init];
                catModel.catId = [i objectForKey:@"catId"];
                catModel.catName = [i objectForKey:@"catName"];
                catModel.parentId = @"0";
                catModel.imageUrl = [i objectForKey:@"imageUrl"];
                catModel.catDesc = [i objectForKey:@"catDesc"];
                [self.catItemList addObject:catModel];
                [self.categoryTableView reloadData];
            }
        }
        [hud hide:YES];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [hud hide:YES];
        NSLog(@"Error:%@",error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation: op];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCategoryTableView:nil];
    [super viewDidUnload];
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    CategoryCell *cell = (CategoryCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CategoryCell" owner:self options:nil];
        for(id i in nibs)
        {
            if([i isKindOfClass:[CategoryCell class]])
            {
                cell = (CategoryCell *)i;
            }
        }
        
    }
   
    CategoryModel *cellItemCat = [self.catItemList objectAtIndex:indexPath.row];
    if(!(cellItemCat==nil))
    {
        cell.categoryName.font = [UIFont systemFontOfSize:20.0];
        cell.categoryName.text = cellItemCat.catName;
        cell.catDesc.text = cellItemCat.catDesc;
        cell.catDesc.textColor = [UIColor grayColor];
        cell.catDesc.font = [UIFont boldSystemFontOfSize:17.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [cell.catImageView setImage:[UIImage imageNamed:@"goods_default"]];
        [YMGlobal loadImage:[cellItemCat imageUrl] andImageView:[cell catImageView]];
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    CategoryModel *selectCate = [self.catItemList objectAtIndex:indexPath.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"category_getSubList", @"act",[selectCate catId],@"catId",nil];
    MKNetworkOperation *op = [YMGlobal getOperation:params];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        SBJsonParser *parser = [[SBJsonParser alloc]init];
        NSMutableDictionary *object = [parser objectWithData:[completedOperation responseData]];
        if([[object objectForKey:@"errorMessage"]isEqualToString:@"success"])
        {
            CategorySecViewController *subCateView = [[CategorySecViewController alloc]init];
            for(id i in [object objectForKey:@"data"])
            {
                [subCateView.subCateList addObject:i];
            }
            UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
            self.navigationItem.backBarButtonItem = backItem;
            [self.navigationController pushViewController:subCateView animated:YES];
        }
        [hud hide:YES];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [ApplicationDelegate.appEngine enqueueOperation: op];
    [hud hide:YES];
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section
{
    return  self.catItemList.count;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
