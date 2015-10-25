//
//  ViewController.m
//  JYMusicBar
//
//  Created by joyann on 15/10/25.
//  Copyright © 2015年 Joyann. All rights reserved.
//

#import "ViewController.h"

/*
 在contentView中增加一个repLayer来复制bars，并设置instanceTransform以完成复制出的layer的平移，注意设置instanceDelay可以让复制出的layer相对于上一个layer延迟播放动画的效果
 */

@interface ViewController ()
@property (nonatomic, weak) UIView *contentView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addContentView];
    [self addBars];
}

#pragma mark - Add Content View

- (void)addContentView
{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    contentView.center = self.view.center;
    contentView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:contentView];
    self.contentView = contentView;
}

#pragma mark - Add Bars

- (void)addBars
{
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];
    repLayer.frame = self.contentView.bounds;
    repLayer.instanceCount = 5;
    repLayer.instanceTransform = CATransform3DMakeTranslation(60, 0, 0);
    repLayer.instanceDelay = 0.5;
    [self.contentView.layer addSublayer:repLayer];
    
    // 添加长方形
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 30, 100);
    layer.anchorPoint = CGPointMake(0, 1);
    layer.position = CGPointMake(0, repLayer.bounds.size.height);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [repLayer addSublayer:layer];
    
    // 添加缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale.y";
    scaleAnimation.toValue = @0;
    scaleAnimation.duration = 0.5;
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.autoreverses = YES;
    [layer addAnimation:scaleAnimation forKey:nil];
}


@end
