//
//  SearchTableViewController.h
//  TSS
//
//  Created by Haifisch on 5/11/14.
//  Copyright (c) 2014 Haifisch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewController : UITableViewController <UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end
