#import "MTAllFirmwaresTableViewController.h"

@interface MTAllFirmwaresTableViewController () {
    NSMutableDictionary *jsonArray;
    NSMutableArray *deviceNames;
}

@end

@implementation MTAllFirmwaresTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];

    deviceNames = [[NSMutableArray alloc] init];
    jsonArray = [[NSMutableDictionary alloc] init];
    
    NSError *err = NULL;
    jsonArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.ineal.me/tss/all"]] options:0 error:&err];
    if (err == nil) {
        [self.tableView reloadData];
        for (NSString *currentString in jsonArray) {
            [deviceNames addObject:currentString];
        }
    }
    [self.tableView reloadData];
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
            return [NSString stringWithFormat:@"%lu Devices being signed",(unsigned long)[deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPhone).*'"]].count];
            break;
            
        case 1:
            return [NSString stringWithFormat:@"%lu Devices being signed",(unsigned long)[deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPad).*'"]].count];
            break;
            
        case 2:
            return [NSString stringWithFormat:@"%lu Devices being signed",(unsigned long)[deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPod).*'"]].count];
            break;
            
        case 3:
            return [NSString stringWithFormat:@"%lu Devices being signed",(unsigned long)[deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(AppleTV).*'"]].count];
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

-(BOOL)isCurrentDevice:(NSString *)name {
   return [name isEqualToString:[NSString stringWithFormat:@"%@",MGCopyAnswer(kMGProductType)]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceInformationCell"];

    if (cell == nil) {
    	cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DeviceInformationCell"];
    }
    
    switch (indexPath.section) {
        case 0: {

            NSArray *iPhones = [deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPhone).*'"]];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",iPhones[indexPath.row],[[jsonArray objectForKey:iPhones[indexPath.row]] objectForKey:@"board"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@) is being signed",[[[[jsonArray objectForKey:iPhones[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"version"],[[[[jsonArray objectForKey:iPhones[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"build"]];
            cell.textLabel.textColor = [self isCurrentDevice:iPhones[indexPath.row]] ? [UIColor greenColor] : [UIColor blackColor];
        }
            break;
            
        case 1: {
            NSArray *iPads = [deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPad).*'"]];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",iPads[indexPath.row],[[jsonArray objectForKey:iPads[indexPath.row]] objectForKey:@"board"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@) is being signed",[[[[jsonArray objectForKey:iPads[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"version"],[[[[jsonArray objectForKey:iPads[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"build"]];
            cell.textLabel.textColor = [self isCurrentDevice:iPads[indexPath.row]] ? [UIColor greenColor] : [UIColor blackColor];
        }

            break;
            
        case 2: {
            NSArray *iPods = [deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPod).*'"]];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",iPods[indexPath.row],[[jsonArray objectForKey:iPods[indexPath.row]] objectForKey:@"board"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@) is being signed",[[[[jsonArray objectForKey:iPods[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"version"],[[[[jsonArray objectForKey:iPods[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"build"]];
            cell.textLabel.textColor = [self isCurrentDevice:iPods[indexPath.row]] ? [UIColor greenColor] : [UIColor blackColor];
        }
            break;
            
        case 3: {
            NSArray *appleTVs = [deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(AppleTV).*'"]];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",appleTVs[indexPath.row],[[jsonArray objectForKey:appleTVs[indexPath.row]] objectForKey:@"board"]];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@) is being signed",[[[[jsonArray objectForKey:appleTVs[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"version"],[[[[jsonArray objectForKey:appleTVs[indexPath.row]] objectForKey:@"firmwares"] objectAtIndex:0] objectForKey:@"build"]];
            cell.textLabel.textColor = [self isCurrentDevice:appleTVs[indexPath.row]] ? [UIColor greenColor] : [UIColor blackColor];
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

