//
//  TableViewController.m
//  HonoluluSightsGuide
//
//  Created by Timur Sasin on 13/10/2018.
//  Copyright © 2018 Timur Sasin. All rights reserved.
//

#import "FavoritesTableViewController.h"
#import "CoreDataHelper.h"
#import "ArtObjectMO+CoreDataClass.h"
#import "ArtObjectMO+CoreDataProperties.h"

@interface FavoritesTableViewController ()

@property (nonatomic, strong, readwrite) NSArray *sourceArray;

@end

@implementation FavoritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.sourceArray = [[CoreDataHelper sharedInstance] favorites];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    ArtObjectMO *object = [self.sourceArray objectAtIndex:indexPath.row];
    
    cell.textLabel.text = object.title;
    
    return cell;
}

@end
