//
//  DashLineNode.m
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/29.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "DashLineNode.h"
#import <ASDisplayNode+Subclasses.h>
#import "DrawLine.h"


@interface DashLineNode ()


@property (nonatomic, strong) UITapGestureRecognizer *gestureRecogniser;


@property (nonatomic, assign) CGPoint touchPonit;


@property (nonatomic, assign) CGPoint xBeginPonit;
@property (nonatomic, assign) CGPoint xEndPonit;
@property (nonatomic, assign) CGPoint yBeginPonit;
@property (nonatomic, assign) CGPoint yEndPonit;


@end

@implementation DashLineNode



- (void)didLoad
{
    [super didLoad];
    
    // add a gesture recogniser, if we have a view to add it to
//    if (!self.layerBacked) {
//        _gestureRecogniser = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                     action:@selector(tap:)];
//        [self.view addGestureRecognizer:_gestureRecogniser];
//    }
    
    _xBeginPonit = CGPointZero;
    _yBeginPonit = CGPointZero;
    _xEndPonit = CGPointZero;
    _yEndPonit = CGPointZero;
}


- (void)tap:(UITapGestureRecognizer *)gesture
{
    NSLog(@"=============tap===============");
}

/*
 *When Core Animation asks an _ASDisplayLayer to draw itself, the request is forwarded to its node. Unless asynchronous display has been disabled, the actual draw call won't happen immediately or on the main thread. Instead, a display block will be added to a background queue. These blocks are executed in parallel, but you can enable ASDISPLAYNODE_DELAY_DISPLAY in ASDisplayNode(AsyncDisplay) to serialise the render system for debugging
 *
 *
 */


+ (void)drawRect:(CGRect)bounds
  withParameters:(id<NSObject>)parameters
     isCancelled:(asdisplaynode_iscancelled_block_t)isCancelledBlock
   isRasterizing:(BOOL)isRasterizing
{
    
    if ( [[NSThread currentThread] isMainThread]) {
        NSLog(@"==============draw in mainThread ==============");
    }else
    {
        NSLog(@"==============draw in background ==============");
    }

    
    // clear the backing store, but only if we're not rasterising into another layer
    if (!isRasterizing) {
        [[UIColor whiteColor] set];
        UIRectFill(bounds);
    }
    
    CGFloat lenghts[2];
    lenghts[0] = 1.0;
    lenghts[1] = 1.0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    int count = 11;
    CGFloat divideDiatance = bounds.size.width/count;
    
    CGPoint beginPoint = bounds.origin;
    
    for (int i = 0; i < count; i ++) {
        CGPoint startPonit = CGPointMake(beginPoint.x + i*divideDiatance, beginPoint.y);
        CGPoint endPoint = CGPointMake(beginPoint.x + i*divideDiatance, beginPoint.y+bounds.size.height);
        [DrawLine drawDashLine:context start:startPonit End:endPoint Color:[UIColor blackColor] Width:0.5 Length:lenghts];
        
        CGPoint vStartPonit = CGPointMake(beginPoint.x, beginPoint.y + i * divideDiatance);
        CGPoint vEndPonit = CGPointMake(bounds.size.width, beginPoint.y + i *divideDiatance);
        [DrawLine drawDashLine:context start:vStartPonit End:vEndPonit Color:[UIColor blackColor] Width:0.5 Length:lenghts];
    }
    
    if (parameters && [parameters isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *dic = (NSDictionary *)parameters;
        
        
        NSString *xPonit = [dic objectForKey:@"x"];
        NSString *yPonit = [dic objectForKey:@"y"];
        
        NSRange xrange = [xPonit rangeOfString:@"_"];
        NSRange yrange = [yPonit rangeOfString:@"_"];
        
        CGPoint xbegin = CGPointFromString([xPonit substringToIndex:xrange.location]);
        CGPoint xEnd = CGPointFromString([xPonit substringFromIndex:xrange.location]);
        
        CGPoint ybegin = CGPointFromString([yPonit substringToIndex:yrange.location]);
        CGPoint yend = CGPointFromString([yPonit substringFromIndex:yrange.location]);
        
        if (!CGPointEqualToPoint(xbegin, CGPointZero)) {
             [DrawLine drawLine:context start:xbegin End:xEnd Color:[UIColor redColor] Width:1];
        }
       
        if (!CGPointEqualToPoint(ybegin, CGPointZero)) {
            [DrawLine drawLine:context start:ybegin End:yend Color:[UIColor redColor] Width:1];
        }
        
        
    }
   
}





// call on main thread
- (NSObject *)drawParametersForAsyncLayer:(_ASDisplayLayer *)layer
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    NSString *xPonit = [NSString stringWithFormat:@"%@_%@",NSStringFromCGPoint(_xBeginPonit),NSStringFromCGPoint(_xEndPonit)];
    NSString *yPonit = [NSString stringWithFormat:@"%@_%@",NSStringFromCGPoint(_yBeginPonit),NSStringFromCGPoint(_yEndPonit)];
    
    [dic setObject:xPonit forKey:@"x"];
    [dic setObject:yPonit forKey:@"y"];
    
    return dic;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    CGPoint ponit = [[touches anyObject] locationInView:self.view];
    _touchPonit = ponit;
    
    
    _xBeginPonit = CGPointMake(0, _touchPonit.y);
    _xEndPonit = CGPointMake(self.view.bounds.size.width, _touchPonit.y);
    
    _yBeginPonit = CGPointMake(_touchPonit.x, 0);
    _yEndPonit = CGPointMake(_touchPonit.x, self.view.bounds.size.height);

    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    
    CGPoint ponit = [[touches anyObject] locationInView:self.view];
    _touchPonit = ponit;
    
    _xBeginPonit = CGPointMake(0, _touchPonit.y);
    _xEndPonit = CGPointMake(self.view.bounds.size.width, _touchPonit.y);
    
    _yBeginPonit = CGPointMake(_touchPonit.x, 0);
    _yEndPonit = CGPointMake(_touchPonit.x, self.view.bounds.size.height);
    
    
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    
    _xBeginPonit = CGPointZero;
    _yBeginPonit = CGPointZero;
    _xEndPonit = CGPointZero;
    _yEndPonit = CGPointZero;
    
    
    [self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    
    _xBeginPonit = CGPointZero;
    _yBeginPonit = CGPointZero;
    _xEndPonit = CGPointZero;
    _yEndPonit = CGPointZero;
    
    
    [self setNeedsDisplay];
}







@end
