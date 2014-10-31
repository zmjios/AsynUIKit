//
//  AsynCellNode.m
//  AsynUIKit
//
//  Created by 曾明剑 on 14/10/26.
//  Copyright (c) 2014年 zmj. All rights reserved.
//

#import "AsynCellNode.h"
#import <AsyncDisplayKit/ASTextNode.h>

@interface AsynCellNode ()<ASTextNodeDelegate>
{
    ASTextNode *_textNode;
}



@property (nonatomic, assign) CGFloat myHeight;



@end

@implementation AsynCellNode


- (instancetype)init
{
    if (!(self = [super init]))
        return nil;
    
    // create a text node
    _textNode = [[ASTextNode alloc] init];
    
    // configure the node to support tappable links
    _textNode.delegate = self;
    _textNode.userInteractionEnabled = YES;
    _textNode.linkAttributeNames = @[ NSLinkAttributeName ];
    
    // add it as a subnode, and we're done
    [self addSubnode:_textNode];
    
    return self;
}


- (id)initWithHeight:(CGFloat)height
{
    if (self = [super init])
    {
    // create a text node
    _textNode = [[ASTextNode alloc] init];
    
    // configure the node to support tappable links
    _textNode.delegate = self;
    _textNode.userInteractionEnabled = YES;
    _textNode.linkAttributeNames = @[ NSLinkAttributeName ];
    
    // add it as a subnode, and we're done
    [self addSubnode:_textNode];
    }
    
    return self;
}


- (void)setText:(NSAttributedString *)text
{
    _textNode.attributedString = text;
    
}





- (CGSize)calculateSizeThatFits:(CGSize)constrainedSize
{
    // called on a background thread.  custom nodes must call -measure: on their subnodes in -calculateSizeThatFits:
    CGSize measuredSize = [_textNode measure:CGSizeMake(constrainedSize.width - 2 * 10,
                                                        constrainedSize.height - 2 * 10)];
    return CGSizeMake(constrainedSize.width, measuredSize.height + 2 * 10);
}

- (void)layout
{
    // called on the main thread.  we'll use the stashed size from above, instead of blocking on text sizing
    CGSize textNodeSize = _textNode.calculatedSize;
    _textNode.frame = CGRectMake(roundf((self.calculatedSize.width - textNodeSize.width) / 2.0f),
                                 10,
                                 textNodeSize.width,
                                 textNodeSize.height);
    
}



- (BOOL)textNode:(ASTextNode *)richTextNode shouldHighlightLinkAttribute:(NSString *)attribute value:(id)value
{
    // opt into link highlighting -- tap and hold the link to try it!  must enable highlighting on a layer, see -didLoad
    return YES;
}

- (void)textNode:(ASTextNode *)richTextNode tappedLinkAttribute:(NSString *)attribute value:(NSURL *)URL atPoint:(CGPoint)point textRange:(NSRange)textRange
{
    // the node tapped a link, open it
    [[UIApplication sharedApplication] openURL:URL];
}

@end
