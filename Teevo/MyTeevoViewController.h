//
//  MyTeevoViewController.h
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTeevoViewController : UIViewController
- (IBAction)btnBackFromMyTeevoAction:(id)sender;
- (IBAction)btnMenuMyTeevoAction:(id)sender;
@property(assign)int imageCount;
@property(nonatomic,strong)NSData*mydata;
@property(nonatomic,strong)UIImageView *bookScreens;
@end
