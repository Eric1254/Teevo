//
//  PointsViewController.h
//  Teevo
//
//  Created by Dhanesh Kumar on 16/10/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PleaseWait;
@interface PointsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableview;
@property (weak, nonatomic) IBOutlet UILabel *headerCount;
@property (weak, nonatomic) IBOutlet UILabel *headerText;

@property(nonatomic,strong)NSNumber *monthNumber;
@property(nonatomic,strong)PleaseWait *pleasewait;
@property(nonatomic,strong)NSArray *pointsDataArr;
@property(strong,nonatomic)NSString* totalPoints;
@end
