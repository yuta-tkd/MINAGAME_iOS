//
//  LoginViewController.m
//  MINERGAME
//
//  Created by koudai miwa on 2015/08/07.
//  Copyright (c) 2015年 MINAMI. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.indicatorBaseView.hidden =YES;
    
}
-(void)viewDidAppear:(BOOL)animated{

    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([ud valueForKey:@"U_ID"] !=NULL && ![[ud valueForKey:@"U_ID"]  isEqual: @""] ) {
        MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
        [self presentViewController:mainViewController animated:NO completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(BOOL)textFieldShouldBeginEditing:(UITextField*)textField{
    textField.returnKeyType = UIReturnKeyDone;
    // delegate
    textField.delegate = self;
    return YES;
}

#pragma mark ###SERVER###
- (IBAction)text_Field:(id)sender {
    self.indicatorBaseView.hidden = NO;
    UITextField *textField = (UITextField*)sender;
    NSURL *url = [NSURL URLWithString:@"http://ec2-52-69-253-248.ap-northeast-1.compute.amazonaws.com/api/login"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *body = [NSString stringWithFormat:@"edisonName=%@",textField.text];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        self.indicatorBaseView.hidden =YES;
        NSError *error=nil;
#pragma mark ###JSON###
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"ログイン%@",jsonArray);
        bool user_id = [[jsonArray valueForKeyPath:@"check"] boolValue];
        if (user_id) {
            NSLog(@"成功");
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setValue:[NSString stringWithFormat:@"%@",textField.text] forKey:@"U_ID"];
            MainViewController *mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"main"];
            [self presentViewController:mainViewController animated:NO completion:nil];
        }
        else{
            NSString *message = @"IDが違います";
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }];
}
@end
