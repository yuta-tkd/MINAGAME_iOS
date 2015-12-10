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
#import <QuartzCore/QuartzCore.h>
#import "CustomButton.h"

@interface MainViewController : UIViewController<UIScrollViewDelegate,AVAudioPlayerDelegate,UIWebViewDelegate>{
    dispatch_queue_t mainQueue; 
    UIScrollView *scrollView;
    UIImageView *contentsView[168];
    CGMutablePathRef curvedPath1;
    CGMutablePathRef curvedPath;
    
    UIImage *kame_Image;
    UIImageView *kame_ImgView;
    UIView *kame_View;
    NSDictionary *jsonArray;
    CustomButton *customButton;
    NSString* dbTime_String;
    int changeCount;
    int not_One;
    CAKeyframeAnimation *animation;

    UIImage *kame_Image1;
    UIImageView *kame_ImgView1;
    UIView *kame_View1;
    UILabel *temprature_Label[144];
    UILabel *time_Label[144];
    NSTimer *animeTimer;
    NSMutableArray *imageList;
    NSMutableArray *imageList1;
    NSMutableArray *imageList_Umi;
    CAKeyframeAnimation *animation1;

}
@property (weak, nonatomic) IBOutlet UIImageView *umi_View;
@property (weak, nonatomic) IBOutlet UIButton *btn_Setting;
- (IBAction)touch_btnSetting:(id)sender;

@property(nonatomic) AVAudioPlayer *audioPlayer;
@property (nonatomic,strong) AVPlayer *audioStremarPlayer;
@property (nonatomic, retain) CustomButton *customButton;


@end



