//
//  ViewController.m
//  PublicArt
//
//  Created by Timur Sasin on 30/09/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MapViewController.h"
#import "DataManager.h"
#import "ArtObject.h"
#import "MyAnnotation.h"
#import "PinInfoViewController.h"
#import "FirstViewController.h"

@interface MapViewController () <MKMapViewDelegate>

@property (nonatomic, strong, readwrite) NSArray *objects;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    [self presentFirstViewControllerIfNeeded];
}

- (void)presentFirstViewControllerIfNeeded
{
    BOOL isFirstStart = [[NSUserDefaults standardUserDefaults] boolForKey:@"first_start"];
    if (!isFirstStart) {
        FirstViewController *firstViewController = [[FirstViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        [self presentViewController:firstViewController animated:YES completion:nil];
    }
}


- (void)configure {
    self.view.backgroundColor = [UIColor whiteColor];
    self.myMapView.delegate = self;
    [self loadData];
    [self setRegion];
    [self setAnnotations];
}

-(void)loadData {
    [[DataManager shared] loadData];
    _objects = [[DataManager shared] artObjects];
}

-(void)setRegion {
    ArtObject *object = [_objects objectAtIndex:7];
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([object.latitude doubleValue], [object.longitude doubleValue]);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 60000, 60000);
    [_myMapView setRegion:region animated:YES];
}

-(void)setAnnotations {
    
    for (ArtObject *object in _objects) {
        
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([object.latitude doubleValue], [object.longitude doubleValue]);
        MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinates:location title:object.title subTitle:object.descript];
        [self.myMapView addAnnotation:annotation];
        
    }
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    for (MKAnnotationView *anAnnotationView in views) {
        [anAnnotationView setCanShowCallout:YES];
        [anAnnotationView addObserver:self
                           forKeyPath:@"selected"
                              options:NSKeyValueObservingOptionNew
                              context:@"mapAnnotationSelectedOrDeselected"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    NSString *action = (__bridge NSString *)context;
    if ([action isEqualToString:@"mapAnnotationSelectedOrDeselected"]) {
        BOOL annotationSelected = [[change valueForKey:@"new"] boolValue];
        if (annotationSelected) {
            NSLog(@"Annotation was selected, do whatever required");
            MKAnnotationView *view = object;
            MyAnnotation *annotation = view.annotation;
            [self performSegueWithIdentifier:@"showPinInfo" sender: annotation];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showPinInfo"]) {
        
        PinInfoViewController *viewController = [segue destinationViewController];
        
        MyAnnotation *annotation = sender;
        
        viewController.annotation = annotation;
    }
}

@end
