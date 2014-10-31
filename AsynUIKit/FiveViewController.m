//
//  FiveViewController.m
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/30.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "FiveViewController.h"
#import "AnimationNode.h"
#import <ASDisplayNode.h>


@interface FiveViewController ()


@property (nonatomic, strong) ASDisplayNode *node1;

@end

@implementation FiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    

    _node1 = [[ASDisplayNode alloc] init];
    _node1.frame = CGRectMake(20, 20, 80, 80);
    _node1.backgroundColor = [UIColor redColor];
    [self.view addSubview:_node1.view];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    
    //[self cornerAnimation];
    
    
    [self moveAnimation];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cornerAnimation
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.fromValue=[NSNumber numberWithFloat:0.0f];
    animation.toValue=[NSNumber numberWithFloat:40.0f];
    //执行时间
    animation.duration = 5.0;
    //执行次数
    animation.repeatCount=2;
    [_node1.layer addAnimation:animation forKey:@"change"];
}



- (void)moveAnimation
{
    CGPoint fromPonit = _node1.view.center;
    
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPonit];
    
    CGPoint toPoint = CGPointMake(260, 400);
    [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x, fromPonit.y)];
    
    CAKeyframeAnimation *moveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnimation.path = movePath.CGPath;
    moveAnimation.removedOnCompletion = YES;
    
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation.fromValue=[NSNumber numberWithFloat:0.0f];
    animation.toValue=[NSNumber numberWithFloat:40.0f];
    animation.removedOnCompletion = YES;
   
    CABasicAnimation *opcaityAniamtion = [CABasicAnimation animationWithKeyPath:@"alhpa"];
    opcaityAniamtion.fromValue = [NSNumber numberWithFloat:1.0];
    opcaityAniamtion.toValue = [NSNumber numberWithFloat:0.1];
    opcaityAniamtion.removedOnCompletion = YES;
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[moveAnimation,animation,opcaityAniamtion];
    animationGroup.duration = 5.0;
    animationGroup.delegate = self;
    //animationGroup.autoreverses = YES;
    [_node1.layer addAnimation:animationGroup forKey:@"group"];
    
    
   
}


- (void)moveReturn
{
    CGPoint fromPonit = _node1.view.center;
    CGPoint toPoint = CGPointMake(260, 400);
    
    CGMutablePathRef returnPath = CGPathCreateMutable();
    CGPathMoveToPoint(returnPath, NULL, toPoint.x, toPoint.y);
    CGPathAddQuadCurveToPoint(returnPath, NULL, toPoint.x, fromPonit.y, fromPonit.x, fromPonit.y);
    
    CAKeyframeAnimation *returnMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    returnMoveAnimation.path = returnPath;
    
    CGPathRelease(returnPath);
    
    
    CABasicAnimation *animation2=[CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animation2.fromValue=[NSNumber numberWithFloat:40.0f];
    animation2.toValue=[NSNumber numberWithFloat:0.0f];
    
    
    CABasicAnimation *opcaityAniamtion2 = [CABasicAnimation animationWithKeyPath:@"alhpa"];
    opcaityAniamtion2.fromValue = [NSNumber numberWithFloat:.1];
    opcaityAniamtion2.toValue = [NSNumber numberWithFloat:1.0];
    
    CAAnimationGroup *animationGroup2 = [CAAnimationGroup animation];
    animationGroup2.animations = @[returnMoveAnimation,animation2,opcaityAniamtion2];
    animationGroup2.duration = 5.0;
    [_node1.layer addAnimation:animationGroup2 forKey:@"group2"];

}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isKindOfClass:[CAAnimationGroup class]] && flag) {
        [self moveReturn];
    }
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
