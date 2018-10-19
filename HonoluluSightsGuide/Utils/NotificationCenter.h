//
//  NotificationCenter.h
//  HonoluluSightsGuide
//
//  Created by Timur Sasin on 14/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct Notification {
    __unsafe_unretained NSString * _Nullable title;
    __unsafe_unretained NSString * _Nonnull body;
    __unsafe_unretained NSDate * _Nonnull date;
} Notification;

@interface NotificationCenter : NSObject

+ (instancetype _Nonnull)sharedInstance;

- (void)registerService;
- (void)sendNotification:(Notification)notification;

Notification NotificationMake(NSString* _Nullable title, NSString* _Nonnull body, NSDate* _Nonnull date);

@end
