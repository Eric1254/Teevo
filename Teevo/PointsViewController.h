//
//  PointsViewController.h
//  Teevo
//
//  Created by Dhanesh Kumar on 16/10/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (weak, nonatomic) IBOutlet UILabel *headerCount;
@property (weak, nonatomic) IBOutlet UILabel *headerText;

@end
