//
//  MyTeevoViewController.m
//  Teevo
//
//  Created by MacBook on 21/09/13.
//  Copyright (c) 2013 Gaurav Bhardwaj. All rights reserved.
//

#import "MyTeevoViewController.h"

@interface MyTeevoViewController ()

@end

@implementation MyTeevoViewController
@synthesize mydata,bookScreens;
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

- (IBAction)btnBackFromMyTeevoAction:(id)sender {
    
    NSLog(@"btnBackFromMyTeevoAction");
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnMenuMyTeevoAction:(id)sender {
}

-(IBAction)nextButton:(id)sender

{
    
    NSLog(@"mai next mai hu");
    
    //bookScreens.image = [UIImage imageNamed:@"i_testify.png"];
    
    if(self.imageCount <=8 )
        
    {
        
        self.imageCount++;
        
    }
    
    
    
    NSLog(@"imageCount % i",self.imageCount);
    
    [self selectImage];
    
    
    
    
    
}

-(IBAction)prevButton:(id)sender

{
    
    NSLog(@"mai pre mai hu");
    
    if( self.imageCount > 0 )
        
    {
        
        self.imageCount--;
        
    }
    
    
    
    NSLog(@"imageCount % i",self.imageCount);
    
    
    
    [self selectImage];
    
    
    
}



-(void)selectImage

{
    
    if(self.imageCount == 0)
        
    {
        
        //bookScreens.image = [UIImage imageNamed:@"home_bg.jpg"];
        
        
        
        mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http:\/\/teevo.lpipl.com\/image\/myteevo\/NewCover1.jpg"]];
        
        UIImage *myimage = [[UIImage alloc] initWithData:mydata];
        
        bookScreens.image = myimage;
        
    }
    
    if(self.imageCount == 1)
        
    {
        
        // bookScreens.image = [UIImage imageNamed:@"i_testify.png"];
        
        
        
        mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http:\/\/teevo.lpipl.com\/image\/myteevo\/OCTOBERTeeVoPAG2.jpg"]];
        
        UIImage *myimage = [[UIImage alloc] initWithData:mydata];
        
        bookScreens.image = myimage;
        
    }
    
    
    
    if(self.imageCount == 2)
        
    {
        
        // bookScreens.image = [UIImage imageNamed:@"i_testify.png"];
        
        
        
        mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http:\/\/teevo.lpipl.com\/image\/myteevo\/OCTOBERTeeVoPAG3.jpg"]];
        
        UIImage *myimage = [[UIImage alloc] initWithData:mydata];
        
        bookScreens.image = myimage;
        
    }
    
    
    
    if(self.imageCount == 3)
        
    {
        
        // bookScreens.image = [UIImage imageNamed:@"i_testify.png"];
        
        
        
        mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http:\/\/teevo.lpipl.com\/image\/myteevo\/OCTOBERTeeVoPAG4.jpg"]];
        
        UIImage *myimage = [[UIImage alloc] initWithData:mydata];
        
        bookScreens.image = myimage;
        
    }
    
    
    
    if(self.imageCount == 4)
        
    {
        
        //bookScreens.image = [UIImage imageNamed:@"home_bg.jpg"];
        
        
        
        mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http:\/\/teevo.lpipl.com\/image\/myteevo\/OCTOBERTeeVoPAG5.jpg"]];
        
        UIImage *myimage = [[UIImage alloc] initWithData:mydata];
        
        bookScreens.image = myimage;
        
    }
    
    
    
    if(self.imageCount == 5)
        
    {
        
        //bookScreens.image = [UIImage imageNamed:@"home_bg.jpg"];
        
        
        
        mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http:\/\/teevo.lpipl.com\/image\/myteevo\/OCTOBERTeeVoPAG6.jpg"]];
        
        UIImage *myimage = [[UIImage alloc] initWithData:mydata];
        
        bookScreens.image = myimage;
        
    }
    
    
    
    if(self.imageCount == 6)
        
    {
        
        //bookScreens.image = [UIImage imageNamed:@"home_bg.jpg"];
        
        
        
        mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http:\/\/teevo.lpipl.com\/image\/myteevo\/OCTOBERTeeVoPAG7.jpg"]];
        
        UIImage *myimage = [[UIImage alloc] initWithData:mydata];
        
        bookScreens.image = myimage;
        
    }
    
    
    
    if(self.imageCount == 7)
        
    {
        
        //bookScreens.image = [UIImage imageNamed:@"home_bg.jpg"];
        
        
        
        mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http:\/\/teevo.lpipl.com\/image\/myteevo\/OCTOBERTeeVoPAG8a.jpg"]];
        
        UIImage *myimage = [[UIImage alloc] initWithData:mydata];
        
        bookScreens.image = myimage;
        
    }
    
    
    
    if(self.imageCount == 8)
        
    {
        
        //bookScreens.image = [UIImage imageNamed:@"home_bg.jpg"];
        
        
        
        mydata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http:\/\/teevo.lpipl.com\/image\/myteevo\/OCTOBERTeeVoPAG9.jpg"]];
        
        UIImage *myimage = [[UIImage alloc] initWithData:mydata];
        
        bookScreens.image = myimage;
        
    }
    
}


@end
