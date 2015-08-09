//
//  LoginViewController.h
//  MINERGAME
//
//  Created by koudai miwa on 2015/08/07.
//  Copyright (c) 2015年 MINAMI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
- (IBAction)text_Field:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *indicatorBaseView;

@end
