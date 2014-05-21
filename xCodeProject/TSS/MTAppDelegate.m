#import "MTAppDelegate.h"

@implementation MTAppDelegate
@synthesize tabBarController;
@synthesize firmwaresController, myDeviceController, searchController;
-(BOOL)isJailbroken {
    NSURL* url = [NSURL URLWithString:@"cydia://"];
    return [[UIApplication sharedApplication] canOpenURL:url];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UITabBar appearance] setBarStyle:UIBarStyleBlack];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.firmwaresController = [[MTAllFirmwaresTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.myDeviceController = [[MTMyDeviceTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.searchController = [[MTSearchTableViewController alloc] initWithStyle:UITableViewStyleGrouped];

    self.firmwaresController.title = @"All Firmwares";
    self.firmwaresController.tabBarItem.image = [UIImage imageNamed:@"All"];

    self.myDeviceController.title = @"This Device";
    self.myDeviceController.tabBarItem.image = [UIImage imageNamed:@"iPhone_Tab"];

    self.searchController.title = @"Lookup";
    self.searchController.tabBarItem.image = [UIImage imageNamed:@"Search"];

    UINavigationController *firmwareNavController = [[UINavigationController alloc] initWithRootViewController:self.firmwaresController];
    UINavigationController *myDeviceNavController = [[UINavigationController alloc] initWithRootViewController:self.myDeviceController];
    UINavigationController *searchNavController = [[UINavigationController alloc] initWithRootViewController:self.searchController];

    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setViewControllers:@[firmwareNavController,myDeviceNavController,searchNavController] animated:NO];
    
    if ([self isJailbroken]) {
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:TRUE];
    }else{
        [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:FALSE];
    }
    
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
