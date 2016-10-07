//
//  InfoViewController.m
//  Compass
//
//  Created by Adam Noden on 19/05/2014.
//  Copyright (c) 2014 Adam Noden. All rights reserved.
//

#import "InfoViewController.h"

#define IS_IPHONE ( [[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height >= 568.0f
#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568 )

@interface InfoViewController ()

@end


@implementation InfoViewController

@synthesize BackButton;

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
    
    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone Classic
            BackButton.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2+190);
            
        }
        if(result.height == 568)
        {
            // iPhone 5
       
        }
    }
    
    // hide status bar
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)TwitterButton:(id)sender {

    
    NSURL *urlApp = [NSURL URLWithString: [NSString stringWithFormat:@"%@", @"twitter:///user?screen_name=AdamNoden"]];
    
    NSURL *urlBackup = [NSURL URLWithString: [NSString stringWithFormat:@"%@", @"https://mobile.twitter.com/AdamNoden"]];
    
    if([[UIApplication sharedApplication] canOpenURL:urlApp]){
        [[UIApplication sharedApplication] openURL:urlApp];
    } else {
        [[UIApplication sharedApplication] openURL:urlBackup];
    }
    

}


@end
