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
    
    listings = [[NSMutableArray alloc] init];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"ChipID" message:[NSString stringWithFormat:@"%@",MGCopyAnswer(kMGChipID)] delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [av show];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ResultsCell"];
    }

    cell.textLabel.text = listings[indexPath.row];
    
    return nil;
}

@end
