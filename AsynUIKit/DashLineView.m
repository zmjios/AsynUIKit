//
//  DashLineView.m
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/30.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "DashLineView.h"
#import "DrawLine.h"

@interface DashLineView ()

@property (nonatomic, assign) CGPoint touchPonit;


@property (nonatomic, assign) CGPoint xBeginPonit;
@property (nonatomic, assign) CGPoint xEndPonit;
@property (nonatomic, assign) CGPoint yBeginPonit;
@property (nonatomic, assign) CGPoint yEndPonit;

@end

@implementation DashLineView




+ (Class)layerClass
{
    return [CALayer class];
}



- (id)init
{
    if (self = [super init]) {
        
        
    }
    
    return self;
}



- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    
    [super drawLayer:layer inContext:ctx];
    
    /*
    For layer-backed views with custom content, you should continue to override the view’s methods to do your drawing. A layer-backed view automatically makes itself the delegate of its layer and implements the needed delegate methods, and you should not change that configuration. Instead, you should implement your view’s drawRect: method to draw your content.*/
    
    
    if ( [[NSThread currentThread] isMainThread])
    {
        NSLog(@"==========draw in mainThread ============");
    }else
    {
        NSLog(@"==========drwa in background ==============");
    }
    
    
    CGFloat lenghts[2];
    lenghts[0] = 1.0;
    lenghts[1] = 1.0;
    
    CGContextRef context = ctx;
    
    int count = 11;
    CGFloat divideDiatance = self.bounds.size.width/count;
    
    CGPoint beginPoint = self.bounds.origin;
    
    for (int i = 0; i < count; i ++)
    {
        CGPoint startPonit = CGPointMake(beginPoint.x + i*divideDiatance, beginPoint.y);
        CGPoint endPoint = CGPointMake(beginPoint.x + i*divideDiatance, beginPoint.y+self.bounds.size.height);
        [DrawLine drawDashLine:context start:startPonit End:endPoint Color:[UIColor blackColor] Width:0.5 Length:lenghts];
        
        CGPoint vStartPonit = CGPointMake(beginPoint.x, beginPoint.y + i * divideDiatance);
        CGPoint vEndPonit = CGPointMake(self.bounds.size.width, beginPoint.y + i *divideDiatance);
        [DrawLine drawDashLine:context start:vStartPonit End:vEndPonit Color:[UIColor blackColor] Width:0.5 Length:lenghts];
    }
    
    
    if (!CGPointEqualToPoint(_xBeginPonit, CGPointZero)) {
        [DrawLine drawLine:context start:_xBeginPonit End:_xEndPonit Color:[UIColor redColor] Width:1];
    }
    
    if (!CGPointEqualToPoint(_yBeginPonit, CGPointZero)) {
        [DrawLine drawLine:context start:_yBeginPonit End:_yEndPonit Color:[UIColor redColor] Width:1];
    }

}



 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
     
     
     

     

//     CGFloat lenghts[2];
//     lenghts[0] = 1.0;
//     lenghts[1] = 1.0;
//     
//     CGContextRef context = UIGraphicsGetCurrentContext();
//     
//     int count = 11;
//     CGFloat divideDiatance = rect.size.width/count;
//     
//     CGPoint beginPoint = rect.origin;
//     
//     for (int i = 0; i < count; i ++)
//     {
//         CGPoint startPonit = CGPointMake(beginPoint.x + i*divideDiatance, beginPoint.y);
//         CGPoint endPoint = CGPointMake(beginPoint.x + i*divideDiatance, beginPoint.y+rect.size.height);
//         [DrawLine drawDashLine:context start:startPonit End:endPoint Color:[UIColor blackColor] Width:0.5 Length:lenghts];
//         
//         CGPoint vStartPonit = CGPointMake(beginPoint.x, beginPoint.y + i * divideDiatance);
//         CGPoint vEndPonit = CGPointMake(rect.size.width, beginPoint.y + i *divideDiatance);
//         [DrawLine drawDashLine:context start:vStartPonit End:vEndPonit Color:[UIColor blackColor] Width:0.5 Length:lenghts];
//     }
//     
//     
//     if (!CGPointEqualToPoint(_xBeginPonit, CGPointZero)) {
//         [DrawLine drawLine:context start:_xBeginPonit End:_xEndPonit Color:[UIColor redColor] Width:1];
//     }
//     
//     if (!CGPointEqualToPoint(_yBeginPonit, CGPointZero)) {
//         [DrawLine drawLine:context start:_yBeginPonit End:_yEndPonit Color:[UIColor redColor] Width:1];
//     }

     
     
    
 }




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint ponit = [[touches anyObject] locationInView:self];
    _touchPonit = ponit;
    
    
    _xBeginPonit = CGPointMake(0, _touchPonit.y);
    _xEndPonit = CGPointMake(self.bounds.size.width, _touchPonit.y);
    
    _yBeginPonit = CGPointMake(_touchPonit.x, 0);
    _yEndPonit = CGPointMake(_touchPonit.x, self.bounds.size.height);
    
    
    [self setNeedsDisplay];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint ponit = [[touches anyObject] locationInView:self];
    _touchPonit = ponit;
    
    
    _xBeginPonit = CGPointMake(0, _touchPonit.y);
    _xEndPonit = CGPointMake(self.bounds.size.width, _touchPonit.y);
    
    _yBeginPonit = CGPointMake(_touchPonit.x, 0);
    _yEndPonit = CGPointMake(_touchPonit.x, self.bounds.size.height);
    
    
    [self setNeedsDisplay];
}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    _xBeginPonit = CGPointZero;
    _yBeginPonit = CGPointZero;
    _xEndPonit = CGPointZero;
    _yEndPonit = CGPointZero;
    
    
    [self setNeedsDisplay];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    _xBeginPonit = CGPointZero;
    _yBeginPonit = CGPointZero;
    _xEndPonit = CGPointZero;
    _yEndPonit = CGPointZero;
    
    
    [self setNeedsDisplay];
}







@end
