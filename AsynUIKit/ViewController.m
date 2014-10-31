//
//  ViewController.m
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/26.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "ViewController.h"
#import <AsyncDisplayKit/ASTextNode.h>
#import <AsyncDisplayKit/ASTableView.h>
#import "AsynCellNode.h"
#import "BlurbNode.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FiveViewController.h"

@interface ViewController ()<ASTableViewDataSource,ASTableViewDelegate>


@property (nonatomic, strong) ASTableView *tableView;



@property (nonatomic, strong) NSArray *categories;

@property (nonatomic, strong) NSArray *controllers;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"测试";
    
    
    _categories = @[@"Getting started",@"asynlayout",@"drawRect",@"asTabelView",@"animation"];
    _controllers = @[@"FirstViewController",@"SecondViewController",@"ThirdViewController",@"FourthViewController",@"FiveViewController"];
    
    
    _tableView = [[ASTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.asyncDataSource = self;
    _tableView.asyncDelegate = self;
    [self.view addSubview:_tableView];
    
    
    // attribute a string
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewWillLayoutSubviews
//{
//    _tableView.frame = self.view.bounds;
//}




#pragma mark -

- (ASCellNode *)tableView:(ASTableView *)tableView nodeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AsynCellNode *node = [[AsynCellNode alloc] init];
    
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:_categories[indexPath.row]];
    node.text = string;
    
    return node;

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _categories.count;
}

//- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    Class classType = NSClassFromString(_controllers[indexPath.row]);
    
    UIViewController *controller = [[classType alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}






@end
