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
#import "JSONKit.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginDictionary;
@synthesize strStatus;
@synthesize pleasewait;

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
    [self.txtFldPassword resignFirstResponder];
    [self.txtFldUserName resignFirstResponder];
    self.txtFldUserName.frame = CGRectMake(self.txtFldUserName.frame.origin.x,
                                           200	,
                                           self.txtFldUserName.frame.size.width,
                                           self.txtFldUserName.frame.size.height);
    self.txtFldPassword.frame = CGRectMake(self.txtFldPassword.frame.origin.x,
                                           235	,
                                           self.txtFldPassword.frame.size.width,
                                           self.txtFldPassword.frame.size.height);
}
- (IBAction)btnLoginAction:(id)sender {
    
    NSLog(@"btnLoginAction =%@",[self.txtFldUserName text]);
        [self getTodaysQuizFromServer];
//    if ([[self.txtFldUserName text] isEqualToString:@"gaurav"]) {
//            [self performSegueWithIdentifier:@"Login" sender:sender];
//    }
    
//
//    if ([self.strStatus  isEqualToString:@"Successfull Login."]) {
//        [self performSegueWithIdentifier:@"Login" sender:sender];
//    }
//    else
//        NSLog(@"sorry");
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

- (void) getTodaysQuizFromServer
{
    [self AddLoading];

    NSString *urlAsString = SERVER_URL;
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:60.0f];
    [urlRequest setHTTPMethod:@"POST"];
    

    NSString *body =  @"functionName=login&json={\"email\":\"shumyla.shaikh@gmail.com\",\"password\":\"test\"}";
    NSString *srtEmail = @"shumyla.shaikh@gmail.com";
    NSString *srtPass = @"test";
     NSString *strBody =[NSString stringWithFormat:@"functionName=login&json={\"email\":\"%@\",\"password\":\"%@\"}",self.txtFldUserName.text,self.txtFldPassword.text];
                         NSLog(@"strBody = %@",strBody);
    [urlRequest setHTTPBody:[strBody dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *jsonData, NSError *error)
     {
         if ([jsonData length] >0 && error == nil)
         {
             JSONDecoder* decoder = [[JSONDecoder alloc]
                                     initWithParseOptions:JKParseOptionNone];
             id json = [decoder objectWithData:jsonData];
             

             
             self.loginDictionary = [[NSDictionary alloc] initWithDictionary:json];
             
             if (json != nil && error == nil)
             {
                 NSLog(@"Successfully deserialized... json = %@",json);
                 [self addDataToEbook];
             }
             else if (error != nil)
             {
                 NSLog(@"An error happened while deserializing the JSON data.");
             }
         }
         else if ([jsonData length] == 0 && error == nil)
         {
             NSLog(@"Nothing was downloaded.");
         }
         else if (error != nil)
         {
             NSLog(@"Error happened = %@", error);
             // d_SHOWALERT(@"TEEVO", [error description]);
             [self performSelectorOnMainThread:@selector(showAlert:) withObject:[error description] waitUntilDone:YES];
         }
         
     }];
    //[self addDataToEbook];
}

-(void)addDataToEbook{
    
   
    NSDictionary *statusDict = [self.loginDictionary objectForKey:@"status"];
    self.strStatus= [statusDict objectForKey:@"status_msg"];
    NSLog(@"statusMesg = %@",self.strStatus);
    [self removeLoading];
    
    if ([self.strStatus  isEqualToString:@"Successfull Login."]) {
        [self performSegueWithIdentifier:@"Login" sender:self.btnLogin];
    }
    else
        NSLog(@"sorry");
   
}

-(void)AddLoading
{
    if(pleasewait){
        [pleasewait.view removeFromSuperview];
        
        pleasewait = nil;
    }
    
    NSString *controllerName = nil;
    
    if (iPad) {
        controllerName = @"PleaseWait";
    }else{
        controllerName = @"PleaseWait_iPhone";
    }
    
    pleasewait = [[PleaseWait alloc] initWithNibName:controllerName bundle:nil];
    
    [self.view addSubview:pleasewait.view];
}


-(void)removeLoading
{
    if(pleasewait){
        [pleasewait.view removeFromSuperview];
        
        pleasewait = nil;
    }
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	
	[UIView beginAnimations:@"Animate Text Field Up" context:nil];
	[UIView setAnimationDuration:.3];
	[UIView setAnimationBeginsFromCurrentState:YES];
    
    self.txtFldUserName.frame = CGRectMake(self.txtFldUserName.frame.origin.x,
                                           165	,
                                           self.txtFldUserName.frame.size.width,
                                           self.txtFldUserName.frame.size.height);
	self.txtFldPassword.frame = CGRectMake(self.txtFldPassword.frame.origin.x,
                                        200	,
                                        self.txtFldPassword.frame.size.width,
                                        self.txtFldPassword.frame.size.height);
    
	[UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [UIView beginAnimations:@"Animate Text Field Up" context:nil];
	[UIView setAnimationDuration:.3];
	[UIView setAnimationBeginsFromCurrentState:YES];
    
    self.txtFldUserName.frame = CGRectMake(self.txtFldUserName.frame.origin.x,
                                           200	,
                                           self.txtFldUserName.frame.size.width,
                                           self.txtFldUserName.frame.size.height);
    self.txtFldPassword.frame = CGRectMake(self.txtFldPassword.frame.origin.x,
                                           235	,
                                           self.txtFldPassword.frame.size.width,
                                           self.txtFldPassword.frame.size.height);
    [textField resignFirstResponder];
    [UIView commitAnimations];
    return NO;
}

@end
