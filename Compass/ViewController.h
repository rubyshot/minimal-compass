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

CLLocationManager *locationManager;

@interface ViewController : UIViewController <CLLocationManagerDelegate>{
    
}

@property (nonatomic, retain) CLLocationManager		*locationManager;


@property (strong, nonatomic) IBOutlet UIImageView *compassImage;
@property (strong, nonatomic) IBOutlet UILabel *magHeadingLabel;
@property (strong, nonatomic) IBOutlet UILabel *trueHeadingLabel;

@end
