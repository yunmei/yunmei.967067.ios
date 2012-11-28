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

@synthesize tableView;
@synthesize catItemList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"商品分类", @"商品分类");
        self.tabBarItem.image = [UIImage imageNamed:@"tabbar_category"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.catItemList = [[NSMutableArray alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@"category_getList" forKey:@"act"];
    MKNetworkOperation * op = [YMGlobal getOperation:params];
    [op onCompletion:^(MKNetworkOperation *completedOperation) {
       // NSLog(@"%@",[op responseString]);
        
        
    } onError:^(NSError *error) {
        NSLog(@"Error:%@",error);
        NSLog(@"aa");
    }];
    [ApplicationDelegate.appEngine enqueueOperation: op];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}


@end
