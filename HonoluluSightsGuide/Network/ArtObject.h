//
//  ArtObject.h
//  PublicArt
//
//  Created by Timur Sasin on 30/09/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

@interface ArtObject : NSObject

@property (nonatomic, strong, readwrite) NSString *access;

@property (nonatomic, strong, readwrite) NSString *creator;

@property (nonatomic, strong, readwrite) NSString *credit;

@property (nonatomic, strong, readwrite) NSString *date;

@property (nonatomic, strong, readwrite) NSString *descript;

@property (nonatomic, strong, readwrite) NSString *discipline;

@property (nonatomic, strong, readwrite) NSString *imagefile;

@property (nonatomic, strong, readwrite) NSString *latitude;

@property (nonatomic, strong, readwrite) NSString *location;

@property (nonatomic, strong, readwrite) NSString *longitude;

@property (nonatomic, strong, readwrite) NSString *objectid;

@property (nonatomic, strong, readwrite) NSString *title;

- (instancetype)initWithDictionary:(NSMutableDictionary *)dictionary;

@end
