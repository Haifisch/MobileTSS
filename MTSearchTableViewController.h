#import <UIKit/UIKit.h>

@interface MTSearchTableViewController : UITableViewController <UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end