#import "MTSearchTableViewController.h"

@interface MTSearchTableViewController () {
    NSMutableArray *requestData;
}
@end

@implementation MTSearchTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.searchBar setDelegate:self];
    [self.searchBar becomeFirstResponder];
    [self.tableView registerNib:[UINib nibWithNibName:@"NoResultsView" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"NoResultsCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [requestData count];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if ([searchBar text].length == 13) {
        requestData = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cydia.saurik.com/tss@home/api/check/%@",[searchBar text]]]] options:0 error:nil];
        if ([requestData count] > 0) {
            [self.tableView reloadData];
        }else {
            [[[UIAlertView alloc] initWithTitle:@"SHSH" message:@"No SHSH blobs found for this ECID" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil] show];
        }

    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    return YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHSHCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SHSHCell"];
    }

    cell.textLabel.text = [requestData[indexPath.row] objectForKey:@"model"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [requestData[indexPath.row] objectForKey:@"firmware"]];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UIToolbar *)createInputAccessoryView {
    
    UIToolbar *tb = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyboard)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    [tb setItems:@[flexItem,item]];
    
    return tb;
}

-(void)dismissKeyboard {
    
    [[self.searchBar valueForKey:@"_searchField"] resignFirstResponder];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    UIToolbar *tb = [self createInputAccessoryView];
    [[searchBar valueForKey:@"_searchField"] setInputAccessoryView:tb];
    return TRUE;
}

@end
