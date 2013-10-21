//
//  RegisterViewController.m
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import "RegisterViewController.h"
#import "STHTTPRequest.h"
#import "TeevoCommon.h"
#import "JSONKit.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
@synthesize registrationDictionary;
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

- (IBAction)btnCancelRegistrationAction:(id)sender {
    
    [self getTodaysQuizFromServer];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)textFieldDidEndOnExit:(UITextField *)sender
{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 20,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    [self.view endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	
	[UIView beginAnimations:@"Animate Text Field Up" context:nil];
	[UIView setAnimationDuration:.3];
	[UIView setAnimationBeginsFromCurrentState:YES];
    
    if (textField.tag == 4) {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     -30	,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    if (textField.tag == 5) {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     -60	,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    if (textField.tag == 6) {
        self.view.frame = CGRectMake(self.view.frame.origin.x,
                                     -90	,
                                     self.view.frame.size.width,
                                     self.view.frame.size.height);
    }
    
    
	
    
	[UIView commitAnimations];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 20,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
    
    [textField resignFirstResponder];
    return NO;
}

- (void) getTodaysQuizFromServer
{
    [self AddLoading];
    
    NSString *urlAsString = SERVER_URL;
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:60.0f];
    [urlRequest setHTTPMethod:@"POST"];
    
    
    NSString *body =  @"functionName=storeUser&json={\"firstname\" :\"jeeten\" , \"lastname\" :\"singh\" ,\"email\" :\"jeet@taa.com\",\"password\":\"123456\",\"mobile\":\"1234567891\"\"addressline1\":\"41 sachivalaya nagar A\" }";
//    NSString *srtEmail = @"shumyla.shaikh@gmail.com";
//    NSString *srtPass = @"test";
//    NSString *strBody =[NSString stringWithFormat:@"functionName=login&json={\"email\":\"%@\",\"password\":\"%@\"}",self.txtFldUserName.text,self.txtFldPassword.text];
//    NSLog(@"strBody = %@",strBody);
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *jsonData, NSError *error)
     {
         if ([jsonData length] >0 && error == nil)
         {
             JSONDecoder* decoder = [[JSONDecoder alloc]
                                     initWithParseOptions:JKParseOptionNone];
             id json = [decoder objectWithData:jsonData];
             
             
             
             self.registrationDictionary = [[NSDictionary alloc] initWithDictionary:json];
             
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
    
    
    NSDictionary *statusDict = [self.registrationDictionary objectForKey:@"status"];
    self.strStatus= [statusDict objectForKey:@"status_msg"];
    NSLog(@"statusMesg = %@",self.strStatus);
    [self removeLoading];
    
//    if ([self.strStatus  isEqualToString:@"Successfull Login."]) {
//        [self performSegueWithIdentifier:@"Login" sender:self.btnLogin];
//    }
//    else
//        NSLog(@"sorry");
    
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


@end
