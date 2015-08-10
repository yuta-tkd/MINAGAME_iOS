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

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma makrk ###アニメーション###
    
    UIImage *image = [UIImage imageNamed:@"minagame1_001.png"];
    UIImageView *imageview = [[UIImageView alloc]initWithImage:image];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    
    // CAKeyframeAnimationオブジェクトを生成
    CAKeyframeAnimation *animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    animation.duration = 4.5;
    
    
    // 放物線のパスを生成
    CGFloat jumpHeight = 130;
    CGFloat kStartPosx = 0;
    CGFloat kStartPosy = 500;
    CGFloat kEndPosx = 400;
    CGFloat kEndPosy = 500;
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, kStartPosx, kStartPosy);
    CGPathAddCurveToPoint(curvedPath, NULL,
                          kStartPosx + jumpHeight, kStartPosy - jumpHeight,
                          kStartPosx + jumpHeight, kStartPosy + jumpHeight,
                          kEndPosx, kEndPosy);
    
    // パスをCAKeyframeAnimationオブジェクトにセット
    animation.path = curvedPath;
    
    
    // パスを解放
    CGPathRelease(curvedPath);
    
    NSMutableArray *imageList = [NSMutableArray array];
    for (int i = 0; i <= 16; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"minagame1_%03d.png", i];
        UIImage *img = [UIImage imageNamed:imagePath];
        
        UIImage *img_af;
        CGFloat width = 200;
        CGFloat height = 200;
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        [img drawInRect:CGRectMake(0, 0, width, height)];
        img_af = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (img != nil)
        {
            [imageList addObject:img];
        }
    }
    imageview.animationImages = imageList;
    imageview.animationDuration = 1;
    imageview.animationRepeatCount = 0;
    [view.layer addAnimation:animation forKey:nil];
    [imageview startAnimating];
    
    [view addSubview:imageview];
    [self.view addSubview:view];
    
    
    
    
    
    
    
    
    
    UIImage* b_setting_Img = [UIImage imageNamed:@"setting.png"];
    UIImage *a_setting_Img;
    CGFloat width = 40;
    CGFloat height = 40;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [b_setting_Img drawInRect:CGRectMake(0, 0, width, height)];
    a_setting_Img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.btn_Setting.layer.zPosition = 1;
    [self.btn_Setting setImage:a_setting_Img forState:UIControlStateNormal];
    
    // Do any additional setup after loading the view.
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
    scrollView.contentOffset = CGPointMake(8286,0);
    //NSLog(@"オフセット:x:%f,y:%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    __block NSDate* START_TIME = [NSDate date];
    __block NSDate* change_Time = [NSDate date];
    START_TIME = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    change_Time = [NSDate dateWithTimeIntervalSinceNow:[[NSTimeZone systemTimeZone] secondsFromGMT]];
    
    NSLog(@"START_HOUR:[%@]",START_TIME);
    NSLog(@"change_Time:[%@]",change_Time);
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//DB用

    NSCalendar* cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unitFlags =  NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *dateComponents_Hour = [cal components:unitFlags fromDate:START_TIME];
    __block NSInteger START_HOUR = dateComponents_Hour.hour -9;
    __block NSInteger change_Hour = dateComponents_Hour.hour -9;
    if (START_HOUR < 0) {
        START_HOUR +=24;
    }
    if (change_Hour < 0) {
        change_Hour +=24;
    }
    
    NSLog(@"START_HOUR:[%ld]",(long)START_HOUR);
    NSLog(@"change_Hour:[%ld]",(long)change_Hour);
    NSString* dbTime_String = [formater stringFromDate:change_Time];
    
    NSURL *url = [NSURL URLWithString:@"http://ec2-52-69-253-248.ap-northeast-1.compute.amazonaws.com/api/allSensor"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body = [NSString stringWithFormat:@"edisonName=%@&startTime=%@&duration=%d",[NSString stringWithFormat:@"kame03"],dbTime_String,60];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    for (int i = 144; i > 0; --i) {
        contentsView[i] = [[UIImageView alloc] init];
        contentsView[i].frame = CGRectMake(60*i, 100, 46.875, 300);
        contentsView[i].tag = i;
        contentsView[i].userInteractionEnabled = YES;
        //contentsView[i].backgroundColor = [UIColor redColor];
        [scrollView addSubview:contentsView[i]];
    }
    //int user_temp = [jsonArray[@"temperatures"][0][@"Temperature"][@"temperature"] intValue];
#pragma mark ###24時間更新###
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError* error=nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",jsonArray);
        
        for (int i = 144; i > 0; --i) {
            if (true) {
                
//                NSLog(@"change_time_2:[%@]",change_Time);
//                NSLog(@"change_hour:[%ld]",(long)change_Hour);
                UILabel *time_Label = [[UILabel alloc] init];
                UILabel *temp_Label = [[UILabel alloc] init];
                
                if (START_HOUR == change_Hour) {
                    NSLog(@"START_HOUR_2:[%ld]",(long)START_HOUR);
                    time_Label.frame = CGRectMake(5, 10, 65, 18);
                    time_Label.textAlignment = NSTextAlignmentCenter;
                    time_Label.textColor = [UIColor blackColor];
                    time_Label.font = [UIFont fontWithName:@"RuikaKyohkan-05" size:18];
                    time_Label.textAlignment = NSTextAlignmentLeft;
                    time_Label.text = [NSString stringWithFormat:@"%ld", START_HOUR];
                    NSLog(@"START_TIME_2:[%@]",START_TIME);
                    NSLog(@"change_time_2:[%@]",change_Time);
                    
                    temp_Label.frame = CGRectMake(5, 25, 45, 18);
                    temp_Label.textAlignment = NSTextAlignmentCenter;
                    temp_Label.font = [UIFont fontWithName:@"RuikaKyohkan-05" size:13];
                    temp_Label.textAlignment = NSTextAlignmentLeft;
                    temp_Label.text = [NSString stringWithFormat:@"%d℃",i];
                    
                    START_TIME = [START_TIME dateByAddingTimeInterval:-60*60];
                    NSCalendar* cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                    NSCalendarUnit unitFlags =  NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute;
                    NSDateComponents *dateComponents = [cal components:unitFlags fromDate:START_TIME];
                    START_HOUR = dateComponents.hour -9;
                    if (START_HOUR < 0) {
                        START_HOUR +=24;
                    }
                    
                }
                change_Time = [change_Time dateByAddingTimeInterval:-60*10];
                
                NSCalendar* cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                NSCalendarUnit unitFlags =  NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute;
                NSDateComponents *dateComponents = [cal components:unitFlags fromDate:change_Time];
                change_Hour = dateComponents.hour -9;
                if (change_Hour < 0) {
                    change_Hour +=24;
                }
                
                //btn_Photo
                UIButton *btn_Photo  = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn_Photo setImage:[UIImage imageNamed:@"photo.png"] forState:UIControlStateNormal];
                [btn_Photo addTarget:self
                        action:@selector(touch_btnPhoto:) forControlEvents:UIControlEventTouchUpInside];
                
                //btn_Voice
                UIButton *btn_Voice  = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn_Voice setImage:[UIImage imageNamed:@"sound.png"] forState:UIControlStateNormal];
                [btn_Voice addTarget:self action:@selector(touch_btnVoice:) forControlEvents:UIControlEventTouchUpInside];
                
                //btn_Touch
                UIButton *btn_Touch  = [UIButton buttonWithType:UIButtonTypeCustom];
                btn_Touch.enabled = false;
                [btn_Touch setImage:[UIImage imageNamed:@"touch.png"] forState:UIControlStateNormal];
                [btn_Touch addTarget:self action:@selector(touch_btnTouch:) forControlEvents:UIControlEventTouchUpInside];
                
                if (i%2==0) {
                    btn_Touch.frame = CGRectMake(-5, 50, 48, 48);
                    btn_Voice.frame = CGRectMake(-5, 120, 48, 48);
                    btn_Photo.frame = CGRectMake(-5, 190, 48, 48);
                }
                else{
                    btn_Touch.frame = CGRectMake(-5, 85, 48, 48);
                    btn_Photo.frame = CGRectMake(-5, 225, 48, 48);
                    btn_Voice.frame = CGRectMake(-5, 155, 48, 48);
                }
                [contentsView[i] addSubview:time_Label];
                [contentsView[i] addSubview:temp_Label];
                [contentsView[i] addSubview:btn_Touch];
                [contentsView[i] addSubview:btn_Photo];
                [contentsView[i] addSubview:btn_Touch];
                [contentsView[i] addSubview:btn_Voice];
            }
        }
    }];
    
    [NSTimer scheduledTimerWithTimeInterval:600 target:self selector:@selector(requestSenserDatas:) userInfo:nil repeats:YES];
}

#pragma mark ###写真がタッチされたら呼ばれる###
-(void)touch_btnPhoto:(id)sender{
    NSLog(@"touch:photo");
    //sender経由でボタンを取得
    //UIButton *button = (UIButton *)sender;

    //仮URL
    NSString* path = @"http://ec2-52-69-253-248.ap-northeast-1.compute.amazonaws.com/edison/photos/e5ccc0424016aa86ffe89829400f6f9d.jpg";
    NSURL* photo_url = [NSURL URLWithString:path];
    NSData* data = [NSData dataWithContentsOfURL:photo_url];
    UIImage* img = [[UIImage alloc] initWithData:data];
    // UIImageViewの初期化
    CGRect rect = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 320, 240);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:rect];
    imageView.layer.anchorPoint = CGPointMake(1.0, 1.0);
    imageView.image = img;
    // UIView
    UIScreen* screen = [UIScreen mainScreen];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0,0.0,screen.bounds.size.width,screen.bounds.size.height)];
    view.backgroundColor =  [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.4];
    //UITapGesture
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photo_view_Tapped:)];

    [view addGestureRecognizer:tapGesture];
    [view addSubview:imageView];
    [self.view.window addSubview:view];
    
}

- (void)photo_view_Tapped:(UITapGestureRecognizer *)sender
{
    NSLog(@"タップされました．");
    UIView *view = sender.view;
    [view removeFromSuperview];
}

#pragma mark ###音声がタッチされたら呼ばれる###
-(void)touch_btnVoice:(NSURL*)url{
    NSLog(@"touch:voice");
    //sender経由でボタンを取得
    //UIButton *button = (UIButton *)sender;
    
    //仮URL
    NSString* path = @"http://ec2-52-69-253-248.ap-northeast-1.compute.amazonaws.com/edison/sounds/e0a78816c2f28fccad285db710263999.wav";
    NSURL* sound_url = [NSURL URLWithString:path];
    
    // stremar player

    if(self.audioStremarPlayer){
        [self.audioStremarPlayer removeObserver:self forKeyPath:@"status"];
    }
    self.audioStremarPlayer = [[AVPlayer alloc]initWithURL:sound_url];
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
-(void)touch_btnTouch:(BOOL)isTouch{
    NSLog(@"touch:touch");
}

-(void)requestSenserDatas:(NSTimer*)timer{
    NSURL *url = [NSURL URLWithString:@""];
    NSURLRequest  *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:nil completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
#pragma mark ###10分更新###
        for (int i = 144; i > 0; --i) {xx
            [contentsView[i] removeFromSuperview];
            contentsView[i] = [[UIImageView alloc] init];
            contentsView[i].frame = CGRectMake(60*i, 100, 46.875, 300);
            contentsView[i].tag = i;
            contentsView[i].userInteractionEnabled = YES;
            [scrollView addSubview:contentsView[i]];

            if (1 >= 0) {
                
                UILabel *time_Label = [[UILabel alloc] init];
                time_Label.frame = CGRectMake(0, 10, 65, 18);
                time_Label.textColor = [UIColor blackColor];
                time_Label.font = [UIFont fontWithName:@"AppleGothic" size:12];
                time_Label.textAlignment = NSTextAlignmentLeft;
                time_Label.text = @"12:15";
                
                UILabel *temp_Label = [[UILabel alloc] init];
                temp_Label.frame = CGRectMake(0, 25, 25, 18);
                temp_Label.font = [UIFont fontWithName:@"AppleGothic" size:12];
                temp_Label.textAlignment = NSTextAlignmentLeft;
                temp_Label.text = [NSString stringWithFormat:@"%d",i];
                
                UIButton *btn_Photo  = [UIButton buttonWithType:UIButtonTypeCustom];
                btn_Photo.frame = CGRectMake(-5, 50, 40, 40);
                [btn_Photo setImage:[UIImage imageNamed:@"photo.png"] forState:UIControlStateNormal];
                UIButton *btn_Voice  = [UIButton buttonWithType:UIButtonTypeCustom];
                btn_Voice.frame = CGRectMake(-5, 120, 40, 40);
                [btn_Voice setImage:[UIImage imageNamed:@"sound.png"] forState:UIControlStateNormal];
                UIButton *btn_Touch  = [UIButton buttonWithType:UIButtonTypeCustom];
                btn_Touch.frame = CGRectMake(-5, 190, 40, 40);
                [btn_Touch setImage:[UIImage imageNamed:@"touch.png"] forState:UIControlStateNormal];
                [contentsView[i] addSubview:time_Label];
                [contentsView[i] addSubview:temp_Label];
                [contentsView[i] addSubview:btn_Touch];
                [contentsView[i] addSubview:btn_Photo];
                [contentsView[i] addSubview:btn_Touch];
                [contentsView[i] addSubview:btn_Voice];
            }
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
//    NSLog(@"オフセット:x:%f,y:%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
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
            //いいえ
            break;
        case 1:{
            //はい
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud removeObjectForKey:@"U_ID"];
            [ud synchronize];
            LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
            [self presentViewController:loginViewController animated:NO completion:nil];
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
