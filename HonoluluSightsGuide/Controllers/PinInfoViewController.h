//
//  PinInfoViewController.h
//  PublicArt
//
//  Created by Timur Sasin on 01/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"

@interface PinInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *infoTitle;

@property (weak, nonatomic) IBOutlet UILabel *country;

@property (weak, nonatomic) IBOutlet UILabel *postalCode;

@property (weak, nonatomic) IBOutlet UILabel *locality;

@property (nonatomic, strong) MyAnnotation *annotation;

@property (nonatomic, strong) CLGeocoder *myGeocoder;

@end
