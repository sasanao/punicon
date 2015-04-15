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
}

@end
