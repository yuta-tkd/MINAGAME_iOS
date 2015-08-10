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
    NSMutableArray *imageList = [NSMutableArray array];
    for (int i = 0; i <= 50; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"minagame_%03d.png", i];
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
    self.imageview.animationImages = imageList;
    self.imageview.animationDuration = 1;
    self.imageview.animationRepeatCount = 0;
    [self.imageview startAnimating];
    
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
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//DB用
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"HH:mm"];//表示用
    NSDateFormatter *hour_Fmt = [[NSDateFormatter alloc] init];
    [hour_Fmt setDateFormat:@"YYYY-MM-dd HH"];//DB用
    
    NSDate *nowTime = [NSDate date];//現在時刻
    NSString* st = [hour_Fmt stringFromDate:nowTime];
    NSString *dbTime_String = [formater stringFromDate:nowTime];//DB用時刻文字
    NSDate* first_Date = [hour_Fmt dateFromString:st];//前
//    NSCalendar* cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSCalendarUnit unitFlags =  NSCalendarUnitDay| NSCalendarUnitHour | NSCalendarUnitMinute;
//    NSDateComponents *dateComponents_Hour = [cal components:unitFlags fromDate:nowTime];
//    NSInteger day_Axis = dateComponents_Hour.day;//時間
//    NSInteger hour_Axis = dateComponents_Hour.hour;//時間
//    NSDate* comp_Hour = [hour_Fmt dateFromString:[NSString stringWithFormat:@"%02ld %02ld",(long)day_Axis,(long)hour_Axis]];
    
    NSURL *url = [NSURL URLWithString:@"http://ec2-52-69-253-248.ap-northeast-1.compute.amazonaws.com/api/allSensor"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body = [NSString stringWithFormat:@"edisonName=%@&startTime=%@&duration=%d",[NSString stringWithFormat:@"kame03"],dbTime_String,60];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    for (int i = 144; i > 0; --i) {
        contentsView[i] = [[UIImageView alloc] init];
        contentsView[i].frame = CGRectMake(60*i, 100, 46.875, 300);
        contentsView[i].tag = i;
        //contentsView[i].backgroundColor = [UIColor redColor];
        [scrollView addSubview:contentsView[i]];
    }
    //int user_temp = [jsonArray[@"temperatures"][0][@"Temperature"][@"temperature"] intValue];
#pragma mark ###24時間更新###
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError* error=nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"%@",jsonArray);
        int daysToAdd = -1;
        
        
        for (int i = 144; i > 0; --i) {
            if (true) {
                NSDate *before_Date = [nowTime dateByAddingTimeInterval:60*10*daysToAdd];
                
                daysToAdd--;
                
                NSCalendar* cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                NSCalendarUnit unitFlags =  NSCalendarUnitDay|NSCalendarUnitHour | NSCalendarUnitMinute;
                
                NSDateComponents *dateComponents = [cal components:unitFlags fromDate:before_Date];
                NSInteger hour_Before = dateComponents.hour;//修正時間
                NSString* mod_Time_String = [NSString stringWithFormat:@"%02ld:00",hour_Before];
                
                NSString* before_St = [hour_Fmt stringFromDate:before_Date];//前
                
                NSDate* second_Date = [hour_Fmt dateFromString:before_St];//前
                
        
                UILabel *time_Label = [[UILabel alloc] init];
                time_Label.frame = CGRectMake(0, 10, 65, 18);
                time_Label.textColor = [UIColor blackColor];
                time_Label.font = [UIFont fontWithName:@"RuikaKyohkan-05" size:13];
                time_Label.textAlignment = NSTextAlignmentLeft;
                NSLog(@"比較:%@,%@",first_Date,second_Date);
                
                NSComparisonResult result = [first_Date compare:second_Date];
                switch(result) {
                    case NSOrderedSame: // 一致したとき
                        break;
                        
                    case NSOrderedAscending: // date1が小さいとき
                        break;
                        
                    case NSOrderedDescending: {// date1が大きいとき
                        time_Label.text = mod_Time_String;
                        NSString* next_St = [hour_Fmt stringFromDate:before_Date];
//                        first_Date = [hour_Fmt dateFromString:next_St];//最初の比較用
                        break;
                    }
                }
                
                UILabel *temp_Label = [[UILabel alloc] init];
                temp_Label.frame = CGRectMake(0, 25, 35, 18);
                temp_Label.font = [UIFont fontWithName:@"RuikaKyohkan-05" size:13];
                temp_Label.textAlignment = NSTextAlignmentLeft;
                temp_Label.text = [NSString stringWithFormat:@"%d",i];
                UIButton *btn_Photo  = [UIButton buttonWithType:UIButtonTypeCustom];
                btn_Photo.frame = CGRectMake(-5, 50, 40, 40);
                [btn_Photo setImage:[UIImage imageNamed:@"photo.png"] forState:UIControlStateNormal];
                [btn_Photo addTarget:self action:@selector(touch_btnPhoto:) forControlEvents:UIControlEventTouchUpInside];
                UIButton *btn_Voice  = [UIButton buttonWithType:UIButtonTypeCustom];
                btn_Voice.frame = CGRectMake(-5, 120, 40, 40);
                [btn_Voice setImage:[UIImage imageNamed:@"sound.png"] forState:UIControlStateNormal];
                [btn_Voice addTarget:self action:@selector(touch_btnVoice:) forControlEvents:UIControlEventTouchUpInside];
                UIButton *btn_Touch  = [UIButton buttonWithType:UIButtonTypeCustom];
                btn_Touch.frame = CGRectMake(-5, 190, 40, 40);
                [btn_Touch setImage:[UIImage imageNamed:@"touch.png"] forState:UIControlStateNormal];
                [btn_Touch addTarget:self action:@selector(touch_btnTouch:) forControlEvents:UIControlEventTouchUpInside];
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
-(void)touch_btnPhoto:(NSURL*)url{

}

#pragma mark ###音声がタッチされたら呼ばれる###
-(void)touch_btnVoice:(NSURL*)url{

}
#pragma mark ###触るがタッチされたら呼ばれる###
-(void)touch_btnTouch:(BOOL)isTouch{

}

-(void)requestSenserDatas:(NSTimer*)timer{
    NSURL *url = [NSURL URLWithString:@""];
    NSURLRequest  *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:nil completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
#pragma mark ###10分更新###
        for (int i = 0; i < 144; i++) {
            [contentsView[i] removeFromSuperview];
            contentsView[i] = [[UIImageView alloc] init];
            contentsView[i].frame = CGRectMake(60*i, 100, 46.875, 300);
            contentsView[i].tag = i;
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
