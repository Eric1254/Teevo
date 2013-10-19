//
//  ITestifyViewController.h
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ITestifyViewController : UIViewController
- (IBAction)btnBackFromITestifyAction:(id)sender;
- (IBAction)btnMenuITestifyAction:(id)sender;
- (IBAction)btnViewTestimonyAction:(id)sender;
- (IBAction)btnUploadAction:(id)sender;
- (IBAction)btnSubmitAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewPostTestimony;
- (IBAction)btnPostAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewTestinomy;

@end
