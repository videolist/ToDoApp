//
//  LoginViewController.m
//  ToDoApp
//
//  Created by Vadim on 7/21/13.
//  Copyright (c) 2013 Vadim. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ( textField.text == nil || [textField.text isEqualToString:@""] ) {
        return YES;
    }
    else {
        [textField resignFirstResponder];
        return NO;
    }
}


- (IBAction)loginAction:(id)sender {
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [User loginWithUserName:self.userNameTextField.text andPassword:self.passwordTextField.text withCompletionBlock:^(bool Success) {
        if ( Success ) {
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Login Error" message:@"Did you forget to register?" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

- (IBAction)registerAction:(id)sender {
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [User createNewUserWithName:self.userNameTextField.text andPassword:self.passwordTextField.text withCompletionBlock:^(bool Success) {
        if ( Success ) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"New user has been created" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alert.delegate = self;
            [alert show];
        } else {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Registration Error" message:@"Couldn't create a new user" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
