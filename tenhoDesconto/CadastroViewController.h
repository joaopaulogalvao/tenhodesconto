//
//  CadastroViewController.h
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 4/11/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CadastroViewController : UIViewController<UITextFieldDelegate, UIGestureRecognizerDelegate, PFSignUpViewControllerDelegate>



@property (weak, nonatomic) IBOutlet UITextField *signUpNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *signUpEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *signUpPsswdTextField;
@property (weak, nonatomic) IBOutlet UITextField *signUpBdayTextField;

@property (weak, nonatomic) IBOutlet UISegmentedControl *signUpGenderSegmented;

@property (weak, nonatomic) IBOutlet UITextField *signUpCityTextField;
@property (weak, nonatomic) IBOutlet UITextField *signUpStateTextField;
@property (weak, nonatomic) IBOutlet UITextField *signUpCountryTextField;


@property (weak, nonatomic) IBOutlet UIScrollView *signUpScroll;

@property (nonatomic, strong) UITapGestureRecognizer *signUpGestureRecognizer;


- (IBAction)performSignUp:(id)sender;





@end
