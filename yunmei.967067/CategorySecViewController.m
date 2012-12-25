//
//  CategorySecViewController.m
//  yunmei.967067
//
//  Created by ken on 12-12-1.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "CategorySecViewController.h"
#import "GoodsListViewController.h"

@interface CategorySecViewController ()

@end

@implementation CategorySecViewController
@synthesize categorySectableView = categorySectableView;
@synthesize subCateList = _subCateList;

//初始化属性subCateList
- (NSMutableArray *)subCateList
{
    if(_subCateList == nil)
    {
        _subCateList = [[NSMutableArray alloc]init];
    }
    return _subCateList;
}

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
    [self.categorySectableView reloadData];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCategorySectableView:nil];
    [super viewDidUnload];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.subCateList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"subCatCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSInteger row = [indexPath row];
    cell.textLabel.text = [[self.subCateList objectAtIndex:row] objectForKey:@"catName"];
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    NSString *catId = [[self.subCateList objectAtIndex:indexPath.row]objectForKey:@"catId"];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"category_getSubList",@"act",catId,@"catId", nil];
    MKNetworkOperation *op = [YMGlobal getOperation:params];
      [op addCompletionHandler:^(MKNetworkOperation *completedOperation){
          SBJsonParser *parser = [[SBJsonParser alloc]init];
          NSMutableDictionary *objectForCat = [parser objectWithData:[completedOperation responseData]];
          if([[objectForCat objectForKey:@"errorMessage"]isEqualToString:@"success"])
          {
              CategoryThirdViewController *thirdCatView = [[CategoryThirdViewController alloc]init];
              for(id o in [objectForCat objectForKey:@"data"])
              {
                  [thirdCatView.thirdSubCatArr addObject:o];
              }
          UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:nil];
          self.navigationItem.backBarButtonItem = backItem;
          [self.navigationController pushViewController:thirdCatView animated:YES];
          }
       
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"%@",error);
    }];
    [hud hide:YES];
    [ApplicationDelegate.appEngine enqueueOperation:op];
    
}

@end
