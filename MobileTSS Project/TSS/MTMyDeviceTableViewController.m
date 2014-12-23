#import "MTMyDeviceTableViewController.h"

@interface MTMyDeviceTableViewController () {
    NSMutableArray *listings;
}

@end

@implementation MTMyDeviceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                                        target:self 
                                                                        action:@selector(refreshBlobs)];
    [self refreshBlobs];
}

-(void)refreshBlobs {

    if (listings) {
        [listings removeAllObjects];
        listings = nil;
    }

    listings = [[NSMutableArray alloc] init];

    NSError *error = NULL;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cydia.saurik.com/tss@home/api/check/%@",[self deviceECID]]]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];

    if (data && !error) {
        listings = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    } else {
        listings = [[NSMutableArray alloc] init];
        [listings addObject:@"No available Blobs"];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if ([listings count] == 0) {
        return 1; 
    }
    return [listings count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self deviceECID]) {
        return [NSString stringWithFormat:@"ECID: %@",[self deviceECID]];
    }else {
        return @"ECID: N/A";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *cellIdentifier = @"";
    BOOL noResults = FALSE;

    if ([listings count] == 0) {

        cellIdentifier = @"NoResultsCell";
        noResults = TRUE;

    } else {

        cellIdentifier = @"ResultsCell";
        noResults = FALSE;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:noResults ? UITableViewCellStyleDefault : UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }

    if (noResults) {
        cell.backgroundColor = [UIColor clearColor];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }

    cell.textLabel.text = noResults ? @"No records to display" : [NSString stringWithFormat:@"%@ (%@)",[listings[indexPath.row] objectForKey:@"model"],[listings[indexPath.row] objectForKey:@"build"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [listings[indexPath.row] objectForKey:@"firmware"]];
    
    return cell;
}
-(NSString *)deviceECID {
    NSString *retVal = nil;
    CFTypeRef tmp = MGCopyAnswer(CFSTR("UniqueChipID"));
    if (tmp) {
        retVal = [NSString stringWithString:(__bridge NSString *)(tmp)];
        CFRelease(tmp);
    }
    return retVal;
}
@end
