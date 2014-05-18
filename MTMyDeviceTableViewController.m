#import "MTMyDeviceTableViewController.h"

@interface MTMyDeviceTableViewController () {
    NSMutableArray *listings;
}

@end

@implementation MTMyDeviceTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error = NULL;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cydia.saurik.com/tss@home/api/check/%@",MGCopyAnswer(kMGUniqueChipID)]]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];

    if (data && !error) {
        listings = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    } else {
        listings = [[NSMutableArray alloc] init];
        [listings addObject:@"No available Blobs"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    return [NSString stringWithFormat:@"ECID: %@",MGCopyAnswer(kMGUniqueChipID)];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([listings count] == 0) {

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoResultsCell"];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NoResultsCell"];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        cell.textLabel.text = @"No Records to display";
        
        return cell;
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultsCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ResultsCell"];
    }

    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)",[listings[indexPath.row] objectForKey:@"model"],[listings[indexPath.row] objectForKey:@"build"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [listings[indexPath.row] objectForKey:@"firmware"]];
    
    return cell;
}

@end
