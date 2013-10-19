//
//  SubmitViewController.m
//  Teevo
//
//  Created by Dhanesh Kumar on 14/10/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import "SubmitViewController.h"
#import "TeevoQuestViewController.h"
@interface SubmitViewController ()

@end

@implementation SubmitViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"1111:%@",self.rightAnswer);
    NSLog(@"questionArr:%@",self.questionArr);
    NSLog(@"KKK :%@",self.sourceDictionary);
    NSString * headerString = [NSString stringWithFormat:@"You have answered %d Correct answer out of %d",self.answercount,self.submitArr.count];
    self.header.text = headerString;
    self.QuestionNameArr = [[NSMutableArray alloc] init];
    self.QuestionAnswerIDArr = [[NSMutableArray alloc] init];
    self.OptionNameArr = [[NSMutableArray alloc] init];
    self.OptionNameIDArr = [[NSMutableArray alloc] init];
    self.RightAnserIdArr = [[NSMutableArray alloc] init];
    
    if ([self.QuizString isEqualToString:@"ArchiveQuiz"]) {
               
        NSArray * dataArr = [self.sourceDictionary objectForKey:@"data"];
       // NSDictionary *dataDict = [dataArr objectAtIndex:0];
        //self.todayQuizID = [dataDict objectForKey:@"quizid"];
        //int dataCount = [[dataDict allValues] count] - 2;
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
        
    }else{
        NSArray * dataArr = [self.sourceDictionary objectForKey:@"data"];
        NSDictionary *dataDict = [dataArr objectAtIndex:0];
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
    }
    
    

    [self.myTableView reloadData];
}

-(IBAction)backToTeevoQuest:(id)sender{
//    UIStoryboard * storyboard = self.storyboard;
//    TeevoQuestViewController * detail = [storyboard instantiateViewControllerWithIdentifier: @ "TeevoQuestViewController"];
    //detail.sourceDictionary = self.sourceDictionary;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.OptionNameIDArr.count>0) {
        return self.OptionNameIDArr.count;
    }
    //return 6;
}

//- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger rowCount = [self tableView:[self tableView] numberOfRowsInSection:0];
//    NSInteger rowIndex = indexPath.row;
//    UIImage *background = nil;
//
//    if (rowIndex == 0) {
//        background = [UIImage imageNamed:@"cell_top.png"];
//    } else if (rowIndex == rowCount - 1) {
//        background = [UIImage imageNamed:@"cell_bottom.png"];
//    } else {
//        background = [UIImage imageNamed:@"cell_middle.png"];
//    }
//
//    return background;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
             
    }
    
    // Display recipe in the table cell
    UILabel * IndexNo = (UILabel*)[cell viewWithTag:1000];
    IndexNo.text = [NSString stringWithFormat:@"%d",indexPath.row];
    
//    if (indexPath.row%2==0) {
//        [IndexNo setBackgroundColor:[UIColor colorWithRed:120.0f/255.0f green:173.0f/255.0f blue:54.0f/255.0f alpha:1 ]];
//    }else{
//        
//    }
    
    
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
    
    
    
    BOOL ISTrue = NO;
    NSDictionary * answerDic = [self.submitArr objectAtIndex:indexPath.row];
    if (answerDic!=nil && answerDic.allKeys.count>0) {
    
    
     ISTrue = [[answerDic objectForKey:@"IS_TRUE"] boolValue];
    
    if (ISTrue) {
        [IndexNo setBackgroundColor:[UIColor colorWithRed:120.0f/255.0f green:173.0f/255.0f blue:54.0f/255.0f alpha:1 ]];
    }
    
    if ([answerDic objectForKey:@"RIGHTANSWER_ID"]) {
        NSUInteger trueOption = [[answerDic objectForKey:@"RIGHTANSWER_ID"] intValue];
        NSLog(@"trueOption:%d",trueOption);
        UIImageView * trueImageView =nil;
         trueImageView = (UIImageView*)[cell viewWithTag:trueOption];
        
        [trueImageView setImage:[UIImage imageNamed:@"check-green.png"]];
        
    }
    
}

  /*
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
        //[button setTitle:@"C" forState:UIControlStateNormal];
        //[self.button setImage:[UIImage imageNamed:@"radio-btn.png"] forState:UIControlStateNormal];
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
    
    
    
    */
    
    return cell;
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


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
@end
