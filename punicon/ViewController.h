//
//  ViewController.h
//  punicon
//
//  Created by dpcc on 2015/04/14.
//  Copyright (c) 2015年 kdl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPuniconView.h"

@interface ViewController : UIViewController<UIPuniconViewDelegate> {
    IBOutlet UIPuniconView* _puniconView;
    IBOutlet UIImageView* _player;
}


@end

