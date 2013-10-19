//
//  ITestifyViewController.m
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import "ITestifyViewController.h"

@interface ITestifyViewController ()

@end

@implementation ITestifyViewController

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

- (IBAction)btnBackFromITestifyAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnMenuITestifyAction:(id)sender {
}

- (IBAction)btnUploadAction:(id)sender {
}

- (IBAction)btnSubmitAction:(id)sender {
}

- (IBAction)btnViewTestimonyAction:(id)sender {
    
    [self.viewTestinomy setHidden:NO];
    [self.viewPostTestimony setHidden:YES];
}


- (IBAction)btnPostAction:(id)sender {
    
    [self.viewTestinomy setHidden:YES];
    [self.viewPostTestimony setHidden:NO];
}
@end
