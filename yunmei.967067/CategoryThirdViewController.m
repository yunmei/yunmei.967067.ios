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
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifier = @"cellForThirdSubCat";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        UILabel *content = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 39)];
        content.font = [UIFont boldSystemFontOfSize:17.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [cell addSubview:content];
    }
//UILabel *content2 = [cell.subviews objectAtIndex:1];
//NSLog(@"%@",[[self.thirdSubCatArr objectAtIndex:indexPath.row] objectForKey:@"catName"]);
return cell;
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
