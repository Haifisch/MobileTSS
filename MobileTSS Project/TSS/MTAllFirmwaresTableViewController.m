#import "MTAllFirmwaresTableViewController.h"

@interface MTAllFirmwaresTableViewController () {
    NSMutableDictionary *jsonArray;
    NSMutableArray *deviceNames;
}

@end

@implementation MTAllFirmwaresTableViewController

- (void)viewDidLoad {

    [super viewDidLoad];

    deviceNames = [[NSMutableArray alloc] init];
    jsonArray = [[NSMutableDictionary alloc] init];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Public Firmwares",@"Beta firmwares", nil]];
    [segmentedControl setSelectedSegmentIndex:0];
    [segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.navigationItem setTitleView:segmentedControl];
    [self reloadDataWithBeta:NO];
}
-(void)reloadDataWithBeta:(BOOL)beta{
    [jsonArray removeAllObjects];
    [deviceNames removeAllObjects];
    if (beta){
        NSError *err = NULL;
        jsonArray = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.ineal.me/tss/beta/all"]] options:0 error:&err] mutableCopy];
        if (err == nil) {
            [self.tableView reloadData];
            for (NSString *currentString in jsonArray) {
                [deviceNames addObject:currentString];
            }
        }
    }else {
        NSError *err = NULL;
        jsonArray = [[NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.ineal.me/tss/all"]] options:0 error:&err] mutableCopy];
        if (err == nil) {
            [self.tableView reloadData];
            for (NSString *currentString in jsonArray) {
                [deviceNames addObject:currentString];
            }
        }
    }
    
    [self.tableView reloadData];
}

-(BOOL)isCurrentDevice:(NSString *)name {
   return [name isEqualToString:[NSString stringWithFormat:@"%@",MGCopyAnswer(kMGProductType)]];
}
-(IBAction)segmentChanged:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    NSLog(@"%ld", (long)seg.selectedSegmentIndex);
    if (seg.selectedSegmentIndex == 1) {
        [self reloadDataWithBeta:YES];
    }else if (seg.selectedSegmentIndex == 0){
        [self reloadDataWithBeta:NO];
    }
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
            return [NSString stringWithFormat:@"%lu Firmwares being signed",(unsigned long)[deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPhone).*'"]].count];
            break;
            
        case 1:
            return [NSString stringWithFormat:@"%lu Firmwares being signed",(unsigned long)[deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPad).*'"]].count];
            break;
            
        case 2:
            return [NSString stringWithFormat:@"%lu Firmwares being signed",(unsigned long)[deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPod).*'"]].count];
            break;
            
        case 3:
            return [NSString stringWithFormat:@"%lu Firmwares being signed",(unsigned long)[deviceNames filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(AppleTV).*'"]].count];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceInformationCell"];

    if (cell == nil) {
    	cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"DeviceInformationCell"];
    }

    NSArray *predicates = [NSArray arrayWithObjects:
    	[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPhone).*'"],
    	[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPad).*'"],
    	[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(iPod).*'"],
    	[NSPredicate predicateWithFormat:@"SELF MATCHES '.*(AppleTV).*'"],
    	nil];

	NSArray *devices = [deviceNames filteredArrayUsingPredicate:predicates[indexPath.section]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",devices[indexPath.row],jsonArray[devices[indexPath.row]][@"board"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ (%@) is being signed",jsonArray[devices[indexPath.row]][@"firmwares"][0][@"version"],jsonArray[devices[indexPath.row]][@"firmwares"][0][@"build"]];
    cell.textLabel.textColor = [self isCurrentDevice:devices[indexPath.row]] ? [UIColor greenColor] : [UIColor blackColor];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

