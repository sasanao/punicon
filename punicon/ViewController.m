//
//  ViewController.m
//  punicon
//
//  Created by dpcc on 2015/04/14.
//  Copyright (c) 2015年 kdl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    
    NSArray* allTouches = [event.allTouches allObjects];
    UITouch *touch = [allTouches objectAtIndex:0];
    CGPoint pt = [touch locationInView:_puniconView];
    
    _puniconView.bNeetDraw = true;
    _puniconView.bFirstDraw = true;
    _puniconView.ptStartPoint = pt;
    _puniconView.ptEndPoint = pt;
    
    [_puniconView setNeedsDisplay];
    
//    /* 拡大・縮小 */
//    
//    // 拡大縮小を設定
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    
//    // アニメーションのオプションを設定
//    animation.duration = 2.5; // アニメーション速度
//    animation.repeatCount = 1; // 繰り返し回数
//    animation.autoreverses = YES; // アニメーション終了時に逆アニメーション
//    
//    // 拡大・縮小倍率を設定
//    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 開始時の倍率
//    animation.toValue = [NSNumber numberWithFloat:2.0]; // 終了時の倍率
//    
//    // アニメーションを追加
//    [_puniconView.layer addAnimation:animation forKey:@"scale-layer"];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
    
    NSArray* allTouches = [event.allTouches allObjects];
    UITouch *touch = [allTouches objectAtIndex:0];
    CGPoint pt = [touch locationInView:_puniconView];

    _puniconView.ptEndPoint = pt;
    
    [_puniconView setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
    _puniconView.bNeetDraw = false;
    [_puniconView setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
    _puniconView.bNeetDraw = false;
    [_puniconView setNeedsDisplay];
}

@end
