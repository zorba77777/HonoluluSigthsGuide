//
//  DataManager.m
//  PublicArt
//
//  Created by Timur Sasin on 30/09/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DataManager.h"
#import "ArtObject.h"

@interface DataManager ()

@property (nonatomic, strong, readwrite) NSArray *artObjects;

@end

#define API_URL @"https://data.honolulu.gov/resource/csir-pcj2.json"

@implementation DataManager

+(instancetype)shared
{
    static DataManager *instance;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[DataManager alloc] init];
    });
    
    return instance;
}

-(void)loadData
{
    NSError *error;
    NSString *url_string = [NSString stringWithFormat: API_URL];
    NSData *data = [NSData dataWithContentsOfURL: [NSURL URLWithString: url_string]];
    NSMutableArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    _artObjects = [self createObjectsFromArray: json];
    
}

- (NSMutableArray *)createObjectsFromArray:(NSArray *)array
{
    NSMutableArray *results = [NSMutableArray new];
    
    for (NSMutableDictionary *jsonObject in array) {
        ArtObject *object = [[ArtObject alloc] initWithDictionary: jsonObject];
        [results addObject: object];
    }
    
    return results;
}


@end
