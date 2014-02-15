//
//  ViewController.m
//  Compass
//
//  Created by Adam Noden on 15/02/2014.
//  Copyright (c) 2014 Adam Noden. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize locationManager, magHeadingLabel, trueHeadingLabel;


- (void)viewDidLoad
{
    locationManager=[[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.headingFilter = 1;
    locationManager.delegate=self;
    //Start the compass updates.
    [locationManager startUpdatingHeading];
    
    
    
    [super viewDidLoad];
	
}


- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
	
  
    // Convert Degree to Radian
	float oldRad =  -manager.heading.trueHeading * M_PI / 180.0f;
	float newRad =  -newHeading.trueHeading * M_PI / 180.0f;
    
    // needle spin animation
    CABasicAnimation *theAnimation;
	theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	theAnimation.fromValue = [NSNumber numberWithFloat:oldRad];
	theAnimation.toValue=[NSNumber numberWithFloat:newRad];
	theAnimation.duration = 0.5f;
    
    // applying the animation
	[_compassImage.layer addAnimation:theAnimation forKey:@"animateMyRotation"];
	_compassImage.transform = CGAffineTransformMakeRotation(newRad);
	
    // setting labels to headings
    self.magHeadingLabel.text =     [NSString stringWithFormat:@"%f", newHeading.magneticHeading];
    self.trueHeadingLabel.text =    [NSString stringWithFormat:@"%f", newHeading.trueHeading];
    
    // dev stuff
    NSLog(@"New magnetic heading: %f", newHeading.magneticHeading);
	NSLog(@"New true heading: %f", newHeading.trueHeading);
    NSLog(@"%f (%f) => %f (%f)", manager.heading.trueHeading, oldRad, newHeading.trueHeading, newRad);

    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
