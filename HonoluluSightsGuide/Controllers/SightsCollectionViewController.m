//
//  SightsCollectionViewController.m
//  PublicArt
//
//  Created by Timur Sasin on 07/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import "SightsCollectionViewController.h"

#import "DataManager.h"
#import "ArtObject.h"
#import "SightsCollectionViewCell.h"
#import "SightsCollectionHeaderView.h"
#import "CoreDataHelper.h"
#import "NotificationCenter.h"

@interface SightsCollectionViewController ()


@property (nonatomic, strong, readwrite) SightsCollectionHeaderView *headerView;

@end

@implementation SightsCollectionViewController {
    SightsCollectionViewCell *notificationCell;

}

static NSString * const reuseIdentifier = @"sightsCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configure];    
}

- (void)configure {
    [self loadData];
    [self addSearchTools];
    [self addLongGestureRecognizerTools];
    [self addDatePickerTools];
    
}

-(void)loadData {
    [[DataManager shared] loadData];
    _dataArray = [[DataManager shared] artObjects];
    [self.collectionView reloadData];
}

- (void)addSearchTools {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = YES;
    self.searchController.searchBar.delegate = self;
    [self.searchController.searchBar setReturnKeyType:UIReturnKeyDone];
    self.searchController.searchBar.enablesReturnKeyAutomatically = NO;
    self.definesPresentationContext = YES;
    [self.searchController.searchBar sizeToFit];
}

- (void)addLongGestureRecognizerTools {
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.delegate = self;
    lpgr.delaysTouchesBegan = YES;
    [self.collectionView addGestureRecognizer:lpgr];
}

- (void)addDatePickerTools {
    _datePicker = [[UIDatePicker alloc] init];
    _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    _datePicker.minimumDate = [NSDate date];
    
    _dateTextField = [[UITextField alloc] initWithFrame:self.view.bounds];
    _dateTextField.hidden = YES;
    _dateTextField.inputView = _datePicker;
    
    UIToolbar *keyboardToolbar = [[UIToolbar alloc] init];
    [keyboardToolbar sizeToFit];
    UIBarButtonItem *flexBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidTap:)];
    keyboardToolbar.items = @[flexBarButton, doneBarButton];
    
    _dateTextField.inputAccessoryView = keyboardToolbar;
    [self.view addSubview:_dateTextField];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SightsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    ArtObject *object = [self.sourceArray objectAtIndex:indexPath.row];

    cell.sightTitle.text = object.title;
    cell.sightDescription.text = object.descript;
    
    return cell;
}

- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    _headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    [_headerView addSubview:self.searchController.searchBar];
    
    _headerView.controller = self;
    
    return _headerView;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {}

- (NSArray *)sourceArray {
    return (_searchController.isActive) ? _resultsArray : _dataArray;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchString = _searchController.searchBar.text;
    if (searchString.length) {
        NSString *strippedString = [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(ArtObject *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject.title hasPrefix:strippedString];
        }];
        _resultsArray = [_dataArray filteredArrayUsingPredicate:predicate];
    } 
    [self.collectionView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.sourceArray = _dataArray;
    [self.collectionView reloadData];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint point = [gestureRecognizer locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        
        NSArray *array = self.sourceArray;
        
        ArtObject *object = [array objectAtIndex:indexPath.item];

        
        UIAlertController *actionView = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"add_to_favorites_alert_title", @"") message:NSLocalizedString(@"add_to_favorites_alert_text", @"") preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
            
            if (![[CoreDataHelper sharedInstance] isFavorite: object]) {
                [[CoreDataHelper sharedInstance] addToFavorite: object];
                [self showAnimation];
            }
        }];
        
        UIAlertAction *notificationAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"remind_alert_title", @"") style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            self->notificationCell = [self.collectionView cellForItemAtIndexPath:indexPath];
            [self.dateTextField becomeFirstResponder];
        }];

        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"dismiss_alert_title", @"") style:UIAlertActionStyleCancel handler:nil];
        
        [actionView addAction:ok];
        [actionView addAction:notificationAction];
        [actionView addAction:cancel];
        
        [self presentViewController:actionView animated:YES completion:nil];
       
    }
}

- (void)showAnimation {
    UILabel *notificationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 50)];
    notificationLabel.center = self.view.center;
    [notificationLabel setBackgroundColor:[UIColor redColor]];
    [notificationLabel setText:NSLocalizedString(@"notification_label_text", @"")];
    [notificationLabel setAlpha:0.0];
    [[self view] addSubview:notificationLabel];
    
    [UIView animateWithDuration:1.0
                          delay:0
                        options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                     animations:^(void) {
         [notificationLabel setAlpha:1.0];
     } completion:^(BOOL finished) {
         if(finished) {
             [UIView animateWithDuration:1.5
                                   delay:4
                                 options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                              animations:^(void) {
                  [notificationLabel setAlpha:0.0];
                              } completion:^(BOOL finished) {
                                  [notificationLabel removeFromSuperview];
                              }];
             }
     }];
}

- (void)doneButtonDidTap:(UIBarButtonItem *)sender
{
    if (_datePicker.date && notificationCell) {
        NSString *message = [NSString stringWithFormat:@"%@ - %@", notificationCell.sightTitle.text, notificationCell.sightDescription.text];
        
        Notification notification = NotificationMake(NSLocalizedString(@"notification_title", @""), message, _datePicker.date);
        [[NotificationCenter sharedInstance] sendNotification:notification];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"success_alert_title", @"") message:[NSString stringWithFormat:@"Notification will be sent - %@", _datePicker.date] preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"dismiss_alert_title", @"") style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    _datePicker.date = [NSDate date];
    notificationCell = nil;
    [self.view endEditing:YES];
}


@end
