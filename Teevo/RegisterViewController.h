//
//  RegisterViewController.h
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PleaseWait.h"


@interface RegisterViewController : UIViewController
- (IBAction)btnCancelRegistrationAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtFldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldLastName;

@property (weak, nonatomic) IBOutlet UITextField *txtFldPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtFldConfirmPassword;

@property (weak, nonatomic) IBOutlet UITextField *txtFldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFldMobile;
@property (weak, nonatomic) IBOutlet UITextField *txtFldAddress;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
-(IBAction)textFieldDidEndOnExit:(UITextField *)sender;

@property (strong, nonatomic) NSString *strStatus;
@property(nonatomic,strong)PleaseWait *pleasewait;
@property (strong, nonatomic) NSDictionary *registrationDictionary;





@end
