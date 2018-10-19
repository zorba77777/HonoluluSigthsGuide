//
//  ArtObject.m
//  PublicArt
//
//  Created by Timur Sasin on 30/09/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ArtObject.h"

@interface ArtObject ()

@end

@implementation ArtObject

- (instancetype)initWithDictionary:(NSMutableDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _access = [dictionary valueForKey: @"access"];
        _creator = [dictionary valueForKey: @"creator"];
        _credit = [dictionary valueForKey: @"credit"];
        _date = [dictionary valueForKey: @"date"];
        _descript = [dictionary valueForKey: @"description"];
        _discipline = [dictionary valueForKey: @"discipline"];
        _imagefile = [dictionary valueForKey: @"imagefile"];
        _latitude = [dictionary valueForKey: @"latitude"];
        _location = [dictionary valueForKey: @"location"];
        _longitude = [dictionary valueForKey: @"longitude"];
        _objectid = [dictionary valueForKey: @"objectid"];
        _title = [dictionary valueForKey: @"title"];
    }
    
    return self;
}



@end
