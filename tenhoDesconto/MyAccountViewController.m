//
//  MyAccountViewController.m
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 4/15/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import "MyAccountViewController.h"
#import <Parse/Parse.h>

@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

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

-(void)viewDidLayoutSubviews{
    
    [self.accountScroll setContentSize:CGSizeMake(320.0, 680.0)];
    [self.accountScroll setContentSize:CGSizeMake(320.0, 680.0)];
    
    [self.accountScroll setContentOffset:CGPointMake(0.0, 0.0)];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.accountScroll.scrollEnabled = YES;
    
//    PFUser* user;
    
    
    
//    [query whereKey:@"name" equalTo:[PFUser currentUser]];
    
//    PFObject *profile = [PFObject objectWithClassName:@"User"];
  
    PFQuery *query = [PFQuery queryWithClassName:@"Usuario"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        // Do something with the returned PFObject.
        
        self.accountNameTextField.text = [object objectForKey:@"name"];
        self.accountEmailTextField.text = [object objectForKey:@"email"];
        self.accountPsswdTextField.text = [object objectForKey:@"password"];
        self.accountBdayTextField.text = [object objectForKey:@"bday"];
        self.accountGenderTextField.text = [object objectForKey:@"gender"];
        self.accountCityTextField.text = [object objectForKey:@"city"];
        self.accountStateTextField.text = [object objectForKey:@"state"];
        self.accountCountryTextField.text = [object objectForKey:@"country"];
        
        NSLog(@"%@", object);
    }];
     
        
  

    

//        self.accountEmailTextField.text = [NSString stringWithFormat:@"%@",[profile objectForKey:@"email"]];
   
    

    

    
    
 
//    
//    self.automaticallyAdjustsScrollViewInsets = NO;

    
    
    
//    [self.accountScroll setFrame:CGRectMake(0.0, 0.0, 0.0, 1300.0)];
}


- (IBAction)performLogout:(id)sender {
    
    [PFUser logOut];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)performEditing:(id)sender {
}
@end






















