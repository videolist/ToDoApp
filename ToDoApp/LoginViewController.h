//
//  LoginViewController.h
//  ToDoApp
//
//  Created by Vadim on 7/21/13.
//  Copyright (c) 2013 Vadim. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate, UIAlertViewDelegate> {
    
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)loginAction:(id)sender;
- (IBAction)registerAction:(id)sender;

@end
