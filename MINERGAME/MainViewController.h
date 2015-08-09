//
//  MainViewController.h
//  MINERGAME
//
//  Created by koudai miwa on 2015/08/07.
//  Copyright (c) 2015年 MINAMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UIScrollViewDelegate>{
    dispatch_queue_t mainQueue; 
    UIScrollView *scrollView;
    UIImageView *contentsView[168];
}
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIButton *btn_Setting;
- (IBAction)touch_btnSetting:(id)sender;


@end
