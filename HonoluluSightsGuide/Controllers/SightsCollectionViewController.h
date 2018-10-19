//
//  SightsCollectionViewController.h
//  PublicArt
//
//  Created by Timur Sasin on 07/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface SightsCollectionViewController : UICollectionViewController <UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, UIGestureRecognizerDelegate>

@property (strong, nonatomic) UISearchController *searchController;
@property (nonatomic, strong, readwrite) NSArray *dataArray;
@property (nonatomic, strong, readwrite) NSArray *resultsArray;
@property (nonatomic, strong, readwrite) NSArray *sourceArray;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UITextField *dateTextField;

@end
