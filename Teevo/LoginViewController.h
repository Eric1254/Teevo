//
//  LoginViewController.h
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtFldUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldPassword;

- (IBAction)btnLoginAction:(id)sender;
- (IBAction)btnRegisterAction:(id)sender;
- (IBAction)btnForgetPassAction:(id)sender;
- (IBAction)btnConnectFacebok:(id)sender;
- (IBAction)btnYookosAction:(id)sender;
- (IBAction)btnSkipAction:(id)sender;

@end
