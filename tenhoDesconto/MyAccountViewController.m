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
@property (nonatomic, strong)NSArray *extraButtons;
@property (nonatomic, strong)UIBarButtonItem *saveButton;
@property (nonatomic,strong) UIBarButtonItem *editBarButtonItem;


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
    
//  self.accountScroll.scrollEnabled = YES;
    
    [self.cancelBarButtonItem setEnabled:NO];
    [self.cancelBarButtonItem setTintColor:[UIColor clearColor]];
  
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
    
    //Enable SaveButton
    self.editBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Editar" style:UIBarButtonItemStylePlain target:self action:@selector(performEditing:)];
    
    //Store in an Array
    self.extraButtons = @[self.editBarButtonItem];
    
    //Place into navigation Bar
    self.navigationItem.rightBarButtonItems = self.extraButtons;
    

//    self.accountEmailTextField.text = [NSString stringWithFormat:@"%@",[profile objectForKey:@"email"]];
   
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    [self.accountScroll setFrame:CGRectMake(0.0, 0.0, 0.0, 1300.0)];
    
}

#pragma mark - My Account Actions

- (IBAction)performLogout:(id)sender {
    
    [PFUser logOut];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)performEditing:(id)sender {
    
    NSLog(@"Edit touched: %@",self.editBarButtonItem);
    
    // Enable all fields for editing
    self.accountNameTextField.enabled =
    self.accountEmailTextField.enabled =
    self.accountPsswdTextField.enabled =
    self.accountBdayTextField.enabled =
    self.accountGenderTextField.enabled =
    self.accountCityTextField.enabled =
    self.accountStateTextField.enabled =
    self.accountCountryTextField.enabled = YES;
    
    //Show Cancel Button
    [self.cancelBarButtonItem setEnabled:YES];
    [self.cancelBarButtonItem setTintColor:nil];
    
    //Disable Edit Button
    [self.editBarButtonItem setEnabled:NO];
    [self.editBarButtonItem setTintColor:[UIColor clearColor]];
    
    //Enable SaveButton
    self.saveButton = [[UIBarButtonItem alloc]initWithTitle:@"Salvar" style:UIBarButtonItemStylePlain target:self action:@selector(saveEditions)];
    
    //Store in an Array
    self.extraButtons = @[self.saveButton];
    
    //Place into navigation Bar
    self.navigationItem.rightBarButtonItems = self.extraButtons;
    
}

- (IBAction)performCancel:(id)sender {
    
    
    self.accountNameTextField.enabled =
    self.accountEmailTextField.enabled =
    self.accountPsswdTextField.enabled =
    self.accountBdayTextField.enabled =
    self.accountGenderTextField.enabled =
    self.accountCityTextField.enabled =
    self.accountStateTextField.enabled =
    self.accountCountryTextField.enabled = NO;
    
    [self.cancelBarButtonItem setEnabled:NO];
    [self.cancelBarButtonItem setTintColor:[UIColor clearColor]];
    
    //The button was touched
    NSLog(@"Cancel Touched: %@",self.cancelBarButtonItem);
    
    //Disable Save Button
    [self.saveButton setEnabled:NO];
    [self.saveButton setTintColor:[UIColor clearColor]];
    
    //Enable EditButton
    self.editBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Editar" style:UIBarButtonItemStylePlain target:self action:@selector(performEditing:)];
    
    //Store in an Array
    self.extraButtons = @[self.editBarButtonItem];
    
    //Place into navigation Bar
    self.navigationItem.rightBarButtonItems = self.extraButtons;
    
    NSLog(@"ButtonsArray %@",self.extraButtons);
    

    
}

- (void)saveEditions{
    
    NSLog(@"Save Touched: %@",self.saveButton);
    
    
    if ([self.accountNameTextField.text length]||
               [self.accountEmailTextField.text length]||
               [self.accountPsswdTextField.text length]||
               [self.accountBdayTextField.text length]||
               [self.accountGenderTextField.text length]||
               [self.accountCityTextField.text length]||
               [self.accountStateTextField.text length]||
               [self.accountCountryTextField.text length] == 0){
        
        //If any field is empty
        UIAlertView *emptyAlert = [[UIAlertView alloc]initWithTitle:@"Alerta:"
                                                            message:@"Confira seus dados e tente novamente!"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
        
        [emptyAlert show];

    
    } else  {
        
        
        UIAlertView *savedAlert = [[UIAlertView alloc]initWithTitle:@"Sucesso:"
                                                            message:@"Seus dados foram salvos!"
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
        
        [savedAlert show];
        
        
    }

    
   
    
    
}


@end






















