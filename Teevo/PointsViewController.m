//
//  PointsViewController.m
//  Teevo
//
//  Created by Dhanesh Kumar on 16/10/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import "PointsViewController.h"
#import "PleaseWait.h"
#import "TeevoCommon.h"
#import "JSONKit.h"
@interface PointsViewController ()

@end

@implementation PointsViewController
@synthesize pleasewait;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"KKKK");
    self.headerCount.text =self.totalPoints;
    
    
    [self getPointbyMonth];
}
//getpointsbymonthid
-(void)getPointbyMonth{
    [self AddLoading];
    NSMutableDictionary * mdic = [[NSMutableDictionary alloc] init];
    //{"userid":"3"}
    [mdic setObject:@"3" forKey:@"userid"];
    [mdic setObject:self.monthNumber forKey:@"monthid"];
    NSDictionary* info = [NSDictionary dictionaryWithDictionary:mdic];
    
    NSString *jsonStr = [info JSONString];
    
    NSString *urlAsString = SERVER_URL;
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:60.0f];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body = [NSString stringWithFormat:@"functionName=%@&json=%@",FUNC_POINTSBYMONTHID,jsonStr];
    
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
                 
                 [self.myTableview reloadData];
                 //self.pointLblcount.text = [NSString stringWithFormat:@"%@",[[self.pointsDataArr objectAtIndex:0] objectForKey:@"points"]];
                 
                 
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
/*
-(void)getAllPointByMonth{
    NSMutableDictionary * mdic = [[NSMutableDictionary alloc] init];
    //{"userid":"3"}
    [mdic setObject:@"3" forKey:@"userid"];
    //[mdic setObject:self.yearsLbl.text forKey:@"year"];
    NSDictionary* info = [NSDictionary dictionaryWithDictionary:mdic];
    
    NSString *jsonStr = [info JSONString];
    
    NSString *urlAsString = SERVER_URL;
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    [urlRequest setTimeoutInterval:60.0f];
    
    [urlRequest setHTTPMethod:@"POST"];
    
    NSString *body = [NSString stringWithFormat:@"functionName=%@&json=%@}",FUNC_GETALLPOINTS,jsonStr];
    
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
    
}
*/
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //if ([self.QuizString isEqualToString:@"PointsQuiz"]) {
        
        return 60;
        
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    //if ([self.QuizString isEqualToString:@"PointsQuiz"]) {
        
        return self.pointsDataArr.count;
        
    //}
   // return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //if ([self.QuizString isEqualToString:@"PointsQuiz"]) {
        
        static NSString *CellIdentifier = @"PointCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        // Configure the cell...
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            
            
            
        }
    
    NSDictionary * pointsDic = [self.pointsDataArr objectAtIndex:indexPath.row];
    
    BOOL isarcheive = [[pointsDic objectForKey:@"isarcheive"] boolValue];
    UILabel* isarchivesLbl;
    if (isarcheive) {
        isarchivesLbl = (UILabel*)[cell viewWithTag:5004];
        isarchivesLbl.hidden = NO;
    }
    
    NSString *quizname = [pointsDic objectForKey:@"quizname"];
    NSString *points = [pointsDic objectForKey:@"points"];
    
    
    UILabel * OptionA = (UILabel*)[cell viewWithTag:5002];
    //OptionA.text = [OptionArr objectAtIndex:0];
    OptionA.text = quizname;
    //UILabel * OptionB = (UILabel*)[cell viewWithTag:5003];
    
    UILabel * OptionC = (UILabel*)[cell viewWithTag:5001];
    OptionC.text=points;
    
    
        
        return cell;
        
   // }
}



-(IBAction)backToTeevoQuest:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
