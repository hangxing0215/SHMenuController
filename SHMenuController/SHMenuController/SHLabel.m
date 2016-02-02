//
//  SHLabel.m
//  SHMenuController
//
//  Created by admin on 16/2/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SHLabel.h"

@implementation SHLabel


- (void)awakeFromNib
{
    [self setup];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    return self;
}
- (void)setup
{
    //1.可以交互
    self.userInteractionEnabled = YES;
    
    //3.添加点击手势
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelClick)]];
    
}
- (void)labelClick
{
    NSLog(@"%s",__func__);
    //1.成为第一响应者  关键还要能成为第一响应者  重写方法
    [self becomeFirstResponder];
    //2.弄一个UIMenuController
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    [menuController setTargetRect:self.frame inView:self.superview];
    [menuController setMenuVisible:YES animated:YES];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(cut:) || action == @selector(copy:) || action == @selector(paste:))
        return YES;
    return  NO;
}
- (void)cut:(id)sender
{
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = self.text;
    self.text = nil;
}
- (void)copy:(id)sender
{
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = self.text;
    
}
- (void)paste:(id)sender
{
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    self.text = board.string;
}

@end
