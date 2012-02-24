//
//  GFFirstViewController.m
//  
//
//  Created by Bruno Fuster Martins Silva on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GFFirstViewController.h"
#import "SampleItem.h"

@implementation GFFirstViewController

@synthesize remoteCall,tableView, items;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setTitle:@"Items"];
    
    self.items = [NSArray new];
    self.remoteCall = [[RemoteCall alloc] initWithDelegate:self];
    [remoteCall get:@"http://json-mock.appspot.com/5001"];
}

#pragma mark - Remote Call

- (void) response:(Response *)response {
    
    NSLog(@"response code: %d", [response code]);
    self.items = [response resource];
    [self.tableView reloadData];
}

#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemsCell";
    
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    SampleItem *item = [self.items objectAtIndex:indexPath.row]; 
    cell.textLabel.text = item.title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table View counters

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}


@end
