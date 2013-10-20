//
//  MyPhotoViewController.m
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import "MyPhotoViewController.h"

@interface MyPhotoViewController ()

@end

@implementation MyPhotoViewController

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

- (void)setupHorizontalScrollView
{
    /*
    self.scrollPhoto.delegate = self;
    
    [self.scrollPhoto setBackgroundColor:[UIColor blackColor]];
    [self.scrollPhoto setCanCancelContentTouches:NO];
    
    self.scrollPhoto.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.scrollPhoto.clipsToBounds = NO;
    self.scrollPhoto.scrollEnabled = YES;
    self.scrollPhoto.pagingEnabled = YES;
    
    NSUInteger nimages = 0;
    NSInteger tot=0;
    CGFloat cx = 0;
    for (; ; nimages++) {
        NSString *imageName = [NSString stringWithFormat:@"image%d.jpg", (nimages + 1)];
        UIImage *image = [UIImage imageNamed:imageName];
        if (tot==15) {
            break;
        }
        if (4==nimages) {
            nimages=0;
        }
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        CGRect rect = imageView.frame;
        rect.size.height = 40;
        rect.size.width = 40;
        rect.origin.x = cx;
        rect.origin.y = 0;
        
        imageView.frame = rect;
        
        [self.scrollPhoto addSubview:imageView];

        
        cx += imageView.frame.size.width+5;
        tot++;
    }
    

    [self.scrollPhoto setContentSize:CGSizeMake(cx, [self.scrollPhoto bounds].size.height)];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackFromMyPhotoAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnMenuMyPhotoAction:(id)sender {
}
- (IBAction)btnAcceptAction:(id)sender {
}

- (IBAction)btnUploadMyPhotoAction:(id)sender {
}

- (IBAction)btnSubmitMyPhotoAction:(id)sender {
}
@end
