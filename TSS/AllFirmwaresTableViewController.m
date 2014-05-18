//
//  AllFirmwaresTableViewController.m
//  TSS
//
//  Created by Haifisch on 5/11/14.
//  Copyright (c) 2014 Haifisch. All rights reserved.
//

#import "AllFirmwaresTableViewController.h"

@interface AllFirmwaresTableViewController ()
{
    NSMutableDictionary *jsonArray;
    NSMutableArray *deviceNames;
}

@end

@implementation AllFirmwaresTableViewController

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
    
    deviceNames = [[NSMutableArray alloc] init];
    jsonArray = [[NSMutableDictionary alloc] init];
    
    NSError *err;
    jsonArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.ineal.me/tss/all"]] options:0 error:&err];
    if (err == nil) {
        [self.tableView reloadData];
        for (NSString *currentString in jsonArray) {
            [deviceNames addObject:currentString];
        }
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"iPhone";
            break;
            
        case 1:
            return @"iPad";
            break;
            
        case 2:
            return @"iPod";
            break;
            
        case 3:
            return @"Apple TV";
            break;
            
        default:
            return @"Others";
            break;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return [NSString stringWithFormat:@"%d Devices being signed",[deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPhone).*'"]].count];
            break;
            
        case 1:
            return [NSString stringWithFormat:@"%d Devices being signed",[deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPad).*'"]].count];
            break;
            
        case 2:
            return [NSString stringWithFormat:@"%d Devices being signed",[deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPod).*'"]].count];
            break;
            
        case 3:
            return [NSString stringWithFormat:@"%d Devices being signed",[deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(AppleTV).*'"]].count];
            break;
            
        default:
            return @"";
            break;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return [deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPhone).*'"]].count;
            break;
            
        case 1:
            return [deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPad).*'"]].count;
            break;
            
        case 2:
            return [deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPod).*'"]].count;
            break;
            
        case 3:
            return [deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(AppleTV).*'"]].count;
            break;
            
        default:
            return 0;
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceInformationCell" forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0: {
            NSArray *iPhones = [deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPhone).*'"]];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",iPhones[indexPath.row],[[jsonArray objectForKey:iPhones[indexPath.row]] objectForKey:@"board"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@) is being signed",[[[[jsonArray objectForKey:iPhones[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"version"],[[[[jsonArray objectForKey:iPhones[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"build"]];
        }
            break;
            
        case 1: {
            NSArray *iPads = [deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPad).*'"]];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",iPads[indexPath.row],[[jsonArray objectForKey:iPads[indexPath.row]] objectForKey:@"board"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@) is being signed",[[[[jsonArray objectForKey:iPads[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"version"],[[[[jsonArray objectForKey:iPads[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"build"]];
        }

            break;
            
        case 2: {
            NSArray *iPods = [deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPod).*'"]];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",iPods[indexPath.row],[[jsonArray objectForKey:iPods[indexPath.row]] objectForKey:@"board"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@) is being signed",[[[[jsonArray objectForKey:iPods[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"version"],[[[[jsonArray objectForKey:iPods[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"build"]];
        }
            break;
            
        case 3: {
            NSArray *appleTVs = [deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(AppleTV).*'"]];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",appleTVs[indexPath.row],[[jsonArray objectForKey:appleTVs[indexPath.row]] objectForKey:@"board"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@) is being signed",[[[[jsonArray objectForKey:appleTVs[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"version"],[[[[jsonArray objectForKey:appleTVs[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"build"]];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
