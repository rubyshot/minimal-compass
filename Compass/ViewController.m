//
//  ViewController.m
//  Compass
//
//  Created by Adam Noden on 15/02/2014.
//  Copyright (c) 2014 Adam Noden. All rights reserved.
//

#import "ViewController.h"


@interface ViewController()

@end

@implementation ViewController

@synthesize locationManager, compassImage, trueHeadingLabel, pointerImage, InfoViewButton, calibrationLabel;


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    livePointerImage = [UIImage imageNamed: @"livePointer"];
    blankPointerImage = [UIImage imageNamed: @"pointer"];
    
    // device detection and UI positioning
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone Classic
            [self positionUI];
            
        }
        if(result.height == 568)
        {
            // iPhone 5
            [self positionUI_IPHONE5];
        }
    }
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    } else {
        // iOS 6
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    }
    
    // set up compass stuff
    locationManager=[[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.headingFilter = 1;
    locationManager.delegate=self;
    
    // start the compass
    [locationManager startUpdatingHeading];
    
  
	
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


-(void) positionUI{
    
    float midpointX = self.view.frame.size.width/2;
    float midpointY = self.view.frame.size.height/2;
    
    trueHeadingLabel.center = CGPointMake(midpointX, midpointY-145);
    pointerImage.center = CGPointMake(midpointX, midpointY-110);
    InfoViewButton.center = CGPointMake(midpointX, midpointY+190);
    
}

-(void) positionUI_IPHONE5{
    
    float midpointX = self.view.frame.size.width/2;
    float midpointY = self.view.frame.size.height/2;
    
    trueHeadingLabel.center = CGPointMake(midpointX, midpointY-170);
    pointerImage.center = CGPointMake(midpointX, midpointY-135);
    InfoViewButton.center = CGPointMake(midpointX, midpointY+240);
    
}


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    
    // Convert Degree to Radian
    // Multypli by -1 to twist opposite to phone rotation
	float oldRad =  -manager.heading.trueHeading * M_PI / 180.0f;
	float newRad =  -newHeading.trueHeading * M_PI / 180.0f;
    
    // creating needle spin animation
    CABasicAnimation *theAnimation;
	theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	theAnimation.fromValue = [NSNumber numberWithFloat:oldRad];
	theAnimation.toValue=[NSNumber numberWithFloat:newRad];
	theAnimation.duration = 0.5f;
    
    // applying the animation
	[compassImage.layer addAnimation:theAnimation forKey:@"animateMyRotation"];
	compassImage.transform = CGAffineTransformMakeRotation(newRad);
	
    // setting labels to heading
    trueHeadingLabel.text =    [NSString stringWithFormat:@"%i°", (int)(newHeading.trueHeading)];
    
    // change pointer on north to red
    if((int)(newHeading.trueHeading)==0){
        [pointerImage setImage:livePointerImage];
    }else{
        [pointerImage setImage:blankPointerImage];
    }
    
    // calibration label
    calibrationLabel.text = [NSString stringWithFormat:@"%i", (int)(manager.heading)];
    
    // console print of heading
	NSLog(@"True heading: %f", newHeading.trueHeading);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)InfoViewButton:(id)sender {
    [self performSegueWithIdentifier:@"InfoView" sender:self];
}


//- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager*)manager {
//    
//    if(!manager.heading) return YES; // Got nothing, We can assume we got to calibrate.
//    else if( manager.heading < 0 ) return YES; // 0 means invalid heading, need to calibrate
//    else if( manager.heading > 5 )return YES; // 5 degrees is a small value correct for my needs, too.
//    else return NO; // All is good. Compass is precise enough.
//}


@end
