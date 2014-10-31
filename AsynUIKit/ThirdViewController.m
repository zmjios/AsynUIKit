//
//  ThirdViewController.m
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/27.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "ThirdViewController.h"
#import "RainbowNode.h"
#import "DashLineNode.h"

#import "DashLineView.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout  =UIRectEdgeNone;
    
    
    RainbowNode *rainBowNode = [[RainbowNode alloc] init];
    rainBowNode.vertical = YES;
    rainBowNode.frame  = CGRectMake(10, 10, self.view.bounds.size.width-20, 240);
    
    [self.view addSubview:rainBowNode.view];
    
    
    DashLineNode  *lineNode = [[DashLineNode alloc] init];
    lineNode.displaysAsynchronously = NO;
    lineNode.frame = CGRectMake(10, 260, self.view.bounds.size.width-20, self.view.bounds.size.width-20);
    [self.view addSubview:lineNode.view];
    
    
//    DashLineView *lineView = [[DashLineView alloc] initWithFrame:CGRectMake(10, 260, self.view.bounds.size.width-20, self.view.bounds.size.width-20)];
//    lineView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:lineView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
