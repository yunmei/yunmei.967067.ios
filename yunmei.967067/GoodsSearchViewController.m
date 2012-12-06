//
//  GoodsSearchViewController.m
//  yunmei.967067
//
//  Created by bevin chen on 12-12-5.
//  Copyright (c) 2012年 bevin chen. All rights reserved.
//

#import "GoodsSearchViewController.h"

@interface GoodsSearchViewController ()

@end

@implementation GoodsSearchViewController
@synthesize goodsSearchBar;

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
    self.goodsSearchBar.tintColor = [UIColor colorWithRed:237/255.0f green:144/255.0f blue:6/255.0f alpha:1];
    [self.goodsSearchBar setBackgroundImage:[UIImage imageNamed:@"navigation_bar_bg"]];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self dismissModalViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToSearch" object:self userInfo:[NSDictionary dictionaryWithObject:searchBar.text forKey:@"keywords"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setGoodsSearchBar:nil];
    [super viewDidUnload];
}
@end
