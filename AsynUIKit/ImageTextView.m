//
//  ImageTextView.m
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/27.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "ImageTextView.h"


@interface ImageTextView ()




@end

@implementation ImageTextView



- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hello.jpg"]];
        [self addSubview:_imageView];
        
        _textView = [[UITextView alloc] init];
        _textView.text = @"hello,this is a custom view,by imageView and TextView";
        [self addSubview:_textView];
        
    }
    
    return self;
}



- (CGSize)sizeThatFits:(CGSize)size
{
    // size the image
    CGSize imageSize = [_imageView sizeThatFits:size];
    
    // size the text view
    CGSize maxTextSize = CGSizeMake(size.width - imageSize.width, size.height);
    CGSize textSize = [_textView sizeThatFits:maxTextSize];
    
    // make sure everything fits
    CGFloat minHeight = MAX(imageSize.height, textSize.height);
    return CGSizeMake(size.width, minHeight);
}



- (void)layoutSubviews
{
    CGSize size = self.bounds.size; // convenience
    
    // size and layout the image
    CGSize imageSize = [_imageView sizeThatFits:size];
    _imageView.frame = CGRectMake(size.width - imageSize.width, 0.0f,
                                  imageSize.width, imageSize.height);
    
    // size and layout the text view
    CGSize maxTextSize = CGSizeMake(size.width - imageSize.width, size.height);
    CGSize textSize = [_textView sizeThatFits:maxTextSize];
    _textView.frame = (CGRect){ CGPointZero, textSize };
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
