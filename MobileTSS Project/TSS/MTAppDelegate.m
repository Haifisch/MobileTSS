#import "MTAppDelegate.h"

@implementation MTAppDelegate
@synthesize tabBarController;
@synthesize firmwaresController, searchController;
-(BOOL)isJailbroken {
    NSURL* url = [NSURL URLWithString:@"cydia://"];
    return [[UIApplication sharedApplication] canOpenURL:url];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0f green:139/255.0f blue:250/255.0f alpha:1]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor whiteColor]];
    
    [[UITabBar appearance] setSelectionIndicatorImage:[MTAppDelegate imageFromColor:[UIColor colorWithRed:0/255.0f green:139/255.0f blue:230/255.0f alpha:1] forSize:CGSizeMake(210, 49) withCornerRadius:0]];

    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0f green:139/255.0f blue:250/255.0f alpha:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.firmwaresController = [[MTAllFirmwaresTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.myDeviceController = [[MTMyDeviceTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.searchController = [[MTSearchTableViewController alloc] initWithStyle:UITableViewStyleGrouped];

    self.firmwaresController.title = @"All Firmwares";
    self.firmwaresController.tabBarItem.image = [[UIImage imageNamed:@"All"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    self.searchController.title = @"Lookup";
    self.searchController.tabBarItem.image = [[UIImage imageNamed:@"Search"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UINavigationController *firmwareNavController = [[UINavigationController alloc] initWithRootViewController:self.firmwaresController];
    UINavigationController *searchNavController = [[UINavigationController alloc] initWithRootViewController:self.searchController];

    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setViewControllers:@[firmwareNavController,searchNavController] animated:NO];
    
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

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}
@end
