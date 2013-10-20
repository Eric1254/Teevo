//
//  TReaderViewController.m
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

// test comit // test again //change

#import "TReaderViewController.h"
#import "EbookObject.h"
#import "TeevoCommon.h"
#import "STHTTPRequest.h"
#import "JSONKit.h"


@interface TReaderViewController ()

@end

@implementation TReaderViewController
@synthesize arrForEBook;
@synthesize arrForEComics;
@synthesize arrDevotional;
@synthesize forSection;
@synthesize sourceDictionary;


static NSString * const kCellReuseIdentifier = @"collectionViewCell";


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
    self.forSection = 0;
    
    
    
    
    
    EbookObject *objEBook1 = [[EbookObject alloc]init];
    objEBook1.txtFirstBookImg = @"video_category_1.png";
    objEBook1.txtFirstBookName = @"First Book1";
    objEBook1.txtFirstBookType = @"First Category1";
    
    objEBook1.txtSecondBookImg = @"video_category_2.png";
    objEBook1.txtSecondBookName = @"Second Book1";
    objEBook1.txtSecondBookType = @"Second Category1";
    
    objEBook1.txtThirdBookImg = @"video_category_3.png";
    objEBook1.txtThirdBookName = @"Third book1";
    objEBook1.txtThirdBookType = @"Third Category1";
    
    objEBook1.txtFourthBookImg = @"video_category_4.png";
    objEBook1.txtFourthBookName = @"Fourth Book1";
    objEBook1.txtFourthBookType = @"Fourth Category1";
    
    EbookObject *objEBook2 = [[EbookObject alloc]init];
    objEBook2.txtFirstBookImg = @"video_category_5.png";
    objEBook2.txtFirstBookName = @"First Book2";
    objEBook2.txtFirstBookType = @"First Category2";
    
    objEBook2.txtSecondBookImg = @"video_category_6.png";
    objEBook2.txtSecondBookName = @"Second Book2";
    objEBook2.txtSecondBookType = @"Second Category2";
    
    objEBook2.txtThirdBookImg = @"video_category_7.png";
    objEBook2.txtThirdBookName = @"Third book2";
    objEBook2.txtThirdBookType = @"Third Category2";
    
    objEBook2.txtFourthBookImg = @"video_category_8.png";
    objEBook2.txtFourthBookName = @"Fourth Book2";
    objEBook2.txtFourthBookType = @"Fourth Category2";
    
    EbookObject *objEBook3 = [[EbookObject alloc]init];
    objEBook3.txtFirstBookImg = @"video_category_1.png";
    objEBook3.txtFirstBookName = @"First Book3";
    objEBook3.txtFirstBookType = @"First Category3";
    
    objEBook3.txtSecondBookImg = @"video_category_2.png";
    objEBook3.txtSecondBookName = @"Second Book3";
    objEBook3.txtSecondBookType = @"Second Category3";
    
    objEBook3.txtThirdBookImg = @"video_category_3.png";
    objEBook3.txtThirdBookName = @"Third book3";
    objEBook3.txtThirdBookType = @"Third Category3";
    
    objEBook3.txtFourthBookImg = @"video_category_4.png";
    objEBook3.txtFourthBookName = @"Fourth Book3";
    objEBook3.txtFourthBookType = @"Fourth Category3";
    
    
    
    self.arrForEBook = [[NSMutableArray alloc] initWithObjects: objEBook1, objEBook2, objEBook3,nil];
    self.arrForEComics = [[NSMutableArray alloc] initWithObjects: objEBook1, objEBook2,nil];
    self.arrDevotional = [[NSMutableArray alloc] initWithObjects: objEBook1, objEBook2, objEBook3,nil];
    
     [self.collectionAllBook registerNib:[UINib nibWithNibName:@"AllBookCollection" bundle:nil] forCellWithReuseIdentifier:kCellReuseIdentifier];
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setItemSize:CGSizeMake(100, 100)];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    [self.collectionAllBook setCollectionViewLayout:flowLayout];
//    [self.collectionAllBook setCollectionViewLayout:flowLayout];
    [self.collectionAllBook setAllowsSelection:YES];
    [self getTodaysQuizFromServer];
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
    
    self.forSection = 0;
    [self.tblViewReader reloadData];
}

- (IBAction)btnEcomicsAction:(id)sender {
    self.forSection = 1;
    [self.tblViewReader reloadData];
}

- (IBAction)btnEdevotionalAction:(id)sender {
    self.forSection = 2;
    [self.tblViewReader reloadData];
}

- (IBAction)btnDownloadsAction:(id)sender {
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 154;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    int retVal = 0;
    if (self.forSection == 0) {
        retVal = self.arrForEBook.count;
    }
    else if(self.forSection == 1)
        retVal = self.arrForEComics.count;
    else if(self.forSection == 2)
        retVal = self.arrDevotional.count;
    return retVal;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"TReaderCell";
    TReaderCell *cell = (TReaderCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TReaderCell" owner:self options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (TReaderCell *)currentObject;
                break;
            }
        }
    }
    
    // Configure the cell.
    EbookObject *objEBook;
    if (self.forSection == 0) {

        objEBook = [self.arrForEBook objectAtIndex:indexPath.row];
        /*
        cell.cellDelegate = self;
        cell.lblFirstBook.text = objEBook.txtFirstBookName;
        cell.lblSecondBook.text = objEBook.txtSecondBookName;
        cell.lblThirdBook.text = objEBook.txtThirdBookName;
        cell.lblFourthBook.text = objEBook.txtFourthBookName;
        
        [cell.btnFirstBook setImage:[UIImage imageNamed:objEBook.txtFirstBookImg] forState:UIControlStateNormal];
        [cell.btnSecondBook setImage:[UIImage imageNamed:objEBook.txtSecondBookImg] forState:UIControlStateNormal];
        [cell.btnThirdBook setImage:[UIImage imageNamed:objEBook.txtThirdBookImg] forState:UIControlStateNormal];
        [cell.btnFourthBook setImage:[UIImage imageNamed:objEBook.txtFourthBookImg] forState:UIControlStateNormal];
        cell.btnViewAll.tag = indexPath.row;
        cell.btnFirstBook.titleLabel.tag = indexPath.row;
         */
    }
    else if(self.forSection == 1){
        objEBook = [self.arrForEComics objectAtIndex:indexPath.row];
        /*
        cell.cellDelegate = self;
        cell.lblFirstBook.text = objEBook.txtFirstBookName;
        cell.lblSecondBook.text = objEBook.txtSecondBookName;
        cell.lblThirdBook.text = objEBook.txtThirdBookName;
        cell.lblFourthBook.text = objEBook.txtFourthBookName;
        
        [cell.btnFirstBook setImage:[UIImage imageNamed:objEBook.txtFirstBookImg] forState:UIControlStateNormal];
        [cell.btnSecondBook setImage:[UIImage imageNamed:objEBook.txtSecondBookImg] forState:UIControlStateNormal];
        [cell.btnThirdBook setImage:[UIImage imageNamed:objEBook.txtThirdBookImg] forState:UIControlStateNormal];
        [cell.btnFourthBook setImage:[UIImage imageNamed:objEBook.txtFourthBookImg] forState:UIControlStateNormal];
        cell.btnViewAll.tag = indexPath.row;
        cell.btnFirstBook.titleLabel.tag = indexPath.row;
         */
    }
    else if(self.forSection == 2){
        objEBook = [self.arrDevotional objectAtIndex:indexPath.row];
        /*
        cell.cellDelegate = self;
        cell.lblFirstBook.text = objEBook.txtFirstBookName;
        cell.lblSecondBook.text = objEBook.txtSecondBookName;
        cell.lblThirdBook.text = objEBook.txtThirdBookName;
        cell.lblFourthBook.text = objEBook.txtFourthBookName;
        
        [cell.btnFirstBook setImage:[UIImage imageNamed:objEBook.txtFirstBookImg] forState:UIControlStateNormal];
        [cell.btnSecondBook setImage:[UIImage imageNamed:objEBook.txtSecondBookImg] forState:UIControlStateNormal];
        [cell.btnThirdBook setImage:[UIImage imageNamed:objEBook.txtThirdBookImg] forState:UIControlStateNormal];
        [cell.btnFourthBook setImage:[UIImage imageNamed:objEBook.txtFourthBookImg] forState:UIControlStateNormal];
        cell.btnViewAll.tag = indexPath.row;
        cell.btnFirstBook.titleLabel.tag = indexPath.row;
         */
    }

    cell.cellDelegate = self;
    cell.lblFirstBook.text = objEBook.txtFirstBookName;
    cell.lblSecondBook.text = objEBook.txtSecondBookName;
    cell.lblThirdBook.text = objEBook.txtThirdBookName;
    cell.lblFourthBook.text = objEBook.txtFourthBookName;
    
    [cell.btnFirstBook setImage:[UIImage imageNamed:objEBook.txtFirstBookImg] forState:UIControlStateNormal];
    [cell.btnSecondBook setImage:[UIImage imageNamed:objEBook.txtSecondBookImg] forState:UIControlStateNormal];
    [cell.btnThirdBook setImage:[UIImage imageNamed:objEBook.txtThirdBookImg] forState:UIControlStateNormal];
    [cell.btnFourthBook setImage:[UIImage imageNamed:objEBook.txtFourthBookImg] forState:UIControlStateNormal];
    cell.btnViewAll.tag = indexPath.row;
    cell.btnFirstBook.titleLabel.tag = indexPath.row;
    return cell;
    
}

- (void)btnBookPressed:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    switch (btn.tag) {
        case 11:
            NSLog(@"First button pressed = %d",btn.titleLabel.tag);
            [self.viewDetailBook setHidden:NO];
            break;
        case 12:
            NSLog(@"Second button pressed ");
            break;
        case 13:
            NSLog(@"Third button pressed ");
            break;
        case 14:
            NSLog(@"Fourt button pressed ");
            break;
            
        default:
            break;
    }
}


- (void)btnViewAllAction:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    NSLog(@"view all button for row = %d",btn.tag);
    [self.viewForAll setHidden:NO];
}


- (IBAction)btnActionDetailDownload:(id)sender {
}

- (IBAction)btnBackFromDetail:(id)sender {
    [self.viewDetailBook setHidden:YES];
}
- (IBAction)btnActionBackFromAllView:(id)sender {
    
    [self.viewForAll setHidden:YES];
}


#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
//    NSString *searchTerm = self.searches[section];
    return 20;
}

//- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
//    return 10;
//}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   

    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected View index=%d",indexPath.row);
}
// 4
/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section;
{
    return UIEdgeInsetsMake(10, 10, 0, 10);
}


- (void) getTodaysQuizFromServer
{
    NSString *urlAsString = SERVER_URL;
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:60.0f];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body =  @"functionName=get_treader&json={\"catid\":\"1\"}";//[NSString stringWithFormat:@"functionName=get_treader&json=",FUNC_TREADER_EBOOK,@""];
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *jsonData, NSError *error)
     {
         if ([jsonData length] >0 && error == nil)
         {
             JSONDecoder* decoder = [[JSONDecoder alloc]
                                     initWithParseOptions:JKParseOptionNone];
             id json = [decoder objectWithData:jsonData];
             
             NSLog(@"Got Data: %@ ",json);
             self.sourceDictionary = [[NSDictionary alloc] initWithDictionary:json];
             if (json != nil && error == nil)
             {
                 NSLog(@"Successfully deserialized... json = %@",json);
                 

                 // self.QuizString = @"ArchiveQuiz";

                 
                 //                 if ([self.QuizString isEqualToString:@"TodayQuiz"]) {
                 //
                 //                 }else if ([self.QuizString isEqualToString:@"ArchiveQuiz"]){
                 //
                 //                 }else{
                 //
                 //                 }
                 
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
    //[self addViewToTodaysQuiz];
}




@end
