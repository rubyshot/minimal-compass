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

UIImage* goodSignal;
UIImage* weakSignal;
UIImage* noSignal;

NSString* noHead;
NSString* twistPhone;
NSString* weakHead;

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager		*locationManager;
@property (nonatomic, retain) IBOutlet UIImageView *compassImage;
@property (nonatomic, retain) IBOutlet UILabel *trueHeadingLabel;
@property (nonatomic, retain) IBOutlet UIImageView *pointerImage;
@property (strong, nonatomic) IBOutlet UIButton *InfoViewButton;
@property (strong, nonatomic) IBOutlet UILabel *calibrationLabel;
@property (strong, nonatomic) IBOutlet UILabel *calibrationCheck;
@property (strong, nonatomic) IBOutlet UIButton *signal;

- (IBAction)InfoViewButton:(id)sender;
- (IBAction)signalButton:(id)sender;




@end
