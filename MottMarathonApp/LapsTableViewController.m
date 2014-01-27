//
//  LapsTableViewController.m
//  MottMarathonApp
//
//  Created by Justin Bennett on 1/25/14.
//  Copyright (c) 2014 jkb7600. All rights reserved.
//

#import "LapsTableViewController.h"
#import "Lap.h"

@interface LapsTableViewController ()
@end

@implementation LapsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.laps count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Lap Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    Lap *lap = [self.laps objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%f",lap.timeAsDouble];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Lap %d", (int)indexPath.row +1];
    
    return cell;
}



@end
