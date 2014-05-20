//
//  ViewController.h
//  Compass
//
//  Created by Adam Noden on 15/02/2014.
//  Copyright (c) 2014 Adam Noden. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>


UIImage *livePointerImage;
UIImage *blankPointerImage;

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager		*locationManager;
@property (nonatomic, retain) IBOutlet UIImageView *compassImage;
@property (nonatomic, retain) IBOutlet UILabel *trueHeadingLabel;
@property (nonatomic, retain) IBOutlet UIImageView *pointerImage;
@property (strong, nonatomic) IBOutlet UIButton *InfoViewButton;
@property (strong, nonatomic) IBOutlet UILabel *calibrationLabel;

- (IBAction)InfoViewButton:(id)sender;




@end
