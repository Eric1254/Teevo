//
//  TReaderCell.h
//  Teevo
//
//  Created by MacBook on 19/10/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  TReaderCellDelegate<NSObject>

- (void)btnBookPressed:(id)sender;
- (void)btnViewAllAction:(id)sender;
@end

@interface TReaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblCategory;
@property (weak, nonatomic) IBOutlet UIButton *btnFirstBook;
@property (weak, nonatomic) IBOutlet UIButton *btnSecondBook;
@property (weak, nonatomic) IBOutlet UIButton *btnThirdBook;
@property (weak, nonatomic) IBOutlet UIButton *btnFourthBook;
- (IBAction)btnBookPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblFirstBook;
@property (weak, nonatomic) IBOutlet UILabel *lblSecondBook;
@property (weak, nonatomic) IBOutlet UILabel *lblThirdBook;
@property (weak, nonatomic) IBOutlet UILabel *lblFourthBook;
@property (weak, nonatomic) IBOutlet UIButton *btnViewAll;
- (IBAction)btnViewAllAction:(id)sender;


@property (strong, nonatomic) id<TReaderCellDelegate> cellDelegate;
@end
