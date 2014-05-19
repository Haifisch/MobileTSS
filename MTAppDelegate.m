#import "MTAppDelegate.h"

@implementation MTAppDelegate
@synthesize tabBarController;
@synthesize firmwaresController, myDeviceController, searchController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[UITabBar appearance] setBarStyle:UIBarStyleBlack];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UISegmentedControl appearance] setTintColor:[UIColor whiteColor]];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.firmwaresController = [[MTAllFirmwaresTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.myDeviceController = [[MTMyDeviceTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.searchController = [[MTSearchTableViewController alloc] initWithStyle:UITableViewStyleGrouped];

    self.firmwaresController.title = @"All Firmwares";
    self.firmwaresController.tabBarItem.image = [UIImage imageNamed:@"AllFirmwares"];

    self.myDeviceController.title = @"This Device";
    self.myDeviceController.tabBarItem.image = [UIImage imageNamed:@"MyDevice"];

    self.searchController.title = @"Lookup";
    self.searchController.tabBarItem.image = [UIImage imageNamed:@"Search"];

    UINavigationController *firmwareNavController = [[UINavigationController alloc] initWithRootViewController:self.firmwaresController];
    UINavigationController *myDeviceNavController = [[UINavigationController alloc] initWithRootViewController:self.myDeviceController];
    UINavigationController *searchNavController = [[UINavigationController alloc] initWithRootViewController:self.searchController];

    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setViewControllers:@[firmwareNavController,myDeviceNavController,searchNavController] animated:NO];
    
    if ([self.window respondsToSelector:@selector(setRootViewController:)]) {
        [self.window setRootViewController:self.tabBarController];
    } else {
        [self.window addSubview:self.tabBarController.view];
    }
    [self.window makeKeyAndVisible];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
