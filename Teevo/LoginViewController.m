//
//  LoginViewController.m
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "STHTTPRequest.h"
#import "TeevoCommon.h"

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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}
- (IBAction)btnLoginAction:(id)sender {
    
    NSLog(@"btnLoginAction =%@",[self.txtFldUserName text]);
        
    if ([[self.txtFldUserName text] isEqualToString:@"gaurav"]) {
            [self performSegueWithIdentifier:@"Login" sender:sender];
    }
    else
        NSLog(@"sorry");
}
- (IBAction)btnRegisterAction:(id)sender {
    
    NSLog(@"btnRegisterAction");
}

- (IBAction)btnForgetPassAction:(id)sender {
    NSLog(@"btnForgetPassAction");
}

- (IBAction)btnConnectFacebok:(id)sender {
    NSLog(@"btnConnectFacebok");
}

- (IBAction)btnYookosAction:(id)sender {
    NSLog(@"btnYookosAction");
}

- (IBAction)btnSkipAction:(id)sender {
    NSLog(@"btnSkipAction");
    [self performSegueWithIdentifier:@"Skip" sender:sender];
}


@end
