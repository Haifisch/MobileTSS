#import <UIKit/UIKit.h>
#import "MobileGestalt.h"

@interface MTSearchTableViewController : UITableViewController <UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@end