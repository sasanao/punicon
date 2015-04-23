//
//  ViewController.h
//  animation_test
//
//  Created by dpcc on 2015/04/21.
//  Copyright (c) 2015年 kdl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    CAShapeLayer* sublayer1;
    CAShapeLayer* sublayer2;
    
    CAShapeLayer* sublayer3;
    
    IBOutlet UITextView* textView;
}

-(IBAction)start:(id)sender;

@end

