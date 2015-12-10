//
//  MainViewController.m
//  MINERGAME
//
//  Created by koudai miwa on 2015/08/07.
//  Copyright (c) 2015年 MINAMI. All rights reserved.
//

#import "MainViewController.h"
#import "LoginViewController.h"

const float VIEW_SIZE_WIDTH = 90.7142857;
@interface MainViewController ()
@end

const float VIEW_WIDTH = 8700;

@implementation MainViewController
@synthesize customButton = _customButton;


- (void)viewDidLoad {
    [super viewDidLoad];
#pragma makrk ###アニメーション###
    changeCount = 0;
    not_One = 0;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];

    animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 7;
    animation.repeatCount = HUGE_VALF;
    animation.beginTime = CACurrentMediaTime() + 3;
    
    CGFloat jumpHeight = 130;
    CGFloat kStartPosx = -100;
    CGFloat kStartPosy = 350;
    CGFloat kEndPosx = 400;
    CGFloat kEndPosy = 350;

    curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, kStartPosx, kStartPosy);
    CGPathAddCurveToPoint(curvedPath, NULL,
                          kStartPosx + jumpHeight, kStartPosy - jumpHeight,
                          kStartPosx + jumpHeight, kStartPosy + jumpHeight,
                          kEndPosx, kEndPosy);
    animation.path = curvedPath;
    CGPathRelease(curvedPath);
    
    
    animation1 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation1.fillMode = kCAFillModeForwards;
    animation1.removedOnCompletion = NO;
    animation1.duration = 7;
    animation1.repeatCount = HUGE_VALF;
    animation1.beginTime = CACurrentMediaTime() + 11.5;
    
    CGFloat jumpHeight1 = 130;
    CGFloat kStartPosx1 = 400;
    CGFloat kStartPosy1 = 500;
    CGFloat kEndPosx1 = -100;
    CGFloat kEndPosy1 = 500;
    
    curvedPath1 = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath1, NULL, kStartPosx1, kStartPosy1);
    CGPathAddCurveToPoint(curvedPath1, NULL,
                          kStartPosx1 - jumpHeight1, kStartPosy1 - jumpHeight1,
                          kStartPosx1 - jumpHeight1, kStartPosy1 + jumpHeight1,
                          kEndPosx1, kEndPosy1);
    
    animation1.path = curvedPath1;
    
    CGPathRelease(curvedPath1);
    
    
    kame_Image = [UIImage imageNamed:@"minagame1_001.png"];
    kame_Image1 = [UIImage imageNamed:@"minagame2_001.png"];
    kame_ImgView = [[UIImageView alloc]initWithImage:kame_Image];
    kame_ImgView.frame = CGRectMake(0, 0, 100, 100);
    kame_ImgView1 = [[UIImageView alloc]initWithImage:kame_Image1];
    kame_ImgView1.frame = CGRectMake(0, 0, 160, 160);
    kame_View = [[UIView alloc] initWithFrame:CGRectMake(-500, -500, 100, 100)];
    kame_View1 = [[UIView alloc] initWithFrame:CGRectMake(-500, -500, 160, 160)];
    
    
    imageList = [NSMutableArray array];
    for (int i = 0; i <= 16; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"minagame1_%03d.png", i];
        UIImage *img = [UIImage imageNamed:imagePath];
        
        
        if (img != nil)
        {
            [imageList addObject:img];
        }
    }
    
    imageList1 = [NSMutableArray array];
    for (int i = 0; i <= 14; i++) {
        NSString *imagePath1 = [NSString stringWithFormat:@"minagame2_%03d.png", i];
        UIImage *img1 = [UIImage imageNamed:imagePath1];
        
        if (img1 != nil)
        {
            [imageList1 addObject:img1];
        }
    }
    
    imageList_Umi = [NSMutableArray array];
    for (int i = 0; i <= 57; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"wave_%03d.png", i];
        UIImage *img = [UIImage imageNamed:imagePath];
        
        if (img != nil)
        {
            [imageList_Umi addObject:img];
        }
    }
    self.umi_View.animationImages = imageList_Umi;
    self.umi_View.animationDuration = 10;
    self.umi_View.animationRepeatCount = 0;
    [self.umi_View startAnimating];
    
    
    kame_ImgView.animationImages = imageList;
    kame_ImgView.animationDuration = 2;
    kame_ImgView.animationRepeatCount = 0;
    [kame_View.layer addAnimation:animation forKey:nil];
    [kame_View addSubview:kame_ImgView];
    [self.view addSubview:kame_View];
    [kame_ImgView startAnimating];
    
    kame_ImgView1.animationImages = imageList1;
    kame_ImgView1.animationDuration = 2;
    kame_ImgView1.animationRepeatCount = 0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 10.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [kame_View.layer removeAllAnimations];
        [kame_View1.layer addAnimation:animation1 forKey:nil];
        [kame_View1 addSubview:kame_ImgView1];
        [self.view addSubview:kame_View1];
        [kame_ImgView1 startAnimating];
        animeTimer = [NSTimer scheduledTimerWithTimeInterval:7.0 target:self selector:@selector(animation22:) userInfo:nil repeats:YES];
    });
#pragma mark duration
    
    UIImage* b_setting_Img = [UIImage imageNamed:@"setting.png"];
    UIImage *a_setting_Img;
    CGFloat width = 44;
    CGFloat height = 44;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [b_setting_Img drawInRect:CGRectMake(0, 0, width, height)];
    a_setting_Img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.btn_Setting.layer.zPosition = 1;
    [self.btn_Setting setImage:a_setting_Img forState:UIControlStateNormal];
    
    scrollView = [[UIScrollView alloc]init];
    scrollView.layer.zPosition = 2;
    scrollView.delegate=self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces =NO;
    
    scrollView.userInteractionEnabled = YES;
    scrollView.decelerationRate = 5;
    scrollView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100);
    [scrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.view.frame.size.height-100)];
    [self.view addSubview:scrollView];
    scrollView.contentOffset = CGPointMake(8320,0);
    
    __block NSDate* START_TIME = [NSDate date];
    __block NSDate* change_Time = [NSDate date];
    START_TIME = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    change_Time = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSCalendar* cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unitFlags =  NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *dateComponents_Hour = [cal components:unitFlags fromDate:START_TIME];
    __block NSInteger START_HOUR = dateComponents_Hour.hour -9;
    __block NSInteger START_MINUTE = dateComponents_Hour.minute;
    
    if (START_HOUR < 0) {
        START_HOUR +=24;
    }
    
    NSURL *url;
    NSMutableURLRequest *request;
    
    
    for (int i = 144; i > 0; --i) {
        
        contentsView[i] = [[UIImageView alloc] init];
        contentsView[i].frame = CGRectMake(60*i, 100, 46.875, 300);
        contentsView[i].tag = i;
        contentsView[i].layer.zPosition = 1;
        contentsView[i].userInteractionEnabled = YES;
        [scrollView addSubview:contentsView[i]];
        
        
#pragma mark ###24時間更新###
        url = [NSURL URLWithString:@"http://ec2-52-69-253-248.ap-northeast-1.compute.amazonaws.com/api/allSensor"];
        request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
     
        
        NSString *body = [NSString stringWithFormat:@"edisonName=%@&startTime=%@&duration=%d",[ud valueForKey:@"U_ID"],dbTime_String,10];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        START_TIME = [START_TIME dateByAddingTimeInterval:-60*10];
        [formater setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        dbTime_String = [formater stringFromDate:START_TIME];
        
        
        dateComponents_Hour = [cal components:unitFlags fromDate:START_TIME];
        START_HOUR = dateComponents_Hour.hour -9;
        START_MINUTE = dateComponents_Hour.minute;
        
        if (START_HOUR < 0) {
            START_HOUR +=24;
        }
        
        if ((50 < START_MINUTE && 5<= START_MINUTE%10) || (START_MINUTE < 10 && START_MINUTE%10<= 4)) {
            time_Label[i] = [[UILabel alloc] init];
            temprature_Label[i] = [[UILabel alloc] init];
            NSString *timelabel_BackPath = @"circle.png";
            UIImage *time_Back = [UIImage imageNamed:timelabel_BackPath];
            UIImageView *time_Back_View = [[UIImageView alloc] initWithImage:time_Back];
            time_Back_View.layer.zPosition = 2;
            time_Back_View.frame = CGRectMake(-24, -44, 88, 88);
            
            time_Label[i].frame = CGRectMake(-12, -16, 75, 30);
            time_Label[i].layer.zPosition = 3;
            time_Label[i].textColor = [UIColor colorWithRed:190/255.0 green:217/255.0 blue:229/255.0 alpha:1];
            time_Label[i].textAlignment = NSTextAlignmentCenter;
            time_Label[i].font = [UIFont fontWithName:@"YuGo-Bold" size:25];
            time_Label[i].textAlignment = NSTextAlignmentLeft;
            if (50 < START_MINUTE && 5<= START_MINUTE%10) {
                if (START_HOUR <= 8) {
                    time_Label[i].text = [NSString stringWithFormat:@"0%ld:00", START_HOUR+1];
                }
                else{
                    time_Label[i].text = [NSString stringWithFormat:@"%ld:00", START_HOUR+1];
                }
            }
            else{
                if (START_HOUR <= 9) {
                    time_Label[i].text = [NSString stringWithFormat:@"0%ld:00", START_HOUR];
                }
                else{
                    time_Label[i].text = [NSString stringWithFormat:@"%ld:00", START_HOUR];
                }
            }
            NSLog(@"温度番号%d:",i);
            temprature_Label[i].frame = CGRectMake(-1.5, 4, 80, 30);
            temprature_Label[i].tag = i;
            temprature_Label[i].layer.zPosition = 3;
            temprature_Label[i].textColor = [UIColor colorWithRed:190/255.0 green:217/255.0 blue:229/255.0 alpha:1];
            temprature_Label[i].textAlignment = NSTextAlignmentCenter;
            temprature_Label[i].font = [UIFont fontWithName:@"YuGo-Bold" size:25];
            temprature_Label[i].textAlignment = NSTextAlignmentLeft;
            
            [contentsView[i] addSubview:time_Back_View];
            [contentsView[i] addSubview:time_Label[i]];
            
        }
      
#pragma mark 非同期
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSError* error=nil;
            jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSArray *jsonPhoto = [jsonArray valueForKeyPath:@"Photos"];
            NSArray *jsonSounds = [jsonArray valueForKeyPath:@"Sounds"];
            NSArray *jsonTouch = [jsonArray valueForKeyPath:@"Touches"];
            NSArray *jsonTemp = [jsonArray valueForKeyPath:@"Temperatures"];
            
            NSLog(@"タッチ:%@,",[jsonTouch valueForKeyPath:@"check"]);
            
            
            if ([[jsonPhoto valueForKeyPath:@"check"] boolValue] == YES) {
                CustomButton *btn_Photo = [CustomButton buttonWithType:UIButtonTypeCustom];
                [btn_Photo setImage:[UIImage imageNamed:@"photo.png"]  forState:UIControlStateNormal];
                [btn_Photo addTarget:self action:@selector(touch_btnPhoto:) forControlEvents:UIControlEventTouchUpInside];
                //btn_Photo.urlString = [file objectForKey:@"linkURL"] ;
                btn_Photo.urlString = [jsonPhoto valueForKeyPath:@"photo_path"];
                
                if (i%2==0) {
                    btn_Photo.frame = CGRectMake(-5, 210, 48, 48);
                }
                else{
                    btn_Photo.frame = CGRectMake(-5, 245, 48, 48);
                }
                
                [contentsView[i] addSubview:btn_Photo];
                
            }
            
            if ([[jsonSounds valueForKeyPath:@"check"] boolValue] == YES) {
                CustomButton *btn_Voice = [CustomButton buttonWithType:UIButtonTypeCustom];
                [btn_Voice setImage:[UIImage imageNamed:@"sound.png"]  forState:UIControlStateNormal];
                [btn_Voice addTarget:self action:@selector(touch_btnVoice:) forControlEvents:UIControlEventTouchUpInside];
                //btn_Photo.urlString = [file objectForKey:@"linkURL"] ;
                btn_Voice.urlString = [jsonSounds valueForKeyPath:@"sound_path"];
                
                
                if (i%2==0) {
                    btn_Voice.frame = CGRectMake(-5, 140, 48, 48);
                    
                }
                else{
                    btn_Voice.frame = CGRectMake(-5, 175, 48, 48);
                }
                [contentsView[i] addSubview:btn_Voice];
                
            }
            if ([[jsonPhoto valueForKeyPath:@"check"] boolValue] == YES || [[jsonSounds valueForKeyPath:@"check"] boolValue] == YES || [[jsonTouch valueForKeyPath:@"check"] boolValue] == YES) {
                CustomButton *btn_Touch = [CustomButton buttonWithType:UIButtonTypeCustom];
                btn_Touch.adjustsImageWhenHighlighted = NO;
                [btn_Touch setImage:[UIImage imageNamed:@"touch.png"]  forState:UIControlStateNormal];
                [btn_Touch addTarget:self action:@selector(touch_btnTouch:) forControlEvents:UIControlEventTouchUpInside];
                //btn_Photo.urlString = [file objectForKey:@"linkURL"] ;
                if (i%2==0) {
                    btn_Touch.frame = CGRectMake(-5, 70, 48, 48);
                }
                else{
                    btn_Touch.frame = CGRectMake(-5, 105, 48, 48);
                }
                [contentsView[i] addSubview:btn_Touch];
                contentsView[i].image = [UIImage imageNamed:@"sen.png"];
            }
            if ([[jsonTemp valueForKeyPath:@"check"] boolValue] == YES) {
                //                NSLog(@"番号:%d",i);
                //                NSLog(@"温度:%@",[jsonTemp valueForKey:@"temperature"]);
                temprature_Label[i].text = [NSString stringWithFormat:@"%d℃",[[jsonTemp valueForKey:@"temperature"] intValue]];
                [contentsView[i] addSubview:temprature_Label[i]];
                time_Label[i].frame = CGRectMake(-12, -29, 75, 30);
                
            }
        }];
        
    }
    
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(requestSenserDatas) userInfo:nil repeats:YES];
}

-(void)requestSenserDatas{
    [scrollView removeFromSuperview];
    for (int i = 144; i > 0; --i) {
        [contentsView[i] removeFromSuperview];
    }
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    scrollView = [[UIScrollView alloc]init];
    scrollView.layer.zPosition = 2;
    scrollView.delegate=self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces =NO;
    
    scrollView.userInteractionEnabled = YES;
    scrollView.decelerationRate = 5;
    scrollView.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100);
    [scrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.view.frame.size.height-100)];
    [self.view addSubview:scrollView];
    scrollView.contentOffset = CGPointMake(8320,0);
    
    __block NSDate* START_TIME = [NSDate date];
    __block NSDate* change_Time = [NSDate date];
    START_TIME = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    change_Time = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    NSCalendar* cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unitFlags =  NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *dateComponents_Hour = [cal components:unitFlags fromDate:START_TIME];
    __block NSInteger START_HOUR = dateComponents_Hour.hour -9;
    __block NSInteger START_MINUTE = dateComponents_Hour.minute;
    
    if (START_HOUR < 0) {
        START_HOUR +=24;
    }
    
    NSURL *url;
    NSMutableURLRequest *request;
    
    
    for (int i = 144; i > 0; --i) {
        
        contentsView[i] = [[UIImageView alloc] init];
        contentsView[i].frame = CGRectMake(60*i, 100, 46.875, 300);
        contentsView[i].tag = i;
        contentsView[i].layer.zPosition = 1;
        contentsView[i].userInteractionEnabled = YES;
        [scrollView addSubview:contentsView[i]];
        
        
#pragma mark ###24時間更新###
        url = [NSURL URLWithString:@"http://ec2-52-69-253-248.ap-northeast-1.compute.amazonaws.com/api/allSensor"];
        request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        
        
        NSString *body = [NSString stringWithFormat:@"edisonName=%@&startTime=%@&duration=%d",[ud valueForKey:@"U_ID"],dbTime_String,10];
        request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
        START_TIME = [START_TIME dateByAddingTimeInterval:-60*10];
        [formater setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        dbTime_String = [formater stringFromDate:START_TIME];
        
        
        dateComponents_Hour = [cal components:unitFlags fromDate:START_TIME];
        START_HOUR = dateComponents_Hour.hour -9;
        START_MINUTE = dateComponents_Hour.minute;
        
        if (START_HOUR < 0) {
            START_HOUR +=24;
        }
        
        if ((50 < START_MINUTE && 5<= START_MINUTE%10) || (START_MINUTE < 10 && START_MINUTE%10<= 4)) {
            time_Label[i] = [[UILabel alloc] init];
            temprature_Label[i] = [[UILabel alloc] init];
            NSString *timelabel_BackPath = @"circle.png";
            UIImage *time_Back = [UIImage imageNamed:timelabel_BackPath];
            UIImageView *time_Back_View = [[UIImageView alloc] initWithImage:time_Back];
            time_Back_View.layer.zPosition = 2;
            time_Back_View.frame = CGRectMake(-24, -44, 88, 88);
            
            time_Label[i].frame = CGRectMake(-12, -16, 75, 30);
            time_Label[i].layer.zPosition = 3;
            time_Label[i].textColor = [UIColor colorWithRed:190/255.0 green:217/255.0 blue:229/255.0 alpha:1];
            time_Label[i].textAlignment = NSTextAlignmentCenter;
            time_Label[i].font = [UIFont fontWithName:@"YuGo-Bold" size:25];
            time_Label[i].textAlignment = NSTextAlignmentLeft;
            if (50 < START_MINUTE && 5<= START_MINUTE%10) {
                if (START_HOUR <= 8) {
                    time_Label[i].text = [NSString stringWithFormat:@"0%ld:00", START_HOUR+1];
                }
                else{
                    time_Label[i].text = [NSString stringWithFormat:@"%ld:00", START_HOUR+1];
                }
            }
            else{
                if (START_HOUR <= 9) {
                    time_Label[i].text = [NSString stringWithFormat:@"0%ld:00", START_HOUR];
                }
                else{
                    time_Label[i].text = [NSString stringWithFormat:@"%ld:00", START_HOUR];
                }
            }
            NSLog(@"温度番号%d:",i);
            temprature_Label[i].frame = CGRectMake(-1.5, 4, 80, 30);
            temprature_Label[i].tag = i;
            temprature_Label[i].layer.zPosition = 3;
            temprature_Label[i].textColor = [UIColor colorWithRed:190/255.0 green:217/255.0 blue:229/255.0 alpha:1];
            temprature_Label[i].textAlignment = NSTextAlignmentCenter;
            temprature_Label[i].font = [UIFont fontWithName:@"YuGo-Bold" size:25];
            temprature_Label[i].textAlignment = NSTextAlignmentLeft;
            
            [contentsView[i] addSubview:time_Back_View];
            [contentsView[i] addSubview:time_Label[i]];
            
        }
        
#pragma mark 非同期
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            NSError* error=nil;
            jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSArray *jsonPhoto = [jsonArray valueForKeyPath:@"Photos"];
            NSArray *jsonSounds = [jsonArray valueForKeyPath:@"Sounds"];
            NSArray *jsonTouch = [jsonArray valueForKeyPath:@"Touches"];
            NSArray *jsonTemp = [jsonArray valueForKeyPath:@"Temperatures"];
            
            NSLog(@"タッチ:%@,",[jsonTouch valueForKeyPath:@"check"]);
            
            
            if ([[jsonPhoto valueForKeyPath:@"check"] boolValue] == YES) {
                CustomButton *btn_Photo = [CustomButton buttonWithType:UIButtonTypeCustom];
                [btn_Photo setImage:[UIImage imageNamed:@"photo.png"]  forState:UIControlStateNormal];
                [btn_Photo addTarget:self action:@selector(touch_btnPhoto:) forControlEvents:UIControlEventTouchUpInside];
                //btn_Photo.urlString = [file objectForKey:@"linkURL"] ;
                btn_Photo.urlString = [jsonPhoto valueForKeyPath:@"photo_path"];
                
                if (i%2==0) {
                    btn_Photo.frame = CGRectMake(-5, 210, 48, 48);
                }
                else{
                    btn_Photo.frame = CGRectMake(-5, 245, 48, 48);
                }
                
                [contentsView[i] addSubview:btn_Photo];
                
            }
            
            if ([[jsonSounds valueForKeyPath:@"check"] boolValue] == YES) {
                CustomButton *btn_Voice = [CustomButton buttonWithType:UIButtonTypeCustom];
                [btn_Voice setImage:[UIImage imageNamed:@"sound.png"]  forState:UIControlStateNormal];
                [btn_Voice addTarget:self action:@selector(touch_btnVoice:) forControlEvents:UIControlEventTouchUpInside];
                //btn_Photo.urlString = [file objectForKey:@"linkURL"] ;
                btn_Voice.urlString = [jsonSounds valueForKeyPath:@"sound_path"];
                
                
                if (i%2==0) {
                    btn_Voice.frame = CGRectMake(-5, 140, 48, 48);
                    
                }
                else{
                    btn_Voice.frame = CGRectMake(-5, 175, 48, 48);
                }
                [contentsView[i] addSubview:btn_Voice];
                
            }
            if ([[jsonPhoto valueForKeyPath:@"check"] boolValue] == YES || [[jsonSounds valueForKeyPath:@"check"] boolValue] == YES || [[jsonTouch valueForKeyPath:@"check"] boolValue] == YES) {
                CustomButton *btn_Touch = [CustomButton buttonWithType:UIButtonTypeCustom];
                btn_Touch.adjustsImageWhenHighlighted = NO;
                [btn_Touch setImage:[UIImage imageNamed:@"touch.png"]  forState:UIControlStateNormal];
                [btn_Touch addTarget:self action:@selector(touch_btnTouch:) forControlEvents:UIControlEventTouchUpInside];
                //btn_Photo.urlString = [file objectForKey:@"linkURL"] ;
                if (i%2==0) {
                    btn_Touch.frame = CGRectMake(-5, 70, 48, 48);
                }
                else{
                    btn_Touch.frame = CGRectMake(-5, 105, 48, 48);
                }
                [contentsView[i] addSubview:btn_Touch];
                contentsView[i].image = [UIImage imageNamed:@"sen.png"];
            }
            if ([[jsonTemp valueForKeyPath:@"check"] boolValue] == YES) {
                //                NSLog(@"番号:%d",i);
                //                NSLog(@"温度:%@",[jsonTemp valueForKey:@"temperature"]);
                temprature_Label[i].text = [NSString stringWithFormat:@"%d℃",[[jsonTemp valueForKey:@"temperature"] intValue]];
                [contentsView[i] addSubview:temprature_Label[i]];
                time_Label[i].frame = CGRectMake(-12, -29, 75, 30);
                
            }
        }];
        
    }

    
}
-(void)animation22:(NSTimer*)timer{
    changeCount++;
    if (changeCount %2 == 0) {
        [kame_View.layer removeAllAnimations];
        [kame_View1.layer addAnimation:animation1 forKey:nil];
    }
    else{
        [kame_View1.layer removeAllAnimations];
        [kame_View.layer addAnimation:animation forKey:nil];
    }
}

#pragma mark ###写真がタッチされたら呼ばれる###
-(void)touch_btnPhoto:(id)sender{
    NSLog(@"touch:photo");
    NSURL* photo_url = [NSURL URLWithString:[(CustomButton *)sender urlString]];
    NSData* data = [NSData dataWithContentsOfURL:photo_url];
    UIImage* img = [[UIImage alloc] initWithData:data];
    CGRect rect = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 320, 240);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    imageView.layer.anchorPoint = CGPointMake(1.0, 1.0);
    imageView.image = img;
    UIScreen* screen = [UIScreen mainScreen];
    UIView *photo_View = [[UIView alloc] initWithFrame:CGRectMake(0.0,0.0,screen.bounds.size.width,screen.bounds.size.height)];
    photo_View.backgroundColor =  [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photo_view_Tapped:)];
    
    [photo_View addGestureRecognizer:tapGesture];
    [photo_View addSubview:imageView];
    [self.view.window addSubview:photo_View];
    
}

- (void)photo_view_Tapped:(UITapGestureRecognizer *)sender
{
    UIView *del_View = (UIView*)sender.view;
    [del_View removeFromSuperview];
}

#pragma mark ###音声がタッチされたら呼ばれる###
-(void)touch_btnVoice:(id)sender{
    
    NSURL* voice_url = [NSURL URLWithString:[(CustomButton *)sender urlString]];
    
    if(self.audioStremarPlayer){
        [self.audioStremarPlayer removeObserver:self forKeyPath:@"status"];
    }
    self.audioStremarPlayer = [[AVPlayer alloc]initWithURL:voice_url];
    [self.audioStremarPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if (object == self.audioStremarPlayer && [keyPath isEqualToString:@"status"]) {
        if (self.audioStremarPlayer.status == AVPlayerStatusFailed)
        {
            NSLog(@"AVPlayer Failed");
        }
        else if (self.audioStremarPlayer.status == AVPlayerStatusReadyToPlay)
        {
            [self.audioStremarPlayer play];
        }
        else if (self.audioStremarPlayer.status == AVPlayerItemStatusUnknown)
        {
            NSLog(@"AVPlayer Unknown");
            
        }
    }
}

#pragma mark ###触るがタッチされたら呼ばれる###
-(void)touch_btnTouch:(id)sender{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)touch_btnSetting:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.delegate = self;
    alert.title = @"確認";
    alert.message = @"ログアウトしてもよろしいですか？";
    [alert addButtonWithTitle:@"いいえ"];
    [alert addButtonWithTitle:@"はい"];
    [alert show];
}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (buttonIndex) {
        case 0:
            break;
        case 1:{
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud removeObjectForKey:@"U_ID"];
            [ud synchronize];
            imageList = nil;
            imageList1 = nil;
            imageList_Umi = nil;
            self.audioStremarPlayer = nil;
            self.umi_View = nil;
            kame_ImgView = nil;
            kame_ImgView1 = nil;
            for (int i = 0; i<144; i++) {
                
                contentsView[i] = nil;
            }
            [animeTimer invalidate];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
