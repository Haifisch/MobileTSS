//
//  MyDeviceTableViewController.m
//  TSS
//
//  Created by Haifisch on 5/11/14.
//  Copyright (c) 2014 Haifisch. All rights reserved.
//

#import "MyDeviceTableViewController.h"
#import <IOKit/IOKit.h>
#import "MobileGestalt.h"
@interface MyDeviceTableViewController () {
    NSMutableArray *listings;

}

@end

@implementation MyDeviceTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(id)getQueryWithValue:(CFStringRef)value {
    CFStringRef _value = (CFStringRef)MGCopyAnswer(value);
    return (__bridge NSString *)_value;
    CFRelease(_value);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    listings = [[NSMutableArray alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"NoResultsView"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"NoResultsCell"];

    NSLog(@"%@",[[UIDevice currentDevice] serialnumber]);
    UILabel *serialNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 430, 320,30)];
    serialNumber.text = [[UIDevice currentDevice] serialnumber];
    serialNumber.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
    serialNumber.textAlignment = NSTextAlignmentCenter;
    [self.tableView addSubview:serialNumber];
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
    // Return the number of sections.
    return 1;
}


-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    if ([listings count] == 0) {
        return 1; // a single cell to report no data
    }
    return [listings count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([listings count] == 0) {

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoResultsCell"];
        cell.backgroundColor = [UIColor clearColor];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        //cell.textLabel.text = @"No records to display";
        //whatever else to configure your one cell you're going to return
        return cell;
    }
    return nil;
    
    // go on about your business, you have listings to display
}

@end
