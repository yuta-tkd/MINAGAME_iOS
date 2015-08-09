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

const float VIEW_WIDTH = 8625;

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
#pragma makrk ###アニメーション###
    NSMutableArray *imageList = [NSMutableArray array];
    for (int i = 0; i <= 50; i++) {
        NSString *imagePath = [NSString stringWithFormat:@"minagame_%03d.png", i];
        UIImage *img = [UIImage imageNamed:imagePath];
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
    
    NSDate *nowTime = [NSDate dateWithTimeIntervalSinceNow:0.0f];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"HH:mm"];
    
    NSCalendar* cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unitFlags =  NSCalendarUnitHour | NSCalendarUnitMinute;
    
    NSDate *nowTime_DB = [NSDate date];
    NSDateComponents *dateComponents = [cal components:unitFlags fromDate:nowTime_DB];
    
    NSInteger hour = dateComponents.hour;
    NSInteger minute = dateComponents.minute;
    
#pragma mark ###時間設定###
    
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *nowtime_S = [formater stringFromDate:nowTime_DB];
    NSLog(@"TIME:%@",nowtime_S);
    NSUserDefaults* ud = [NSUserDefaults  standardUserDefaults];
    NSURL *url = [NSURL URLWithString:@"http://ec2-52-69-253-248.ap-northeast-1.compute.amazonaws.com/api/allSensor"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body = [NSString stringWithFormat:@"edisonName=%@&startTime=%@&duration=%d",[NSString stringWithFormat:@"kame03"],nowtime_S,60];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    for (int i = 0; i < 144; i++) {
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
        for (int i = 1; i < 145; i++) {
            if (true) {
                int daysToAdd = 1;
                NSDate *newDate1 = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
                
                
                double before_Time = -(i*10*60);
                NSDate *ten_Timeago = [nowTime initWithTimeInterval:before_Time sinceDate:nowTime];
                NSString *afterTimeString = [fmt stringFromDate:ten_Timeago];
                UILabel *time_Label = [[UILabel alloc] init];
                time_Label.frame = CGRectMake(0, 10, 65, 18);
                time_Label.textColor = [UIColor blackColor];
                time_Label.font = [UIFont fontWithName:@"RuikaKyohkan-05" size:13];
                time_Label.textAlignment = NSTextAlignmentLeft;
                time_Label.text = afterTimeString;
                UILabel *temp_Label = [[UILabel alloc] init];
                temp_Label.frame = CGRectMake(0, 25, 35, 18);
                temp_Label.font = [UIFont fontWithName:@"RuikaKyohkan-05" size:13];
                temp_Label.textAlignment = NSTextAlignmentLeft;
                temp_Label.text = [NSString stringWithFormat:@"%d",i];
                UIButton *btn_Photo  = [UIButton buttonWithType:UIButtonTypeCustom];
                btn_Photo.frame = CGRectMake(-5, 50, 40, 40);
                [btn_Photo setImage:[UIImage imageNamed:@"photo.png"] forState:UIControlStateNormal];
                [btn_Photo addTarget:self action:@selector(touch_btnPhoto) forControlEvents:UIControlEventTouchUpInside];
                UIButton *btn_Voice  = [UIButton buttonWithType:UIButtonTypeCustom];
                btn_Voice.frame = CGRectMake(-5, 120, 40, 40);
                [btn_Voice setImage:[UIImage imageNamed:@"sound.png"] forState:UIControlStateNormal];
                [btn_Voice addTarget:self action:@selector(touch_btnVoice) forControlEvents:UIControlEventTouchUpInside];
                UIButton *btn_Touch  = [UIButton buttonWithType:UIButtonTypeCustom];
                btn_Touch.frame = CGRectMake(-5, 190, 40, 40);
                [btn_Touch setImage:[UIImage imageNamed:@"touch.png"] forState:UIControlStateNormal];
                [btn_Touch addTarget:self action:@selector(touch_btnTouch) forControlEvents:UIControlEventTouchUpInside];
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

-(void)touch_btnPhoto{

}

-(void)touch_btnVoice{

}

-(void)touch_btnTouch{

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
