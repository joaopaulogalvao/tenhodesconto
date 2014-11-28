//
//  CadastroViewController.m
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 4/11/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import "CadastroViewController.h"
#import "HomeViewController.h"

@interface CadastroViewController ()

@end

@implementation CadastroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    
    self.signUpScroll.scrollEnabled = YES;
    
    self.signUpScroll.contentSize = CGSizeMake(0.0, 416.0); // 416
    
    self.signUpNameTextField.delegate =
    self.signUpEmailTextField.delegate =
    self.signUpPsswdTextField.delegate =
    self.signUpBdayTextField.delegate =
    self.signUpStateTextField.delegate =
    self.signUpCountryTextField.delegate =
    self.signUpCityTextField.delegate = self;
    
    self.signUpGestureRecognizer.delegate = self;
    
    self.signUpGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signUpHideKeyboard:)];
    
    [self.signUpScroll addGestureRecognizer:self.signUpGestureRecognizer];

    
}


#pragma mark - UITextFieldDelegate

// Triggered when the user starts typing
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    // Set the Scroll Size.
    self.signUpScroll.contentSize = CGSizeMake(0.0, 480.0 + 216.0);
    
    // Só pega o de baixo, o tamanho do de baixo já vale para os dois.
    if (textField == self.signUpNameTextField) {
        
        self.signUpScroll.scrollEnabled = YES;
        
        // Scroll position Control
        [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
        
    } else {
        
        if (textField == self.signUpEmailTextField) {
            [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
            
        } else {
            
            if (textField == self.signUpPsswdTextField) {
                
                self.signUpScroll.scrollEnabled = YES;
                
                [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
            
            } else {
                
                if (textField == self.signUpBdayTextField) {
                    
                    self.signUpScroll.scrollEnabled = YES;
                    
                    [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];

                } else {
                    
                        if (textField == self.signUpCityTextField) {
                            
                            self.signUpScroll.scrollEnabled = YES;
                            
                            [self.signUpScroll setContentOffset:CGPointMake(0.0, 160.0) animated:YES];
                            
                        } else {
                            
                            if (textField == self.signUpStateTextField) {
                                
                                self.signUpScroll.scrollEnabled = YES;
                                
                                [self.signUpScroll setContentOffset:CGPointMake(0.0, 160.0) animated:YES];
                                
                            } else {
                                
                                if (textField == self.signUpCountryTextField) {
                                    
                                    self.signUpScroll.scrollEnabled = YES;
                                    
                                    [self.signUpScroll setContentOffset:CGPointMake(0.0, 160.0) animated:YES];
                                    
                                } else {
                                    
                                    
                                }

                            }

                        }
                    
                 }
                    
            }

        }
        
    }
    
}

// Triggered when the user press Return

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
    // Só pega o de baixo, o tamanho do de baixo já vale para os dois.
    if (textField == self.signUpNameTextField) {
        
        [self.signUpEmailTextField becomeFirstResponder];
        
        // Scroll position Control
        [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
        
    } else {
        
        if (textField == self.signUpEmailTextField) {
            
            [self.signUpPsswdTextField becomeFirstResponder];
            
            [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
            
        } else {
            
            if (textField == self.signUpPsswdTextField) {
                
                [self.signUpBdayTextField becomeFirstResponder];
                
                [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
                
            } else {
                
                if (textField == self.signUpBdayTextField) {
                    
                    [self.signUpCityTextField becomeFirstResponder];
                    
                    [self.signUpScroll setContentOffset:CGPointMake(0.0, 70.0) animated:YES];
                    
                } else {
                        
                    if (textField == self.signUpCityTextField) {
                            
                        [self.signUpStateTextField becomeFirstResponder];
                            
                        [self.signUpScroll setContentOffset:CGPointMake(0.0, 160.0) animated:YES];
                            
                    } else {
                            
                        if (textField == self.signUpStateTextField) {
                                
                            [self.signUpCountryTextField becomeFirstResponder];
                                
                            [self.signUpScroll setContentOffset:CGPointMake(0.0, 160.0) animated:YES];
                                
                        } else {
                                
                            if (textField == self.signUpCountryTextField) {
                                    
                                [self.signUpCountryTextField resignFirstResponder];
                                    
                                [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
                                    
                            } else {
                                    
                                    
                            }
                                
                         }
                            
                     }
                    
                  }
                
              }
            
          }
        
     }

    return YES;
}

#pragma Mark - My Actions


// Hide Keyboard when Tapped
-(void) signUpHideKeyboard: (id) sender {
    
    
    if ([self.signUpNameTextField becomeFirstResponder]) {
        
        [self.signUpNameTextField resignFirstResponder];
        
        // Scroll position Control
        [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
        
    } else {
        
        if ([self.signUpEmailTextField becomeFirstResponder]) {
            
            [self.signUpEmailTextField resignFirstResponder];
            
            [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
            
        } else {
            
            if ([self.signUpPsswdTextField becomeFirstResponder]) {
                
                [self.signUpPsswdTextField resignFirstResponder];
                
                [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
                
            } else {
                
                if ([self.signUpBdayTextField becomeFirstResponder]) {
                    
                    [self.signUpBdayTextField resignFirstResponder];
                    
                    [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
                    
                } else {
                    
                    if ([self.signUpGenderSegmented becomeFirstResponder]) {
                        
                        [self.signUpGenderSegmented resignFirstResponder];
                        
                        [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
                        
                    } else {
                        
                        if ([self.signUpCityTextField becomeFirstResponder]) {
                            
                            [self.signUpCityTextField resignFirstResponder];
                            
                            [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
                            
                        } else {
                            
                            if ([self.signUpStateTextField becomeFirstResponder]) {
                                
                                [self.signUpStateTextField resignFirstResponder];
                                
                                [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
                                
                            } else {
                                
                                if ([self.signUpCountryTextField becomeFirstResponder]) {
                                    
                                    [self.signUpCountryTextField resignFirstResponder];
                                    
                                    [self.signUpScroll setContentOffset:CGPointMake(0.0, 0.0) animated:YES];
                                    
                                } else {
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

#pragma mark - Parse

// Peform SignUp

- (IBAction)performSignUp:(id)sender {
    
    // Instanciate user class and its atributes
    PFUser *user = [PFUser user];
    PFObject *usuario = [PFObject objectWithClassName:@"Usuario"];
    
    user.username = self.signUpEmailTextField.text;
    user.password = self.signUpPsswdTextField.text;
//    user.email = self.signUpEmailTextField.text;
    [usuario setObject:self.signUpNameTextField.text forKey:@"name"];
    [usuario setObject:self.signUpEmailTextField.text forKey:@"email"];
    [usuario setObject:self.signUpPsswdTextField.text forKey:@"password"];
    [usuario setObject:self.signUpBdayTextField.text forKey:@"bday"];
    [usuario setObject:self.signUpCityTextField.text forKey:@"city"];
    [usuario setObject:self.signUpStateTextField.text forKey:@"state"];
    [usuario setObject:self.signUpCountryTextField.text forKey:@"country"];
    if (self.signUpGenderSegmented.selectedSegmentIndex == 0) {
        [usuario setObject:@"feminino" forKey:@"gender"];
    } else {
        [usuario setObject:@"masculino" forKey:@"gender"];
    }
    [usuario save];
    
    
    [user setObject:self.signUpBdayTextField.text forKey:@"bday"];
    [user setObject:self.signUpCityTextField.text forKey:@"city"];
    [user setObject:self.signUpStateTextField.text forKey:@"state"];
    [user setObject:self.signUpCountryTextField.text forKey:@"country"];
    
   
    
    // Show an alert for success or error
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
           
            
            UIAlertView* successAlertView = [[UIAlertView alloc]
                                             initWithTitle:@"Sucesso"
                                             message:@"Verifique o seu e-mail e confirme o seu cadastro!"
                                             delegate:nil
                                             cancelButtonTitle:@"Ok"
                                             otherButtonTitles:nil, nil];
            
            [successAlertView show];
            
            
            
            [self.navigationController  popToRootViewControllerAnimated:YES];
            
            
            
        } else {
            //Something bad has ocurred
            NSString *errorString = [[error userInfo] objectForKey:@"Confira os seus dados!"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Erro" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];

    
    
    
    
}
@end





















































