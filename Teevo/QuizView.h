//
//  QuizView.h
//  Teevo
//
//  Created by Capgemini on 12/10/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCRadioButton.h"

@interface QuizView : UIView
{
    
}
@property (strong, nonatomic) NSDictionary * sourceData;
@property (strong, nonatomic) NSString *rightAnsId;
@property (strong, nonatomic) IBOutlet UILabel *questNo;
@property (strong, nonatomic) IBOutlet UILabel *question;
@property (strong, nonatomic) IBOutlet UILabel *opt1;
@property (strong, nonatomic) IBOutlet UILabel *opt2;
@property (strong, nonatomic) IBOutlet UILabel *opt3;
@property (strong, nonatomic) IBOutlet UILabel *opt4;
@property (strong, nonatomic) IBOutlet VCRadioButton *radiobtn1;
@property (strong, nonatomic) IBOutlet VCRadioButton *radiobtn3;
@property (strong, nonatomic) IBOutlet VCRadioButton *radiobtn2;
@property (strong, nonatomic) IBOutlet VCRadioButton *radiobtn4;

@end
