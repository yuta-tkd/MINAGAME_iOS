//
//  MainViewController.h
//  MINERGAME
//
//  Created by koudai miwa on 2015/08/07.
//  Copyright (c) 2015年 MINAMI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "CustomButton.h"

@interface MainViewController : UIViewController<UIScrollViewDelegate,AVAudioPlayerDelegate,UIWebViewDelegate>{
    dispatch_queue_t mainQueue; 
    UIScrollView *scrollView;
    UIImageView *contentsView[168];
    UIImageView *imageview;
    UIView *view;
    NSDictionary *jsonArray;
    CustomButton *customButton;
}
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UIImageView *umi_View;
@property (weak, nonatomic) IBOutlet UIButton *btn_Setting;
- (IBAction)touch_btnSetting:(id)sender;

@property(nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic,strong) AVPlayer *audioStremarPlayer;
@property (nonatomic, retain) CustomButton *customButton;

@end



