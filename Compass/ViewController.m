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

@synthesize locationManager, compassImage, trueHeadingLabel, pointerImage, InfoViewButton, calibrationLabel, calibrationCheck, signal;


- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // declare images to be used for pointer
    livePointerImage = [UIImage imageNamed: @"livePointer"];
    blankPointerImage = [UIImage imageNamed: @"pointer"];
    
    // Declaring calibration bar images
    goodSignal = [UIImage imageNamed: @"goodSignal"];
    weakSignal = [UIImage imageNamed: @"weakSignal"];
    noSignal = [UIImage imageNamed: @"noSignal"];
    
    
    // initialize calibration label
    calibrationCheck.hidden = NO;
    calibrationCheck.alpha = 0.0f;
    calibrationCheck.numberOfLines = 0;
    
    noHead = [NSString stringWithFormat:@"Strong magnetic interference"];
    weakHead = [NSString stringWithFormat:@"Some magnetic interference"];
    twistPhone = [NSString stringWithFormat:@"Twist phone to calibrate"];
    
    
    // device detection and UI positioning
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            // iPhone Classic
            [self positionUI_IPHONE4];
            
        }
        if(result.height == 568)
        {
            // iPhone 5
            [self positionUI_IPHONE5];
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


-(void) positionUI_IPHONE4{
    
    float midpointX = self.view.frame.size.width/2;
    float midpointY = self.view.frame.size.height/2;
    
    trueHeadingLabel.center = CGPointMake(midpointX+5, midpointY-170);
    pointerImage.center = CGPointMake(midpointX, midpointY-135);
    InfoViewButton.center = CGPointMake(self.view.frame.size.width-50, self.view.frame.size.height-50);
    signal.center = CGPointMake(50, self.view.frame.size.height-50);
    calibrationCheck.center = CGPointMake(midpointX, 35);
    
}

-(void) positionUI_IPHONE5{
    
    float midpointX = self.view.frame.size.width/2;
    float midpointY = self.view.frame.size.height/2;
    
    trueHeadingLabel.center = CGPointMake(midpointX+5, midpointY-170);
    pointerImage.center = CGPointMake(midpointX, midpointY-135);
    InfoViewButton.center = CGPointMake(self.view.frame.size.width-50, self.view.frame.size.height-50);
    signal.center = CGPointMake(50, self.view.frame.size.height-50);
    calibrationCheck.center = CGPointMake(midpointX, 45);
    
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
    
    // calibration check (dev)
    // calibrationLabel.text = [NSString stringWithFormat:@"%f", manager.heading.headingAccuracy];
    
    
    
    // calibration check
    if(!manager.heading.headingAccuracy){
        
        calibrationCheck.text = [NSString stringWithFormat:@"%@\r%@", noHead, twistPhone];
        
        [signal setBackgroundImage:noSignal forState:UIControlStateNormal];
        
    
    }
    else if(manager.heading.headingAccuracy<0){
        
        calibrationCheck.text = [NSString stringWithFormat:@"%@\r%@", noHead, twistPhone];
        
        [signal setBackgroundImage:noSignal forState:UIControlStateNormal];
        
      
    }
    else if(manager.heading.headingAccuracy>30){
        
        calibrationCheck.text = [NSString stringWithFormat:@"%@\r%@", noHead, twistPhone];
        
        [signal setBackgroundImage:noSignal forState:UIControlStateNormal];
        
    }
    else if(manager.heading.headingAccuracy>10){
        
        calibrationCheck.text = [NSString stringWithFormat:@"%@\r%@", weakHead, twistPhone];
        
        [signal setBackgroundImage:weakSignal forState:UIControlStateNormal];
   
    }
    else if(manager.heading.headingAccuracy<=10){
        calibrationCheck.text = [NSString stringWithFormat:@"Clear reading"];
        
        [signal setBackgroundImage:goodSignal forState:UIControlStateNormal];
 
    }

    
    // console print of heading
	NSLog(@"True heading: %f", newHeading.trueHeading);
    
}

-(void) showCalibrationMessage{
   
    calibrationCheck.hidden = NO;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        calibrationCheck.alpha = 1.0f;
    } completion:^(BOOL finished) {}
    ];
}

-(void) hideCalibrationMessage{
    
    calibrationCheck.hidden = NO;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        // Animate the alpha value of your imageView from 1.0 to 0.0 here
        calibrationCheck.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        // Once the animation is completed and the alpha has gone to 0.0, hide the view for good
        calibrationCheck.hidden = YES;
        
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)InfoViewButton:(id)sender {
    [self performSegueWithIdentifier:@"InfoView" sender:self];
}

- (IBAction)signalButton:(id)sender {
    
    if(calibrationCheck.hidden){
        [self showCalibrationMessage];
    }
    else{
        [self hideCalibrationMessage];
    }
}




//- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager*)manager {
//    
//    if(!manager.heading) return YES; // Got nothing, We can assume we got to calibrate.
//    else if( manager.heading < 0 ) return YES; // 0 means invalid heading, need to calibrate
//    else if( manager.heading > 5 )return YES; // 5 degrees is a small value correct for my needs, too.
//    else return NO; // All is good. Compass is precise enough.
//}


@end
