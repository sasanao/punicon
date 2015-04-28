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
    
    // タイマーの生成例
    NSTimer *tm = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                                   target:self
                                                 selector:@selector(move)
                                                 userInfo:nil
                                                  repeats:YES
                   ];
    [tm fire];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)puniconViewDidChangeValue:(UIPuniconView *)puniconView
{
    NSLog(@"xValue=%f, yValue=%f", _puniconView.xValue, _puniconView.yValue);
}

- (void)move
{
    CGPoint nowPoint = _player.frame.origin;
    _player.frame = CGRectMake(nowPoint.x + _puniconView.xValue, nowPoint.y + _puniconView.yValue, 64, 64);
}

@end
