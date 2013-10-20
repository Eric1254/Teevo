//
//  PleaseWait.m
//  MBYoga
//
//  Created by Emmanuel Francis on 29/06/11.
//  Copyright 2011 Geoff Thompson. All rights reserved.
//

#import "PleaseWait.h"
	

@implementation PleaseWait

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[activitiIndicator startAnimating];
	[self.view setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
	//self.view.backgroundColor = [UIColor colorWithRed:51/255.0f green:51/255.0f blue:51/255.0f alpha:1.0];
    
    self.view.backgroundColor = [UIColor colorWithRed:166/255.0f green:75/255.0f blue:130/255.0f alpha:1.0];
	self.view.userInteractionEnabled= NO;
	
}




// Override to allow orientations other than the default portrait orientation.
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    // Return YES for supported orientations.
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//    //return NO;
//}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	[activitiIndicator stopAnimating];
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}





@end
