//
//  TReaderViewController.h
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TReaderCell.h"

@interface TReaderViewController : UIViewController<TReaderCellDelegate,UICollectionViewDelegateFlowLayout>
- (IBAction)btnBackFromTReaderAction:(id)sender;
- (IBAction)btnMenuTReaderAction:(id)sender;
- (IBAction)btnEBookAction:(id)sender;
- (IBAction)btnEcomicsAction:(id)sender;
- (IBAction)btnEdevotionalAction:(id)sender;
- (IBAction)btnDownloadsAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblViewReader;
@property (nonatomic,strong) NSMutableArray *arrForEBook;
@property (nonatomic,strong) NSMutableArray *arrForEComics;
@property (nonatomic,strong) NSMutableArray *arrDevotional;
@property (weak, nonatomic) IBOutlet UIView *viewDetailBook;
@property (weak, nonatomic) IBOutlet UIImageView *imgDetailBook;
@property (weak, nonatomic) IBOutlet UILabel *lblDetailNameBook;
@property (weak, nonatomic) IBOutlet UILabel *lblDetailAuthorName;
@property (weak, nonatomic) IBOutlet UILabel *lblDetailPublishedBy;
@property (weak, nonatomic) IBOutlet UILabel *lblDetailsNoPages;
@property (weak, nonatomic) IBOutlet UILabel *lblDetailBookSize;
@property (weak, nonatomic) IBOutlet UIButton *btnDetailDownload;
@property (weak, nonatomic) IBOutlet UITextView *txtViewDetailDescription;
@property (weak, nonatomic) IBOutlet UIView *viewForAll;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionAllBook;
@property int forSection;
@property (strong, nonatomic) NSDictionary *sourceDictionary;


- (IBAction)btnActionBackFromAllView:(id)sender;
- (IBAction)btnActionDetailDownload:(id)sender;
- (IBAction)btnBackFromDetail:(id)sender;




@end
