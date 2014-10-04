//
//  LoginViewController.h
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 4/11/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController<PFLogInViewControllerDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginSendButton;


@property (weak, nonatomic) IBOutlet UIScrollView *loginScrollView;



@property (nonatomic, strong) UITapGestureRecognizer *gestureRecognizer;


- (IBAction)performLogin:(id)sender;

@end
