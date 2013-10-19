//
//  SubmitViewController.h
//  Teevo
//
//  Created by Dhanesh Kumar on 14/10/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
-(IBAction)backToTeevoQuest:(id)sender;

@property(nonatomic,strong)IBOutlet UITableView * myTableView;

@property(nonatomic,strong)NSArray * rightAnswer;
@property(nonatomic,strong)NSDictionary *sourceDictionary;

@property(nonatomic,strong)NSMutableArray * QuestionNameArr;
@property(nonatomic,strong)NSMutableArray * QuestionAnswerIDArr;
@property(nonatomic,strong)NSMutableArray * OptionNameArr;
@property(nonatomic,strong)NSMutableArray * OptionNameIDArr;
@property(nonatomic,strong)NSMutableArray * RightAnserIdArr;

@property (weak, nonatomic) IBOutlet UILabel *header;

@property(nonatomic,strong)NSArray *questionArr;
@property(nonatomic,strong)NSArray * submitArr;
@property(assign)int answercount;

@property(nonatomic,strong)NSString *QuizString;
@end
