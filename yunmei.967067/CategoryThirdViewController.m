//
//  CategoryThirdViewController.m
//  yunmei.967067
//
//  Created by ken on 12-12-20.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "CategoryThirdViewController.h"

@interface CategoryThirdViewController ()

@end

@implementation CategoryThirdViewController
@synthesize thirdSubCatArr = _thirdSubCatArr;
@synthesize thirdSubCatTableView;
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
    // Do any additional setup after loading the view from its nib.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.thirdSubCatArr count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellForThirdSubCat";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.text = [[self.thirdSubCatArr objectAtIndex:indexPath.row] objectForKey:@"catName"];
        cell.textLabel.font = [UIFont systemFontOfSize:18.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSUInteger row = [indexPath row];
    NSString *subCatId = [[self.thirdSubCatArr objectAtIndex:row] objectForKey:@"catId"];
    NSString *subCatName = [[self.thirdSubCatArr objectAtIndex:row] objectForKey:@"catName"];
    // pushView到GoodsListView
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    GoodsListViewController *goodsListViewController = [[GoodsListViewController alloc]init];
    goodsListViewController.requestId = subCatId;
    goodsListViewController.requestDataType = @"category";
    UILabel *itemTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 44)];
    itemTitle.textAlignment = UITextAlignmentCenter;
    itemTitle.text = [NSString stringWithFormat:@"\"%@\"下的产品列表", subCatName];
    itemTitle.font = [UIFont systemFontOfSize:14.0];
    itemTitle.backgroundColor = [UIColor clearColor];
    itemTitle.textColor = [UIColor whiteColor];
    goodsListViewController.navigationItem.titleView = itemTitle;
    [self.navigationController pushViewController:goodsListViewController animated:(YES)];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSArray *)thirdSubCatArr
{
    if(_thirdSubCatArr == nil)
    {
        _thirdSubCatArr = [[NSMutableArray alloc]init];
    }
    return _thirdSubCatArr;
}
- (void)viewDidUnload {
    [self setThirdSubCatTableView:nil];
    [super viewDidUnload];
}
@end
