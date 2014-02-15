//
//  LapsTableViewController.m
//  MottMarathonApp
//
//  Created by Justin Bennett on 1/25/14.
//  Copyright (c) 2014 jkb7600. All rights reserved.
//

#import "LapsTableViewController.h"
#import "Lap.h"
#import "lapViewCell.h"

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
    self.tableView.separatorColor = [UIColor clearColor];
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
    return ([self.laps count] * 2);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!(indexPath.row % 2)) {
		return 60;
	} else {
		return 10;
	}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if((indexPath.row %2)){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvisibleCellID" forIndexPath:indexPath];
        cell.opaque = 0;
        return cell;
    }else{
        static NSString *CellIdentifier = @"Lap Cell";
        //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        lapViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        // Configure the cell...
        NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row/2 inSection:indexPath.section];
        Lap *lap = [self.laps objectAtIndex:index.row];
        cell.lapCount.text = [NSString stringWithFormat:@"%ld", index.row +1];
        cell.lapTime.text = [NSString stringWithFormat:@"%@",lap.timeAsString];
        return cell;
    }
    
}



@end
