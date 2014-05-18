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
    NSMutableArray *iPhoneArray;
    NSMutableArray *iPadArray;
    NSMutableArray *iPodArray;

    NSInteger numberOfiPadCells;
    NSInteger numberOfiPhoneCells;
    NSInteger numberOfiPodCells;
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
    iPhoneArray = [[NSMutableArray alloc] init];
    iPadArray = [[NSMutableArray alloc] init];
    iPodArray = [[NSMutableArray alloc] init];

    [self getDataAndSort];
    
}
-(void)getDataAndSort {
    
    NSString* filter = @"%K CONTAINS %@";
    NSError *err;
    jsonArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.ineal.me/tss/all"]] options:0 error:&err];
    if (err == nil) {
        [self.tableView reloadData];
        for (NSString* currentString in jsonArray)
        {
            [deviceNames addObject:currentString];
        }
    }
    if (deviceNames != NULL) {
        int count = 0;
        while ([deviceNames count] > count) {
            if ([deviceNames[count] rangeOfString:@"iPad"].location != NSNotFound) {
                [iPadArray addObject:deviceNames[count]];
                numberOfiPadCells++;
            }
            if ([deviceNames[count] rangeOfString:@"iPhone"].location != NSNotFound) {
                [iPhoneArray addObject:deviceNames[count]];
                numberOfiPhoneCells++;
            }
            if ([deviceNames[count] rangeOfString:@"iPod"].location != NSNotFound) {
                [iPodArray addObject:deviceNames[count]];
                numberOfiPodCells++;
            }
            count++;
        }
    }

    [self.tableView reloadData];
    NSLog(@"%@",iPadArray);
}
-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //NSLog(@"iPad: %li iPhone: %li iPod: %li",(long)numberOfiPadCells,(long)numberOfiPhoneCells,(long)numberOfiPodCells);
    if (section == 0) {
        return numberOfiPhoneCells;
    }
    else if (section == 1) {
        return numberOfiPodCells;
    }
    else if (section == 2) {
        return numberOfiPadCells;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return @"iPhone";
    }
    else if(section == 1)
    {
        return @"iPod";
    }
    else
    {
        return @"iPad";
        
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceInformationCell" forIndexPath:indexPath];
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",iPhoneArray[indexPath.row],[[jsonArray objectForKey:iPhoneArray[indexPath.row]] objectForKey:@"board"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ is being signed",[[[[jsonArray objectForKey:iPhoneArray[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"version"]];

            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",iPodArray[indexPath.row],[[jsonArray objectForKey:iPodArray[indexPath.row]] objectForKey:@"board"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ is being signed",[[[[jsonArray objectForKey:iPodArray[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"version"]];

            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",iPadArray[indexPath.row],[[jsonArray objectForKey:iPadArray[indexPath.row]] objectForKey:@"board"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ is being signed",[[[[jsonArray objectForKey:iPadArray[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"version"]];

            break;
            
        default:
            break;
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)selectionChanged:(id)sender {
}
@end
