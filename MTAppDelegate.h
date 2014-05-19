#import <UIKit/UIKit.h>
#import "MTAllFirmwaresTableViewController.h"
#import "MTMyDeviceTableViewController.h"
#import "MTSearchTableViewController.h"

@interface MTAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) MTAllFirmwaresTableViewController *firmwaresController;
@property (strong, nonatomic) MTMyDeviceTableViewController *myDeviceController;
@property (strong, nonatomic) MTSearchTableViewController *searchController;
@end