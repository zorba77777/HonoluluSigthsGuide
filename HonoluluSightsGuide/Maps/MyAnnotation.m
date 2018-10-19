//
//  MyAnnotation.m
//  PublicArt
//
//  Created by Timur Sasin on 01/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

- (instancetype)initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)paramTitle subTitle:(NSString *)paramSubtitle {
    
    self = [super init];
    
    if (self != nil) {
        _coordinate = paramCoordinates;
        _title = paramTitle;
        _subtitle = paramSubtitle;
    }
    
    return (self);
}

@end
