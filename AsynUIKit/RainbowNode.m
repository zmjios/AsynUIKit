//
//  RainbowNode.m
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/29.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "RainbowNode.h"
#import <AsyncDisplayKit/ASDisplayNode+Subclasses.h>

@interface RainbowNode ()<_ASDisplayLayerDelegate>

@end


@implementation RainbowNode


// Called on the display queue and/or main queue (MUST BE THREAD SAFE)

/**
 @summary Delegate method to draw layer contents into a CGBitmapContext. The current UIGraphics context will be set to an appropriate context.
 @param parameters An object describing all of the properties you need to draw. Return this from -drawParametersForAsyncLayer:
 @param isCancelled Execute this block to check whether the current drawing operation has been cancelled to avoid unnecessary work. A return value of YES means cancel drawing and return.
 @param isRasterizing YES if the layer is being rasterized into another layer, in which case drawRect: probably wants to avoid doing things like filling its bounds with a zero-alpha color to clear the backing store.
 */
+ (void)drawRect:(CGRect)bounds
  withParameters:(id<NSObject>)parameters
     isCancelled:(asdisplaynode_iscancelled_block_t)isCancelledBlock
   isRasterizing:(BOOL)isRasterizing
{
    // clear the backing store, but only if we're not rasterising into another layer
    if (!isRasterizing) {
        [[UIColor whiteColor] set];
        UIRectFill(bounds);
    }
    
    // UIColor sadly lacks +indigoColor and +violetColor methods
    NSArray *colors = @[ [UIColor redColor],
                         [UIColor orangeColor],
                         [UIColor yellowColor],
                         [UIColor greenColor],
                         [UIColor blueColor],
                         [UIColor purpleColor] ];
    
    
    NSMutableDictionary *dic = (NSMutableDictionary *)parameters;
    BOOL isVeritcal = [[dic objectForKey:@"vertical"] boolValue];
    if (isVeritcal) {
        CGFloat stripeWidth = roundf(bounds.size.width / (float)colors.count);
        
        // draw the stripes
        for (UIColor *color in colors) {
            CGRect stripe = CGRectZero;
            CGRectDivide(bounds, &stripe, &bounds, stripeWidth, CGRectMinXEdge);
            [color set];
            UIRectFill(stripe);
        }
    }else
    {
        CGFloat stripeHeight = roundf(bounds.size.height / (float)colors.count);
        
        // draw the stripes
        for (UIColor *color in colors) {
            CGRect stripe = CGRectZero;
            CGRectDivide(bounds, &stripe, &bounds, stripeHeight, CGRectMinYEdge);
            [color set];
            UIRectFill(stripe);
        }
    }
}



/**
 @summary Delegate override to provide new layer contents as a UIImage.
 @param parameters An object describing all of the properties you need to draw. Return this from -drawParametersForAsyncLayer:
 @param isCancelled Execute this block to check whether the current drawing operation has been cancelled to avoid unnecessary work. A return value of YES means cancel drawing and return.
 @return A UIImage with contents that are ready to display on the main thread. Make sure that the image is already decoded before returning it here.
 */
//+ (UIImage *)displayWithParameters:(id<NSObject>)parameters isCancelled:(asdisplaynode_iscancelled_block_t)isCancelledBlock
//{
//    return nil;
//}

// Called on the main thread only

/**
 @summary Delegate override for drawParameters
 */
- (NSObject *)drawParametersForAsyncLayer:(_ASDisplayLayer *)layer
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObject:[NSNumber numberWithBool:self.vertical] forKey:@"vertical"];
    
    return dic;
}

/**
 @summary Delegate override for willDisplay
 */
- (void)willDisplayAsyncLayer:(_ASDisplayLayer *)layer
{
    NSLog(@"---------willDisplay----------");
}

/**
 @summary Delegate override for didDisplay
 */
- (void)didDisplayAsyncLayer:(_ASDisplayLayer *)layer
{
    NSLog(@"----------didDisplayer------------");
}












@end
