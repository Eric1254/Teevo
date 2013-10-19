//
//  TeevoQuestViewController.h
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownView.h"
@class AbstractActionSheetPicker;
@interface TeevoQuestViewController : UIViewController<DropDownViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *todayQuizScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *arcchScrollview;
@property (weak, nonatomic) IBOutlet UIView *viewTodaysQuiz;
@property (weak, nonatomic) IBOutlet UIView *viewArchive;
@property (weak, nonatomic) IBOutlet UIView *viewPoints;
@property (strong, nonatomic) NSDictionary *sourceDictionary;

@property(nonatomic,strong)UIView * view1;

@property(nonatomic,strong)IBOutlet UITableView * myTableView;


@property(nonatomic,strong)NSMutableArray * mainArr,*btnSelectionArr,*yearsArr,*monthArr;

@property(nonatomic,strong)NSMutableArray* QuiZeIDArr,*QuiZNameArr;
@property(nonatomic,strong)NSString * QuizeID;

- (IBAction)btnBackFromTeevoQuestAction:(id)sender;
- (IBAction)btnMenuTeevoQuestAction:(id)sender;
- (IBAction)btnTodaysQuizAction:(id)sender;
- (IBAction)btnArchiveAction:(id)sender;
- (IBAction)btnPointsAction:(id)sender;
- (void) getTodaysQuizFromServer;
- (void) getQuizArchieveFromServer;
- (void) addViewToArchieves;
- (IBAction)SlectAditions:(id)sender;
- (IBAction)selectMonth:(id)sender;
- (IBAction)selectyears:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *PickerView;
//@property (weak, nonatomic) IBOutlet UIButton *optionA;
//@property (weak, nonatomic) IBOutlet UIButton *optionB;
//@property (weak, nonatomic) IBOutlet UIButton *optionC;
//@property (weak, nonatomic) IBOutlet UIButton *optionD;

@property(nonatomic,strong)DropDownView * dropDownView;
- (IBAction)OptionA:(id)sender;
- (IBAction)OptionB:(id)sender;
- (IBAction)OptionC:(id)sender;
- (IBAction)OptionD:(id)sender;

@property(nonatomic,strong)NSString * QuizString;


@property (weak, nonatomic) IBOutlet UIButton *years;


@property (weak, nonatomic) IBOutlet UIButton *todayQuizBtn;



@property(nonatomic,strong)UIButton *aBtn,*bBtn,*cBtn,*dBtn;

@property(nonatomic,strong)NSMutableArray * btnArr,*SelectionArr, *selectedIndexArr;

@property(nonatomic,assign)int selectedBtn;

@property(nonatomic,strong)UIButton *button;





@property(nonatomic,strong)NSMutableArray * QuestionNameArr;
@property(nonatomic,strong)NSMutableArray * QuestionAnswerIDArr;
@property(nonatomic,strong)NSMutableArray * OptionNameArr;
@property(nonatomic,strong)NSMutableArray * OptionNameIDArr;
@property(nonatomic,strong)NSMutableArray * RightAnserIdArr;
@property(nonatomic,strong)NSNumber *todayQuizID;
@property(assign)int answercount;


//NSMutableArray * QuestionNameArr = [[NSMutableArray alloc] init];
//NSMutableArray * QuestionAnswerIDArr = [[NSMutableArray alloc] init];
//NSMutableArray * OptionNameArr = [[NSMutableArray alloc] init];
//NSMutableArray * OptionNameIDArr = [[NSMutableArray alloc] init];
//NSMutableArray * RightAnserIdArr = [[NSMutableArray alloc] init];

@property (nonatomic, strong) AbstractActionSheetPicker *actionSheetPicker;
@property (weak, nonatomic) IBOutlet UILabel *SelectEdition;
@property (nonatomic, strong) NSDate *selectedDate;
@property (weak, nonatomic) IBOutlet UILabel *yearsLbl;
@property (weak, nonatomic) IBOutlet UILabel *mnthLbl;


@property(nonatomic,strong)NSMutableArray *submitArr;
@property(nonatomic,strong)NSArray *pointsDataArr;

@end
