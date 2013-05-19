//
//  AppDelegate.m
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "OnboardingViewController.h"
#import "SFlyData.h"
#import "MainViewController.h"
#import "Project.h"
#import "FullMomentViewController.h"
#import "CaptureMomentViewController.h"
#import "RewardsViewController.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert)];
    
    [SflyCore initWithAppDelegate:self];
    Project *project = [SflyData project];
    
    self.navController = nil;
    if (project == nil) {
        self.navController = [[UINavigationController alloc] initWithRootViewController:[[OnboardingViewController alloc] init]];
    } else {
        MainViewController *mvController = [[MainViewController alloc] initWithProject:project];
        [SflyCore storeMainViewController:mvController];
        self.navController = [[UINavigationController alloc] initWithRootViewController:mvController];
    }
    
    [self.navController setNavigationBarHidden:YES];
    self.window.rootViewController = self.navController;
    //self.window.backgroundColor = [UIColor grayColor];
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
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}


- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskPortrait;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && ([self.navController.visibleViewController isKindOfClass:[MainViewController class]] ||
                                                                   [self.navController.visibleViewController isKindOfClass:[FullMomentViewController class]])) {
        mask = UIInterfaceOrientationMaskAll;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        mask = (UIInterfaceOrientationMaskLandscapeLeft|UIInterfaceOrientationMaskLandscapeRight);
    }
    
    return mask;
}


#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BabysFirstYear" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BabysFirstYear.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - APNS service

// Delegation methods
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    //const void *devTokenBytes = [devToken bytes];
    //self.registered = YES;
    //[self sendProviderDeviceToken:devTokenBytes]; // custom method
    NSString *devTokenString = [[devToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""];
    devTokenString = [devTokenString stringByReplacingOccurrencesOfString:@">" withString:@""];
    devTokenString = [devTokenString stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSLog(@"APNS token:%@", devTokenString);
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in APNS registration. Error: %@", err);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //UIViewController *mainViewController = [SflyCore mainViewController];
    //[self.navController popToViewController:mainViewController animated:YES];
    UIViewController *currentVC = self.navController.visibleViewController;
    NSSortDescriptor *weekSort = [[NSSortDescriptor alloc] initWithKey:@"weeksFromStart" ascending:YES];
    NSArray *tasks = [[SflyData project].tasks sortedArrayUsingDescriptors:@[weekSort]];

    NSString *typeString = [userInfo valueForKey:@"type"];
    if ([[userInfo valueForKey:@"type"] isEqualToString:@"0"]) {

        CaptureMomentViewController *cmViewController =
        [[CaptureMomentViewController alloc] initWithTask:[tasks objectAtIndex:19]];
        //[mainViewController presentViewController:cmViewController animated:YES completion:nil];
        [currentVC presentViewController:cmViewController animated:YES completion:nil];
    } else if ([[userInfo valueForKey:@"type"] isEqualToString:@"1"]) {
        RewardsViewController *rewardsViewController =
        [[RewardsViewController alloc] initWithMode:1];
        //[mainViewController presentViewController:cmViewController animated:YES completion:nil];
        [currentVC presentViewController:rewardsViewController animated:YES completion:nil];
    } else if ([[userInfo valueForKey:@"type"] isEqualToString:@"2"]) {
        RewardsViewController *rewardsViewController =
        [[RewardsViewController alloc] initWithMode:2];
        //[mainViewController presentViewController:cmViewController animated:YES completion:nil];
        [currentVC presentViewController:rewardsViewController animated:YES completion:nil];
    }
}

@end
