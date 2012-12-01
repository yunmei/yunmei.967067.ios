//
//  GoodsListViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-11-8.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "GoodsListViewController.h"
#import "GoodsCell.h"

@interface GoodsListViewController ()

@end

@implementation GoodsListViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"goodsCell";
    GoodsCell *cell = (GoodsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell==nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"GoodsCell" owner:self options:nil];
        NSLog(@"nibs count:%i", [nibs count]);
        for(id o in nibs) {
            if([o isKindOfClass:[GoodsCell class]]) {
                cell = (GoodsCell *)o;
            }
        }
    }
    
    cell.goodsNameLabel.text = [NSString stringWithFormat:@"这里是产品名称 %i", indexPath.row];
    [cell.goodsImageView setImage:[UIImage imageNamed:@"goods_default"]];  
    cell.goodsPriceLabel.text = @"￥98.00";
    
    return cell;
}
@end
