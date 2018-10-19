//
//  ArtObjectMO.h
//  HonoluluSightsGuide
//
//  Created by Timur Sasin on 10/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ArtObjectMO : NSManagedObject

@property (nonatomic, strong) NSString *access;

@property (nonatomic, strong) NSString *creator;

@property (nonatomic, strong) NSString *credit;

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSString *descript;

@property (nonatomic, strong) NSString *discipline;

@property (nonatomic, strong) NSString *imagefile;

@property (nonatomic, strong) NSString *latitude;

@property (nonatomic, strong) NSString *location;

@property (nonatomic, strong) NSString *longitude;

@property (nonatomic, strong) NSString *objectid;

@property (nonatomic, strong) NSString *title;

@end
