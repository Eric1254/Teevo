//
//  TReaderCell.m
//  Teevo
//
//  Created by MacBook on 19/10/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import "TReaderCell.h"

@implementation TReaderCell
@synthesize cellDelegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btnBookPressed:(id)sender {
    [self.cellDelegate btnBookPressed:sender];
}
- (IBAction)btnViewAllAction:(id)sender {
    
    [self.cellDelegate btnViewAllAction:sender];
}
@end
