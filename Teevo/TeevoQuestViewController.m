//
//  TeevoQuestViewController.m
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import "TeevoQuestViewController.h"
#import "STHTTPRequest.h"
#import "TeevoCommon.h"
#import "JSONKit.h"
#import "QuizView.h"
#import "DropDownView.h"
#import "SubmitViewController.h"
#import "ActionSheetDatePicker.h"
#import "ActionSheetStringPicker.h"
#import "PointsViewController.h"
#import "PleaseWait.h"
#import "AppDelegate.h"
@interface TeevoQuestViewController ()

@end

@implementation TeevoQuestViewController
@synthesize pleasewait;
#pragma mark -
#pragma mark showAlert

-(void)showAlert:(id)message{
    //    if (![self.responseMsg isEqualToString:@""]) {
    //        message = self.responseMsg;
    //    }
    NSLog(@"showAlert:%@",message);
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"TEEVO" message:message
                                                 delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    
    
}
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
    
    self.monthArr = [[NSMutableArray alloc] init];
    [self.monthArr addObject:@"01"];
    [self.monthArr addObject:@"02"];
    [self.monthArr addObject:@"03"];
    [self.monthArr addObject:@"04"];
    [self.monthArr addObject:@"05"];
    [self.monthArr addObject:@"06"];
    [self.monthArr addObject:@"07"];
    [self.monthArr addObject:@"08"];
    [self.monthArr addObject:@"09"];
    [self.monthArr addObject:@"10"];
    [self.monthArr addObject:@"11"];
    [self.monthArr addObject:@"12"];
    
    self.monthNameArr = [[NSMutableArray alloc] init];
    [self.monthNameArr addObject:@"January"];
    [self.monthNameArr addObject:@"Febraury"];
    [self.monthNameArr addObject:@"March"];
    [self.monthNameArr addObject:@"April"];
    [self.monthNameArr addObject:@"May"];
    [self.monthNameArr addObject:@"June"];
    [self.monthNameArr addObject:@"July"];
    [self.monthNameArr addObject:@"August"];
    [self.monthNameArr addObject:@"September"];
    [self.monthNameArr addObject:@"October"];
    [self.monthNameArr addObject:@"November"];
    [self.monthNameArr addObject:@"December"];
    
    
    _view1= [[UIView alloc] initWithFrame:CGRectMake(0, 400, 320, 60)];
    _view1.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:_view1];
    [self.view bringSubviewToFront:_view1];
    
    UILabel * lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, 200, 50)];
    lbl.numberOfLines=2;
    [lbl setBackgroundColor:[UIColor clearColor]];
    lbl.text =@"If you have Answer of All Question Hit The submit button";
    [_view1 addSubview:lbl];
    [lbl setFont:[UIFont systemFontOfSize:14]];
    UIButton * submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitBtn.frame = CGRectMake(230 ,10, 60, 40);
    [submitBtn addTarget:self
                    action:@selector(submitBtn:)
          forControlEvents:UIControlEventTouchDown];
    //[button setTitle:@"C" forState:UIControlStateNormal];
    [submitBtn setImage:[UIImage imageNamed:@"submit_btn.png"] forState:UIControlStateNormal];
    
    
    [_view1 addSubview:submitBtn];
    
    
	// Do any additional setup after loading the view.
}

-(void)AddLoading
{
    if(pleasewait){
        [pleasewait.view removeFromSuperview];
        
        pleasewait = nil;
    }
    
    NSString *controllerName = nil;
    
    if (iPad) {
        controllerName = @"PleaseWait";
    }else{
        controllerName = @"PleaseWait_iPhone";
    }
    
    pleasewait = [[PleaseWait alloc] initWithNibName:controllerName bundle:nil];
    
    [self.view addSubview:pleasewait.view];
}


-(void)removeLoading
{
    if(pleasewait){
        [pleasewait.view removeFromSuperview];
        
        pleasewait = nil;
    }
    
    
}


-(void)viewWillAppear:(BOOL)animated{
    self.answercount = 0;
    self.submitArr = nil;
    self.submitArr = [NSMutableArray array];
    self.SelectionArr = [[NSMutableArray alloc] init];
    self.selectedIndexArr = [[NSMutableArray alloc] init];
    [self AddLoading];
    [self getTodaysQuizFromServer];
    [self getPointsData];
    
    self.PickerView.hidden = YES;
    self.myTableView.frame = CGRectMake(0, 100, self.myTableView.frame.size.height, self.myTableView.frame.size.height+40);
    
    
    
}
-(void)submitBtn:(id)sender{
    NSLog(@"lll");
    if ([self.QuizString isEqualToString:@"PointsQuiz"]) {
        
    }else if([self.QuizString isEqualToString:@"TodayQuiz"]){
       [self updateTodayQuizWithAnswer];
    }else{
        [self updateArchiveQuizWithAnswer];
    }
    //self.QuizString = @"TodayQuiz";
    //self.QuizString = @"ArchiveQuiz";
    if (self.SelectionArr.count>0 || self.selectedIndexArr.count>0) {
        UIStoryboard * storyboard = self.storyboard;
        
        SubmitViewController * detail = [storyboard instantiateViewControllerWithIdentifier: @ "SubmitViewController"];
        detail.rightAnswer = self.SelectionArr;
        detail.questionArr = self.selectedIndexArr;
        detail.sourceDictionary = self.sourceDictionary;
        detail.submitArr = self.submitArr;
        detail.answercount = self.answercount;
        detail.QuizString = self.QuizString;
        [self.navigationController pushViewController: detail animated: YES];
    }else{
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Teevo" message:@"Please Answer The Question" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alert show];
    }
}

-(void)updateArchiveQuizWithAnswer{
    NSMutableDictionary * mdic = [[NSMutableDictionary alloc] init];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //appDelegate.strUserId =
    //[mdic setObject:@"3" forKey:@"userid"];

    [mdic setObject:appDelegate.strUserId forKey:@"userid"];
    [mdic setObject:[NSString stringWithFormat:@"%d",[self.todayQuizID intValue] ] forKey:@"quizid"];
    NSString * points = [NSString stringWithFormat:@"%d",self.selectedIndexArr.count];
    [mdic setObject:points forKey:@"points"];
    [mdic setObject:@"1" forKey:@"isarcheive"];
    //[mdic setObject:self.yearsLbl.text forKey:@"year"];
    NSDictionary* info = [NSDictionary dictionaryWithDictionary:mdic];
    
    NSString *jsonStr = [info JSONString];
    
    NSString *urlAsString = SERVER_URL;
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:60.0f];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body = [NSString stringWithFormat:@"functionName=%@&json=%@}",FUNC_ADDPOINTS,jsonStr];
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *jsonData, NSError *error)
     {
         if ([jsonData length] >0 && error == nil)
         {
             JSONDecoder* decoder = [[JSONDecoder alloc]
                                     initWithParseOptions:JKParseOptionNone];
             id json = [decoder objectWithData:jsonData];
             self.sourceDictionary = [[NSDictionary alloc] initWithDictionary:json];
             
             NSLog(@"Got Data: %@ ",json);
             
             if ([json isKindOfClass:[NSDictionary class]]) {
                 NSDictionary * dicOne = (NSDictionary*)json;
                 
                 NSDictionary * dic= [dicOne objectForKey:@"status"];
                 
                 if ([[dic objectForKey:@"status_id"] integerValue]==0) {
                     
                     UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"TEEVO" message:@"No Record Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                     
                     [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES
                      ];
                     
                 }
                 
             }
             
             if (json != nil && error == nil)
             {
                 NSLog(@"Successfully deserialized...");
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
         }
     }];
    //[self addViewToArchieves];
}

-(void)updateTodayQuizWithAnswer{
    NSMutableDictionary * mdic = [[NSMutableDictionary alloc] init];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //appDelegate.strUserId =
    //[mdic setObject:@"3" forKey:@"userid"];
    
    [mdic setObject:appDelegate.strUserId forKey:@"userid"];
    //[mdic setObject:@"3" forKey:@"userid"];
    [mdic setObject:[NSString stringWithFormat:@"%d",[self.todayQuizID intValue] ] forKey:@"quizid"];
    NSString * points = [NSString stringWithFormat:@"%d",self.selectedIndexArr.count];
    [mdic setObject:points forKey:@"points"];
    [mdic setObject:@"0" forKey:@"isarcheive"];
    //[mdic setObject:self.yearsLbl.text forKey:@"year"];
    NSDictionary* info = [NSDictionary dictionaryWithDictionary:mdic];
    
    NSString *jsonStr = [info JSONString];
    
    NSString *urlAsString = SERVER_URL;
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:60.0f];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body = [NSString stringWithFormat:@"functionName=%@&json=%@}",FUNC_ADDPOINTS,jsonStr];
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *jsonData, NSError *error)
     {
         if ([jsonData length] >0 && error == nil)
         {
             JSONDecoder* decoder = [[JSONDecoder alloc]
                                     initWithParseOptions:JKParseOptionNone];
             id json = [decoder objectWithData:jsonData];
             self.sourceDictionary = [[NSDictionary alloc] initWithDictionary:json];
             
             NSLog(@"Got Data: %@ ",json);
             
             if ([json isKindOfClass:[NSDictionary class]]) {
                 NSDictionary * dicOne = (NSDictionary*)json;
                 
                 NSDictionary * dic= [dicOne objectForKey:@"status"];
                 
                 if ([[dic objectForKey:@"status_id"] integerValue]==0) {
                     
                     UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"TEEVO" message:@"No Record Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                     
                     [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES
                      ];
                     
                 }
                 
             }
             
             if (json != nil && error == nil)
             {
                 NSLog(@"Successfully deserialized...");
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
         }
     }];
    //[self addViewToArchieves];
}

-(void)UpdateQuiz{
    NSLog(@"UpdateQuiz");
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackFromTeevoQuestAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnMenuTeevoQuestAction:(id)sender {
    
}
- (IBAction)btnTodaysQuizAction:(id)sender
{
    
    self.QuizString = @"TodayQuiz";
    //if (![self.PickerView superview]) {
//        CGRect frame = CGRectMake(0, 119, self.PickerView.frame.size.width, self.PickerView.frame.size.height);
//        self.PickerView.frame = frame;
//        [self.view addSubview:self.PickerView];
    //}
    
//    if ([self.PickerView superview]) {
//        [self.PickerView removeFromSuperview];
//    }
    
    self.PickerView.hidden = YES;
    self.myTableView.frame = CGRectMake(0, 100, self.myTableView.frame.size.height, self.myTableView.frame.size.height+40);
    [self AddLoading];
    [self getTodaysQuizFromServer];
    
    //[self updateTodayTableQuiz];
    
    
    
//    [self.viewTodaysQuiz setHidden:NO];
//    [self.viewArchive setHidden:YES];
//    [self.viewPoints setHidden:YES];
}

-(void)updateTodayTableQuiz{
    NSLog(@"KKK :%@",self.sourceDictionary);
    self.QuestionNameArr = [[NSMutableArray alloc] init];
    self.QuestionAnswerIDArr = [[NSMutableArray alloc] init];
    self.OptionNameArr = [[NSMutableArray alloc] init];
    self.OptionNameIDArr = [[NSMutableArray alloc] init];
    self.RightAnserIdArr = [[NSMutableArray alloc] init];
    
    
    
    NSArray * dataArr = [self.sourceDictionary objectForKey:@"data"];
    NSDictionary *dataDict = [dataArr objectAtIndex:0];
    self.todayQuizID = [dataDict objectForKey:@"quizid"];
    int dataCount = [[dataDict allValues] count] - 2;
    for (int i = 0; i < dataCount; i++)
    {
        NSDictionary *srcDict = [dataDict objectForKey:[NSString stringWithFormat:@"%d",i]];
        
        [self.QuestionNameArr addObject:[srcDict objectForKey:@"questiontext"]];
        [self.OptionNameArr addObject:[srcDict objectForKey:@"answertext"]];// OptionNameArr
        [self.OptionNameIDArr addObject:[srcDict objectForKey:@"answerids"]];
        [self.QuestionAnswerIDArr addObject:[srcDict objectForKey:@"questionid"]];
        [self.RightAnserIdArr addObject:[srcDict objectForKey:@"rightanswerid"]];
        
        
    }
   /* for (int k=0; k<dataArr.count; k++) {
        
        NSDictionary * quizDic = [ dataArr objectAtIndex:k];
        for (int k=0; k<quizDic.allKeys.count; k++) {
        
            NSDictionary * DicData= [];
            
        [self.QuestionNameArr addObject:[quizDic objectForKey:@"questiontext"]];
        [self.OptionNameArr addObject:[quizDic objectForKey:@"answertext"]];// OptionNameArr
        [self.OptionNameIDArr addObject:[quizDic objectForKey:@"answerids"]];
        [self.QuestionAnswerIDArr addObject:[quizDic objectForKey:@"questionid"]];
        [self.RightAnserIdArr addObject:[quizDic objectForKey:@"rightanswerid"]];
        }
    }*/
    
//    NSLog(@"self.QuestionNameArr:%@",self.QuestionNameArr);
//    NSLog(@"self.OptionNameArr:%@",self.OptionNameArr);
//    NSLog(@"self.OptionNameIDArr:%@",self.OptionNameIDArr);
//    NSLog(@"self.QuestionAnswerIDArr:%@",self.QuestionAnswerIDArr);
//    NSLog(@"self.RightAnserIdArr:%@",self.RightAnserIdArr);
    self.mainArr = [[NSMutableArray alloc] init];
    self.btnArr = [[NSMutableArray alloc] init];
    for (int k=0; k<self.QuestionNameArr.count; k++) {
        
//        NSArray * MyArr = [self.OptionNameIDArr objectAtIndex:k];
//        
//        for (NSNumber * num in MyArr) {
//            [self.btnArr addObject:[NSNumber numberWithBool:NO]];
//        }
        
        //[self.mainArr addObjectsFromArray:self.btnArr];
       // [self.selectedIndexArr addObject:[NSNumber numberWithInt:k]];
        
        [self.submitArr addObject:[NSDictionary dictionary]];
    }
    
   // NSLog(@"MainArr :%@",self.mainArr);
    
    [self.myTableView reloadData];
    [self removeLoading];
}

-(void)updateArchivesData{
    NSLog(@"KKKkkkkkk :%@",self.sourceDictionary);
    self.QuestionNameArr = [[NSMutableArray alloc] init];
    self.QuestionAnswerIDArr = [[NSMutableArray alloc] init];
    self.OptionNameArr = [[NSMutableArray alloc] init];
    self.OptionNameIDArr = [[NSMutableArray alloc] init];
    self.RightAnserIdArr = [[NSMutableArray alloc] init];
    
    
    
    NSArray * dataArr = [self.sourceDictionary objectForKey:@"data"];
    NSDictionary *dataDict = [dataArr objectAtIndex:0];
    self.todayQuizID = [dataDict objectForKey:@"quizid"];
    int dataCount = [[dataDict allValues] count] - 2;
    for (int i = 0; i < dataArr.count; i++)
    {
       // NSDictionary *srcDict = [dataDict objectForKey:[NSString stringWithFormat:@"%d",i]];
        
        NSDictionary *srcDict = [dataArr objectAtIndex:i];
        
        
        
        [self.QuestionNameArr addObject:[srcDict objectForKey:@"questiontext"]];
        [self.OptionNameArr addObject:[srcDict objectForKey:@"answertext"]];// OptionNameArr
        [self.OptionNameIDArr addObject:[srcDict objectForKey:@"answerids"]];
        [self.QuestionAnswerIDArr addObject:[srcDict objectForKey:@"questionid"]];
        [self.RightAnserIdArr addObject:[srcDict objectForKey:@"rightanswerid"]];
        
        
    }
    /* for (int k=0; k<dataArr.count; k++) {
     
     NSDictionary * quizDic = [ dataArr objectAtIndex:k];
     for (int k=0; k<quizDic.allKeys.count; k++) {
     
     NSDictionary * DicData= [];
     
     [self.QuestionNameArr addObject:[quizDic objectForKey:@"questiontext"]];
     [self.OptionNameArr addObject:[quizDic objectForKey:@"answertext"]];// OptionNameArr
     [self.OptionNameIDArr addObject:[quizDic objectForKey:@"answerids"]];
     [self.QuestionAnswerIDArr addObject:[quizDic objectForKey:@"questionid"]];
     [self.RightAnserIdArr addObject:[quizDic objectForKey:@"rightanswerid"]];
     }
     }*/
    
    //    NSLog(@"self.QuestionNameArr:%@",self.QuestionNameArr);
    //    NSLog(@"self.OptionNameArr:%@",self.OptionNameArr);
    //    NSLog(@"self.OptionNameIDArr:%@",self.OptionNameIDArr);
    //    NSLog(@"self.QuestionAnswerIDArr:%@",self.QuestionAnswerIDArr);
    //    NSLog(@"self.RightAnserIdArr:%@",self.RightAnserIdArr);
    self.mainArr = [[NSMutableArray alloc] init];
    self.btnArr = [[NSMutableArray alloc] init];
    for (int k=0; k<self.QuestionNameArr.count; k++) {
        
        //        NSArray * MyArr = [self.OptionNameIDArr objectAtIndex:k];
        //
        //        for (NSNumber * num in MyArr) {
        //            [self.btnArr addObject:[NSNumber numberWithBool:NO]];
        //        }
        
        //[self.mainArr addObjectsFromArray:self.btnArr];
        // [self.selectedIndexArr addObject:[NSNumber numberWithInt:k]];
        
        [self.submitArr addObject:[NSDictionary dictionary]];
    }
    
    // NSLog(@"MainArr :%@",self.mainArr);
    
    [self.myTableView reloadData];
    [self removeLoading];
}


- (IBAction)btnArchiveAction:(id)sender
{
    //self.QuizString = @"TodayQuiz";
    self.QuizString = @"ArchiveQuiz";
    self.PickerView.hidden = NO;
    self.myTableView.frame = CGRectMake(0, 143, self.myTableView.frame.size.height, self.myTableView.frame.size.height);
    //self.sourceDictionary = nil;
    self.OptionNameIDArr = nil;
    [self.myTableView reloadData];
   // [self getQuizArchieveFromServer];
//    [self.viewTodaysQuiz setHidden:YES];
//    [self.viewArchive setHidden:NO];
//    [self.viewPoints setHidden:YES];
}

- (IBAction)btnPointsAction:(id)sender {
    [_view1 setHidden:YES];
    [self AddLoading];
    [self getListofPoint];
    
    self.QuizString = @"PointsQuiz";
    self.PickerView.hidden = YES;
    self.myTableView.frame = CGRectMake(0, 100, self.myTableView.frame.size.height, self.myTableView.frame.size.height+40);
    
    
//    [self.viewTodaysQuiz setHidden:YES];
//    [self.viewArchive setHidden:YES];
//    [self.viewPoints setHidden:NO];
}

-(void)getListofPoint{
    NSMutableDictionary * mdic = [[NSMutableDictionary alloc] init];
    //{"userid":"3"}
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //appDelegate.strUserId =
    //[mdic setObject:@"3" forKey:@"userid"];
    
    [mdic setObject:appDelegate.strUserId forKey:@"userid"];
    //[mdic setObject:@"3" forKey:@"userid"];
    //[mdic setObject:self.yearsLbl.text forKey:@"year"];
    NSDictionary* info = [NSDictionary dictionaryWithDictionary:mdic];
    
    NSString *jsonStr = [info JSONString];
    
    NSString *urlAsString = SERVER_URL;
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:60.0f];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body = [NSString stringWithFormat:@"functionName=%@&json=%@}",FUNC_DUMMYGETALLPOINTSBYMONTH,jsonStr];
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *jsonData, NSError *error)
     {
         if ([jsonData length] >0 && error == nil)
         {
             JSONDecoder* decoder = [[JSONDecoder alloc]
                                     initWithParseOptions:JKParseOptionNone];
             id json = [decoder objectWithData:jsonData];
             //self.sourceDictionary = [[NSDictionary alloc] initWithDictionary:json];
             
             NSLog(@"Got Data: %@ ",json);
             
             if ([json isKindOfClass:[NSDictionary class]]) {
                 NSDictionary * dicOne = (NSDictionary*)json;
                 
                 NSDictionary * dic= [dicOne objectForKey:@"status"];
                 self.allPointArr = [dicOne objectForKey:@"data"];
                 
                 [self.myTableView reloadData];
                 //[self perfo];
                // [self performSelectorOnMainThread:@selector(removeLoading) withObject:nil waitUntilDone:YES];
                 //self.pointLblcount.text = [NSString stringWithFormat:@"%@",[[self.pointsDataArr objectAtIndex:0] objectForKey:@"points"]];
                 
                 
                 if ([[dic objectForKey:@"status_id"] integerValue]==0) {
                     
                     UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"TEEVO" message:@"No Record Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                     
                     [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES
                      ];
                     
                 }
                 
             }
             
             if (json != nil && error == nil)
             {
                 NSLog(@"Successfully deserialized...");
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
         }
         
         
     }];
    [self performSelector:@selector(removeLoading) withObject:nil afterDelay:4.0];
    
}

-(void)getPointsData{
    [self AddLoading];
    NSMutableDictionary * mdic = [[NSMutableDictionary alloc] init];
    //{"userid":"3"}
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //appDelegate.strUserId =
    //[mdic setObject:@"3" forKey:@"userid"];
    NSLog(@"appDelegate.strUserId:%@",appDelegate.strUserId);
    [mdic setObject:appDelegate.strUserId forKey:@"userid"];
    //[mdic setObject:@"3" forKey:@"userid"];
    //[mdic setObject:self.yearsLbl.text forKey:@"year"];
    NSDictionary* info = [NSDictionary dictionaryWithDictionary:mdic];
    
    NSString *jsonStr = [info JSONString];
    
    NSString *urlAsString = SERVER_URL;
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:60.0f];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body = [NSString stringWithFormat:@"functionName=%@&json=%@}",FUNC_DUMMYALLPOINTS,jsonStr];
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *jsonData, NSError *error)
     {
         if ([jsonData length] >0 && error == nil)
         {
             JSONDecoder* decoder = [[JSONDecoder alloc]
                                     initWithParseOptions:JKParseOptionNone];
             id json = [decoder objectWithData:jsonData];
             //self.sourceDictionary = [[NSDictionary alloc] initWithDictionary:json];
             
             NSLog(@"Got Data: %@ ",json);
             
             if ([json isKindOfClass:[NSDictionary class]]) {
                 NSDictionary * dicOne = (NSDictionary*)json;
                 
                 NSDictionary * dic= [dicOne objectForKey:@"status"];
                 self.pointsDataArr = [dicOne objectForKey:@"data"];
                 
                 
                 self.pointLblcount.text = [NSString stringWithFormat:@"%@",[[self.pointsDataArr objectAtIndex:0] objectForKey:@"points"]];
                 
                 
                 if ([[dic objectForKey:@"status_id"] integerValue]==0) {
                     
                     UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"TEEVO" message:@"No Record Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                     
                     [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES
                      ];
                     
                 }
                 
                 //[self performSelectorOnMainThread:@selector(removeLoading) withObject:nil waitUntilDone:YES];
                 
             }
             
             if (json != nil && error == nil)
             {
                 NSLog(@"Successfully deserialized...");
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
         }
     }];
    
    [self performSelector:@selector(removeLoading) withObject:nil afterDelay:1.0];
    
}


- (void) getTodaysQuizFromServer
{
     NSString *urlAsString = SERVER_URL;
    
    NSURL *url = [NSURL URLWithString:urlAsString];

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:30.0f];
    
    [urlRequest setHTTPMethod:@"POST"];

    NSString *body = [NSString stringWithFormat:@"functionName=%@&json=%@}",FUNC_TODAYS_QUIZ,@""];
    
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
                 NSLog(@"Successfully deserialized...");
                 
                 self.QuizString = @"TodayQuiz";
                // self.QuizString = @"ArchiveQuiz";
                    [self updateTodayTableQuiz];
                 
                 
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
         //[self performSelectorOnMainThread:@selector(removeLoading) withObject:nil waitUntilDone:YES];
     }];
    
    
    //[self addViewToTodaysQuiz];
}

- (void) getQuizArchieveFromServer
{
    NSMutableDictionary * mdic = [[NSMutableDictionary alloc] init];
    
    [mdic setObject:self.QuizeID forKey:@"quizid"];
    //[mdic setObject:self.yearsLbl.text forKey:@"year"];
    NSDictionary* info = [NSDictionary dictionaryWithDictionary:mdic];
    
    //NSString *jsonStr = [info JSONString];
    
    NSError * writeError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&writeError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    
    
    NSString *urlAsString = SERVER_URL;
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:60.0f];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body = [NSString stringWithFormat:@"functionName=%@&json= %@",FUNC_DUMMYARCHIVES,jsonStr];
    
    
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *jsonData, NSError *error)
     {
         if ([jsonData length] >0 && error == nil)
         {
             JSONDecoder* decoder = [[JSONDecoder alloc]
                                     initWithParseOptions:JKParseOptionNone];
             id json = [decoder objectWithData:jsonData];
             self.sourceDictionary = [[NSDictionary alloc] initWithDictionary:json];

             NSLog(@"Got Data: %@ ",json);
             
             if ([json isKindOfClass:[NSDictionary class]]) {
                 NSDictionary * dicOne = (NSDictionary*)json;
                 
                 NSDictionary * dic= [dicOne objectForKey:@"status"];
                 
                 if ([[dic objectForKey:@"status_id"] integerValue]==0) {
                     
                     UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"TEEVO" message:@"No Record Found" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
                     
                     [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES
                      ];
                     
                 }else{
                    //[self updateTodayTableQuiz];
                     self.QuizString = @"ArchiveQuiz";
                     [self updateArchivesData];
                     
                 }
                 
             }
             
             if (json != nil && error == nil)
             {
                 NSLog(@"Successfully deserialized...");
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
         }
         
         //[self performSelectorOnMainThread:@selector(removeLoading) withObject:nil waitUntilDone:YES];
     }];
    //[self addViewToArchieves];
    [self performSelector:@selector(removeLoading) withObject:nil afterDelay:3.0];
}

- (void) getQuizBYArchieveFromServer
{
    NSMutableDictionary * mdic = [[NSMutableDictionary alloc] init];
    
    [mdic setObject:self.mnthLbl.text forKey:@"month"];
    [mdic setObject:self.yearsLbl.text forKey:@"year"];
    NSDictionary* info = [NSDictionary dictionaryWithDictionary:mdic];
    
    NSString *jsonStr = [info JSONString];
    NSLog(@"jsonStr:%@",jsonStr);
    NSString *urlAsString = SERVER_URL;
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:60.0f];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body = [NSString stringWithFormat:@"functionName=%@&json=%@}",FUNC_GET_QUIZ_ARCHIVE,jsonStr];
    
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *jsonData, NSError *error)
     {
         if ([jsonData length] >0 && error == nil)
         {
             JSONDecoder* decoder = [[JSONDecoder alloc]
                                     initWithParseOptions:JKParseOptionNone];
             id json = [decoder objectWithData:jsonData];
             self.sourceDictionary = [[NSDictionary alloc] initWithDictionary:json];
             
             NSLog(@"Got Data: %@ ",json);
             
             if (json != nil && error == nil)
             {
                 NSLog(@"Successfully deserialized...");
                 [self addQUIZViewToArchieves];
                 
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
         }
         
         [self performSelectorOnMainThread:@selector(removeLoading) withObject:nil waitUntilDone:YES];
     }];
    
}


-(void)addQUIZViewToArchieves{
    self.QuiZNameArr = [[NSMutableArray alloc] init];
    self.QuiZeIDArr = [[NSMutableArray alloc] init];
    NSArray *dataArray = [self.sourceDictionary objectForKey:@"data"];
    NSDictionary *dataDict = [dataArray objectAtIndex:0];
    int dataCount = [[dataDict allValues] count] - 2;
            
        
//        for (NSDictionary *QuiZDic in dataArray) {
//            
//            [self.QuiZeIDArr addObject:[QuiZDic objectForKey:@"quizid"]];
//            [self.QuiZNameArr addObject:[QuiZDic objectForKey:@"quizname"]];
//        }
    
    for (int k=0; k<dataArray.count; k++) {
        
        NSDictionary *QuiZDic = [dataArray objectAtIndex:k];
        [self.QuiZeIDArr addObject:[QuiZDic objectForKey:@"quizid"]];
        [self.QuiZNameArr addObject:[QuiZDic objectForKey:@"quizname"]];
    }
    
        NSLog(@"kkk:%@",self.QuiZNameArr);
        
        /* [self.arcchScrollview setContentSize:CGSizeMake(self.arcchScrollview.frame.size.width, dataCount * 250.0)];
         QuizView *qview = [[[NSBundle mainBundle] loadNibNamed:@"QuizView" owner:self options:nil] lastObject];
         NSDictionary *srcDict = [dataDict objectForKey:[NSString stringWithFormat:@"%d",i]];
         qview.question.text = [srcDict valueForKey:@"questiontext"];
         qview.opt1.text = [[srcDict valueForKey:@"answertext"] objectAtIndex:0];
         qview.opt2.text = [[srcDict valueForKey:@"answertext"] objectAtIndex:1];
         qview.opt3.text = [[srcDict valueForKey:@"answertext"] objectAtIndex:2];
         qview.opt4.text = [[srcDict valueForKey:@"answertext"] objectAtIndex:3];
         qview.questNo.text = [NSString stringWithFormat:@"%2d",i+1];
         
         RadioButtonControlSelectionBlock selectionBlock = ^(VCRadioButton *radioButton){
         if (radioButton.groupName)
         NSLog(@"RadioButton from group:%@ was:%@ and has a value of:%@",
         radioButton.groupName,
         (radioButton.selected)? @"selected" : @"deselected",
         radioButton.selectedValue);
         else
         NSLog(@"RadioButton with value of:%@ was:%@",
         radioButton.selectedValue,
         (radioButton.selected)? @"selected" : @"deselected");
         };
         qview.radiobtn1.selectionBlock = selectionBlock;
         qview.radiobtn2.selectionBlock = selectionBlock;
         qview.radiobtn3.selectionBlock = selectionBlock;
         qview.radiobtn4.selectionBlock = selectionBlock;
         
         qview.radiobtn1.groupName = @"group1";
         qview.radiobtn2.groupName = @"group1";
         qview.radiobtn3.groupName = @"group1";
         qview.radiobtn4.groupName = @"group1";
         
         [qview reloadInputViews];
         [self.arcchScrollview addSubview:qview];
         [qview setFrame:CGRectMake(0, 250 * i, qview.frame.size.width, qview.frame.size.height)];
         [self.view layoutIfNeeded];
         */
    
}

- (void) addViewToArchieves
{
    NSArray *dataArray = [self.sourceDictionary objectForKey:@"data"];
    NSDictionary *dataDict = [dataArray objectAtIndex:0];
    int dataCount = [[dataDict allValues] count] - 2;
    for (int i = 0; i < dataCount; i++)
    {
       /* [self.arcchScrollview setContentSize:CGSizeMake(self.arcchScrollview.frame.size.width, dataCount * 250.0)];
        QuizView *qview = [[[NSBundle mainBundle] loadNibNamed:@"QuizView" owner:self options:nil] lastObject];
        NSDictionary *srcDict = [dataDict objectForKey:[NSString stringWithFormat:@"%d",i]];
        qview.question.text = [srcDict valueForKey:@"questiontext"];
        qview.opt1.text = [[srcDict valueForKey:@"answertext"] objectAtIndex:0];
        qview.opt2.text = [[srcDict valueForKey:@"answertext"] objectAtIndex:1];
        qview.opt3.text = [[srcDict valueForKey:@"answertext"] objectAtIndex:2];
        qview.opt4.text = [[srcDict valueForKey:@"answertext"] objectAtIndex:3];
        qview.questNo.text = [NSString stringWithFormat:@"%2d",i+1];
        
        RadioButtonControlSelectionBlock selectionBlock = ^(VCRadioButton *radioButton){
            if (radioButton.groupName)
                NSLog(@"RadioButton from group:%@ was:%@ and has a value of:%@",
                      radioButton.groupName,
                      (radioButton.selected)? @"selected" : @"deselected",
                      radioButton.selectedValue);
            else
                NSLog(@"RadioButton with value of:%@ was:%@",
                      radioButton.selectedValue,
                      (radioButton.selected)? @"selected" : @"deselected");
        };
        qview.radiobtn1.selectionBlock = selectionBlock;
        qview.radiobtn2.selectionBlock = selectionBlock;
        qview.radiobtn3.selectionBlock = selectionBlock;
        qview.radiobtn4.selectionBlock = selectionBlock;
        
        qview.radiobtn1.groupName = @"group1";
        qview.radiobtn2.groupName = @"group1";
        qview.radiobtn3.groupName = @"group1";
        qview.radiobtn4.groupName = @"group1";
        
        [qview reloadInputViews];
        [self.arcchScrollview addSubview:qview];
        [qview setFrame:CGRectMake(0, 250 * i, qview.frame.size.width, qview.frame.size.height)];
        [self.view layoutIfNeeded];
        */
    }
}

- (IBAction)SlectAditions:(id)sender {
    if (self.QuiZNameArr.count>0) {
        [ActionSheetStringPicker showPickerWithTitle:@"Select Edition" rows:self.QuiZNameArr initialSelection:0 target:self successAction:@selector(EditionWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
        
        
   
    }
        
}

- (void)EditionWasSelected:(NSNumber*)selectedDate element:(id)element
{
    self.SelectEdition.text = [self.QuiZNameArr objectAtIndex:[selectedDate integerValue]];
    self.QuizeID = [self.QuiZeIDArr objectAtIndex:[selectedDate integerValue]];
    [self AddLoading];
    [self getQuizArchieveFromServer];
    
}


- (IBAction)selectMonth:(id)sender {
    [ActionSheetStringPicker showPickerWithTitle:@"Select Month" rows:self.monthArr initialSelection:0 target:self successAction:@selector(monthWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
    
   // getting the list of quiz names
    
    //function >>> getquizbyarchives
    //params >>> {"month":"10","year":"2013"}
    
    
}

- (void)monthWasSelected:(NSNumber*)selectedDate element:(id)element
{
    self.mnthLbl.text = [self.monthArr objectAtIndex:[selectedDate integerValue]];
    
    
    [self getQuizBYArchieveFromServer];
    
}
- (void)actionPickerCancelled:(id)sender {
    
    
    NSLog(@"Delegate has been informed that ActionSheetPicker was cancelled");
}

- (IBAction)selectyears:(id)sender {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int i2 = [[formatter stringFromDate:[NSDate date]] intValue];
    //Create Years Array from 1960 to This year
    self.yearsArr = [[NSMutableArray alloc] init];
    for (int i=1960; i<=i2; i++) {
        [self.yearsArr addObject:[NSString stringWithFormat:@"%d",i]];
    }
   
    [ActionSheetStringPicker showPickerWithTitle:@"Select Years" rows:self.yearsArr initialSelection:0 target:self successAction:@selector(durationWasSelected:element:) cancelAction:@selector(actionPickerCancelled:) origin:sender];
  
}

- (void)durationWasSelected:(NSNumber*)selectedDate element:(id)element {
    
    NSString * str = [self.yearsArr objectAtIndex:[selectedDate integerValue]];
    self.yearsLbl.text = str;
    NSLog(@"selectedDate:%@",str);
        
}
- (void) addViewToTodaysQuiz
{
    NSArray *dataArray = [self.sourceDictionary objectForKey:@"data"];
    NSDictionary *dataDict = [dataArray objectAtIndex:0];
    int dataCount = [[dataDict allValues] count] - 2;
    for (int i = 0; i < dataCount; i++)
    {
        
        
        
      /*  [self.todayQuizScrollView setContentSize:CGSizeMake(self.todayQuizScrollView.frame.size.width, dataCount * 250.0)];
        QuizView *qview = [[[NSBundle mainBundle] loadNibNamed:@"QuizView" owner:self options:nil] lastObject];
        NSDictionary *srcDict = [dataDict objectForKey:[NSString stringWithFormat:@"%d",i]];
        qview.question.text = [srcDict valueForKey:@"questiontext"];
        qview.opt1.text = [[srcDict valueForKey:@"answertext"] objectAtIndex:0];
        qview.opt2.text = [[srcDict valueForKey:@"answertext"] objectAtIndex:1];
        qview.opt3.text = [[srcDict valueForKey:@"answertext"] objectAtIndex:2];
        qview.opt4.text = [[srcDict valueForKey:@"answertext"] objectAtIndex:3];
        qview.questNo.text = [NSString stringWithFormat:@"%2d",i+1];
        
        RadioButtonControlSelectionBlock selectionBlock = ^(VCRadioButton *radioButton){
            if (radioButton.groupName)
                NSLog(@"RadioButton from group:%@ was:%@ and has a value of:%@",
                      radioButton.groupName,
                      (radioButton.selected)? @"selected" : @"deselected",
                      radioButton.selectedValue);
            else
                NSLog(@"RadioButton with value of:%@ was:%@",
                      radioButton.selectedValue,
                      (radioButton.selected)? @"selected" : @"deselected");
        };
        qview.radiobtn1.selectionBlock = selectionBlock;
        qview.radiobtn2.selectionBlock = selectionBlock;
        qview.radiobtn3.selectionBlock = selectionBlock;
        qview.radiobtn4.selectionBlock = selectionBlock;
        
        qview.radiobtn1.groupName = @"group1";
        qview.radiobtn2.groupName = @"group1";
        qview.radiobtn3.groupName = @"group1";
        qview.radiobtn4.groupName = @"group1";
        [self.todayQuizScrollView addSubview:qview];
        [qview setFrame:CGRectMake(0, 250 * i, qview.frame.size.width, qview.frame.size.height)];
        [qview reloadInputViews];
        [self.view layoutIfNeeded];
       */
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.QuizString isEqualToString:@"PointsQuiz"]) {
        
        return 60;
        
    }else{
        return 164;
    
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    if ([self.QuizString isEqualToString:@"PointsQuiz"]) {
        
        return self.allPointArr.count;
        
    }else{
        
        
        
        if (self.OptionNameIDArr.count>0) {
            return self.OptionNameIDArr.count;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.QuizString isEqualToString:@"PointsQuiz"]) {
        
        static NSString *CellIdentifier = @"PointCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            
            
            
        }
        
        
        NSDictionary * pointDic = [self.allPointArr objectAtIndex:indexPath.row];
         self.totalPoints = [pointDic objectForKey:@"totalpoints"];
        self.monthNumber = [pointDic objectForKey:@"month"];
        
        UILabel * allPoints = (UILabel*)[cell viewWithTag:5001];
        allPoints.text = self.totalPoints;
        UILabel * monthsLbl = (UILabel*)[cell viewWithTag:5002];
        monthsLbl.text = [NSString stringWithFormat:@"Daily devotional %@",[self.monthNameArr objectAtIndex:[self.monthNumber integerValue]-1]];
        
        return cell;
        
    }else{
        
        
    
    
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
        
        
    }
    
    // Display recipe in the table cell
    
    UILabel * IndexNo = (UILabel*)[cell viewWithTag:1000];
    IndexNo.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
    UILabel * questionLbl = (UILabel*)[cell viewWithTag:1001];
    questionLbl.text = [self.QuestionNameArr objectAtIndex:indexPath.row];
    
    NSArray * OptionArr = [self.OptionNameArr objectAtIndex:indexPath.row];
    
    UILabel * OptionA = (UILabel*)[cell viewWithTag:1002];
    OptionA.text = [OptionArr objectAtIndex:0];
    UILabel * OptionB = (UILabel*)[cell viewWithTag:1003];
    OptionB.text = [OptionArr objectAtIndex:1];
    UILabel * OptionC = (UILabel*)[cell viewWithTag:1004];
    OptionC.text = [OptionArr objectAtIndex:2];
    UILabel * OptionD = (UILabel*)[cell viewWithTag:1005];
    OptionD.text = [OptionArr objectAtIndex:3];
    
    float pos =52.0f;
    self.btnArr = [[NSMutableArray alloc] init];
    for (int k=0; k<4; k++) {
        
        self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.button addTarget:self
                        action:@selector(OptionA:)
              forControlEvents:UIControlEventTouchDown];
        self.button.frame = CGRectMake(49.0f, pos, 10.0f, 10.0f);
        self.button.tag =k;
        [cell addSubview:self.button];
        //[self.btnArr addObject:self.button];
        
        
        pos+= 30.0f;
    }
    
    //NSLog(@"selectedIndexArr count is %i", self.selectedIndexArr.count);
    if(self.selectedIndexArr.count > 0){
        for (int j = 0; j<self.selectedIndexArr.count; j++) {
            
            if(indexPath.row == [[self.selectedIndexArr objectAtIndex:j] intValue]){
                for (id cellObj in cell.subviews) {
                    if([cellObj isKindOfClass:[UIButton class]]){
                        UIButton *btn = (UIButton *)cellObj;
                        
                        
                        if(btn.tag == [[self.SelectionArr objectAtIndex:[self.selectedIndexArr indexOfObject:[NSNumber numberWithInt:indexPath.row]]] intValue]){
                            
                            // NSLog(@"btn tag is %i",btn.tag);
                            [btn setImage:[UIImage imageNamed:@"radio-btn-active.png"] forState:UIControlStateNormal];
                        }
                        
                        
                    }
                }
            }
            
            
        }
    }
    
    
    
    
    
    return cell;
    
    }
}

-(void)SelectOptionA:(id)sender{
   
    UIButton * btn = (UIButton*)sender;
    
    if(![btn isSelected])
    {
        
        
        [btn setSelected:YES];
        [btn setImage:[UIImage imageNamed:@"radio-btn-active.png"] forState:UIControlStateSelected]; //not working, button image is not changing
       
        
    }
    else
    {
        [btn setSelected:NO];
      
        [btn setImage:[UIImage imageNamed:@"radio-btn.png"] forState:UIControlStateNormal];
        
        
    }
    

    
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.QuizString isEqualToString:@"PointsQuiz"]) {
        UIStoryboard * storyboard = self.storyboard;
        
        PointsViewController * detail = [storyboard instantiateViewControllerWithIdentifier: @ "PointsViewController"];
//        detail.rightAnswer = self.SelectionArr;
//        detail.questionArr = self.selectedIndexArr;
//        detail.sourceDictionary = self.sourceDictionary;
//        detail.submitArr = self.submitArr;
//        detail.answercount = self.answercount;
        detail.monthNumber = self.monthNumber;
        detail.totalPoints=self.totalPoints;
        
        [self.navigationController pushViewController: detail animated: YES];
    }else{
        
    }
}



-(IBAction)SelectYear:(id)sender{
    
}

- (IBAction)OptionA:(id)sender {
    //NSLog(@"AAAA");
    //    NSLog(@"self.QuestionNameArr:%@",self.QuestionNameArr);
    //    NSLog(@"self.OptionNameArr:%@",self.OptionNameArr);
    //    NSLog(@"self.OptionNameIDArr:%@",self.OptionNameIDArr);
    //    NSLog(@"self.QuestionAnswerIDArr:%@",self.QuestionAnswerIDArr);
    //    NSLog(@"self.RightAnserIdArr:%@",self.RightAnserIdArr);
    NSMutableDictionary * cellDictionary = [[NSMutableDictionary alloc] init];
    UIButton *btn = (UIButton *)sender;
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    
    BOOL isReplace = NO;
    int theIndex;
    
    for (int j = 0; j<self.selectedIndexArr.count; j++) {
        if(indexPath.row == [[self.selectedIndexArr objectAtIndex:j] intValue]){
            theIndex = [self.selectedIndexArr indexOfObject:[NSNumber numberWithInt:indexPath.row]];
            isReplace = YES;
            break;
        }else{
            isReplace = NO;
        }
    }
    
    
    
    
    //    NSLog(@"CellIndex:%@",self.selectedIndexArr);
    //    NSLog(@"Btn:%@",self.SelectionArr);
    
    
    
    
    
    int selectedCellNumber = [indexPath row];
    // NSLog(@"selectedCellNumber:%d",selectedCellNumber);
    
    NSArray * selectedOptionNameArr = [self.OptionNameArr objectAtIndex:selectedCellNumber];
    NSArray * seletedOptionIDArr = [self.OptionNameIDArr objectAtIndex:selectedCellNumber];
    //NSNumber * userselectedAnswer = [self.SelectionArr objectAtIndex:selectedCellNumber];
    
    NSString *selectedArrtext = [selectedOptionNameArr objectAtIndex:btn.tag];
    int selectedidNumber = [[seletedOptionIDArr objectAtIndex:btn.tag] intValue];
    int rightAnswerIdNumber = [[self.RightAnserIdArr objectAtIndex:selectedCellNumber] intValue];
    
    //    NSLog(@"selectedidNumber:%d",selectedidNumber);
    //    NSLog(@"rightAnswerIdNumber:%d",rightAnswerIdNumber);
    //    NSLog(@"selectedArrtext:%@",selectedArrtext);
    //    NSLog(@"SelectedBtn :%d",btn.tag);
    //
    
    
    if (selectedidNumber == rightAnswerIdNumber) {
        
        [cellDictionary setObject:[NSNumber numberWithBool:YES] forKey:@"IS_TRUE"];
        [cellDictionary setObject:[NSNumber numberWithInt:btn.tag] forKey:@"RIGHTANSWER_ID"];
        self.answercount++;
        NSLog(@"RightAnswer");
    }else{
        NSLog(@"WrongAnswer");
        [cellDictionary setObject:[NSNumber numberWithBool:NO] forKey:@"IS_TRUE"];
        //[cellDictionary setObject:nil forKey:@"WRONGANSWER_ID"];
    }
    
    NSLog(@"answercount:%d",self.answercount);
    if(isReplace){
        [self.selectedIndexArr replaceObjectAtIndex:theIndex withObject:[NSNumber numberWithInt:indexPath.row]];
        [self.SelectionArr replaceObjectAtIndex:theIndex withObject:[NSNumber numberWithInt:btn.tag]];
        
        [self.submitArr replaceObjectAtIndex:theIndex withObject:cellDictionary];
    }else{
        [self.selectedIndexArr addObject:[NSNumber numberWithInt:indexPath.row]];
        [self.SelectionArr addObject:[NSNumber numberWithInt:btn.tag]];
        
        [self.submitArr insertObject:cellDictionary atIndex:indexPath.row];
        //[self.submitArr addObject:cellDictionary];
    }
    for(int i=0;i<self.btnArr.count;i++){
        [[self.btnArr objectAtIndex:i] setImage:[UIImage imageNamed:@"radio-btn.png"]
                                       forState:UIControlStateNormal];
        [[self.btnArr objectAtIndex:i] setSelected:NO];
    }
    [btn setSelected:YES];
    self.selectedBtn = btn.tag;
    [btn setImage:[UIImage imageNamed:@"radio-btn-active.png"] forState:UIControlStateSelected];
    
    [self.myTableView reloadData];
    
    
    NSLog(@"cellDic:%@",self.submitArr);
    /*
     for (int m=0; m<self.selectedIndexArr.count; m++) {
     
     int value = [[self.selectedIndexArr objectAtIndex:m] intValue];
     for (int k=0; k<self.SelectionArr.count; k++) {
     
     
     int answer = [[self.SelectionArr objectAtIndex:k] intValue];
     //for (NSArray *tempArr in self.OptionNameIDArr) {
     NSArray * tempArr = [self.OptionNameIDArr objectAtIndex:value];
     
     
     //for (NSNumber * num in tempArr) {
     NSNumber * num = [tempArr objectAtIndex:answer];
     
     int answerId = [num intValue];
     
     // NSLog(@"Anwesr:%d",answerId);
     int AnswerId2 = [[self.RightAnserIdArr objectAtIndex:value] intValue];
     // NSLog(@"AnswerId2:%d",AnswerId2);
     
     if (answerId == AnswerId2) {
     
     //NSLog(@"LLLL");
     break;
     }else{
     // NSLog(@"KKKKKKK");
     }
     
     // }
     
     
     // }
     
     
     
     //            for (NSArray * answerId in self.OptionNameIDArr) {
     //
     //
     //            }
     
     
     
     
     
     }
     
     
     }
     
     */
    
    
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"Did Scroll");
    [_view1 setHidden:YES];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)aScrollView
{
    
    if ([self.QuizString isEqualToString:@"PointsQuiz"]) {
        
    
    
    }else{
        CGFloat yOffset = 0;
        
        if (self.myTableView.contentSize.height > self.myTableView.bounds.size.height) {
            yOffset = self.myTableView.contentSize.height - self.myTableView.bounds.size.height;
            //NSLog(@"CGFloat yOffset = ");
            
            [_view1 setHidden:NO];
            [self.myTableView bringSubviewToFront:_view1];
            
        }else{
            [_view1 setHidden:NO];
            [self.myTableView bringSubviewToFront:_view1];
            //[_view1 setHidden:YES];
        }
    }
    //if([_view1 superview])
      //  [_view1 removeFromSuperview];
    
   
}
- (void)scrollToBottom
{
    CGFloat yOffset = 0;
    
//    if (self.myTableView.contentSize.height > self.myTableView.bounds.size.height) {
//        yOffset = self.myTableView.contentSize.height - self.myTableView.bounds.size.height;
//    }
    
    //[self.myTableView setContentOffset:CGPointMake(0, yOffset) animated:NO];
}



@end
