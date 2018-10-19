//
//  PinInfoViewController.m
//  PublicArt
//
//  Created by Timur Sasin on 01/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import "PinInfoViewController.h"

@interface PinInfoViewController ()

@end

@implementation PinInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

- (void)configure {
    self.infoTitle.text = self.annotation.title;
    [self setLocation];
}

-(void)setLocation {
    
    CLLocation *location =[[CLLocation alloc] initWithLatitude:self.annotation.coordinate.latitude longitude:self.annotation.coordinate.longitude];
    
    self.myGeocoder = [[CLGeocoder alloc] init];
    
    [self.myGeocoder
     reverseGeocodeLocation:location
     completionHandler:^(NSArray *placemarks, NSError *error) {
         
         if (error == nil && placemarks.count > 0) {
             CLPlacemark *placemark = placemarks[0];
             self.country.text = placemark.country;
             self.postalCode.text = placemark.postalCode;
             self.locality.text = placemark.locality;
         } else if (error == nil && [placemarks count] == 0) {
             NSLog(@"No results were returned.");
         } else if (error != nil) {
             NSLog(@"An error occured = %@", error);
         }
     }];
}
@end
