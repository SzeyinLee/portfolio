//
//  AppDelegate.m
//  
//
//  Created by Szeyin Lee on 9/29/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import "AppDelegate.h"
#import "Database.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //initialize database
    [Database createEditableCopyOfDatabaseIfNeeded];
    [Database initDatabase];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    //create the contacts table view, set it's nav bar title, and nav bar add button
    ScrapbookViewController *mainView = [[ScrapbookViewController alloc] initWithStyle:UITableViewStylePlain];
    [mainView.navigationItem setTitle:@"Scrapbook Photos"];
    [mainView.navigationItem setRightBarButtonItems:[NSArray arrayWithObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:mainView action:@selector(addButtonPressed)]] animated:NO];
    
    // set nav bar root view controller
    self.navController = [[UINavigationController alloc] initWithRootViewController:mainView];
    
    // set application root view controller
    [self.window setRootViewController:self.navController];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
