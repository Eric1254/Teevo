//
//  TReaderViewController.m
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

// test comit // test again

#import "TReaderViewController.h"

@interface TReaderViewController ()

@end

@implementation TReaderViewController

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

- (IBAction)btnBackFromTReaderAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnMenuTReaderAction:(id)sender {
}

- (IBAction)btnEBookAction:(id)sender {
}

- (IBAction)btnEcomicsAction:(id)sender {
}

- (IBAction)btnEdevotionalAction:(id)sender {
}

- (IBAction)btnDownloadsAction:(id)sender {
}
@end
