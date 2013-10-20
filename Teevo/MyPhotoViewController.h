//
//  MyPhotoViewController.h
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPhotoViewController : UIViewController
- (IBAction)btnBackFromMyPhotoAction:(id)sender;
- (IBAction)btnMenuMyPhotoAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollPhoto;
@property (weak, nonatomic) IBOutlet UITextView *txtViewMyPhoto;
@property (weak, nonatomic) IBOutlet UIButton *btnAccept;
- (IBAction)btnAcceptAction:(id)sender;

- (IBAction)btnUploadMyPhotoAction:(id)sender;
- (IBAction)btnSubmitMyPhotoAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnUploadMyPhoto;

@property (weak, nonatomic) IBOutlet UIButton *btnSubmitMyPhoto;


@end
