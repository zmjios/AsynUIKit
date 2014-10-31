//
//  ImageTextNode.m
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/27.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "ImageTextNode.h"

@implementation ImageTextNode



//- (id)initWithViewClass:(Class)viewClass
//{
//    if (self =  [super initWithViewClass:viewClass]) {
//        <#statements#>
//    }
//}


- (id)init
{
    if (self = [super init]) {
        
        _imageNode = [[ASImageNode alloc] init];
        _imageNode.image = [UIImage imageNamed:@"hello.jpg"];
        
        [self addSubnode:_imageNode];
        
        _textNode = [[ASTextNode alloc] init];
        _textNode.backgroundColor = [UIColor orangeColor];
        _textNode.attributedString = [[NSAttributedString alloc] initWithString:@"hello,this is a custom node,by imageNode and TextNode"];
        
        [self addSubnode:_textNode];
        
        
    }
    
    
    return self;
}


// perform expensive sizing operations on a background thread
- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
    // size the image
    CGSize imageSize = [_imageNode measure:constrainedSize];
    
    // size the text node
    CGSize maxTextSize = CGSizeMake(constrainedSize.width - imageSize.width,
                                    constrainedSize.height);
    CGSize textSize = [_textNode measure:maxTextSize];
    
    // make sure everything fits
    CGFloat minHeight = MAX(imageSize.height, textSize.height);
    return CGSizeMake(constrainedSize.width, minHeight);
}


// do as little work as possible in main-thread layout
- (void)layout
{
    // layout the image using its cached size
    CGSize imageSize = _imageNode.calculatedSize;
    _imageNode.frame = CGRectMake(self.bounds.size.width - imageSize.width, 0.0f,
                                  imageSize.width, imageSize.height);
    
 
    
    // layout the text view using its cached size
    CGSize textSize = _textNode.calculatedSize;
    _textNode.frame = (CGRect){ CGPointZero, textSize };
    
    NSLogRect(_textNode.frame);
}

@end
