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
    CGMutablePathRef curvedPath1;
    CGMutablePathRef curvedPath;
    
    UIImage *image;
    UIImageView *imageview;
    UIView *view;
    NSDictionary *jsonArray;
    CustomButton *customButton;
    NSString* dbTime_String;
    int changeCount;
    int not_One;
    
    // CAKeyframeAnimationオブジェクトを生成
    CAKeyframeAnimation *animation;

    UIImage *image1;
    UIImageView *imageview1;
    UIView *view1;
    UILabel *temp_Label[144];
    
    // CAKeyframeAnimationオブジェクトを生成
    CAKeyframeAnimation *animation1;

    //UIImageView *imageview;
    //UIView *view;
}
@property (weak, nonatomic) IBOutlet UIImageView *umi_View;
@property (weak, nonatomic) IBOutlet UIButton *btn_Setting;
- (IBAction)touch_btnSetting:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *umiView;
@property(nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic,strong) AVPlayer *audioStremarPlayer;
@property (nonatomic, retain) CustomButton *customButton;

@end



