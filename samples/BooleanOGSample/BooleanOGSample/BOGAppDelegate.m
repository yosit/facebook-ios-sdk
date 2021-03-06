/*
 * Copyright 2012 Facebook
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "BOGAppDelegate.h"
#import "BOGFirstViewController.h"
#import "BOGSecondViewController.h"

@implementation BOGAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

// FBSample logic
// The native facebook application transitions back to an authenticating application when the user 
// chooses to either log in, or cancel. This call to handleOpenURL manages that transition. See the
// "Just Login" sample application for deeper discussion on this topic.
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [FBSession.activeSession handleOpenURL:url]; 
}

// FBSample logic
// Open session objects should be closed when no longer useful 
- (void)applicationWillTerminate:(UIApplication *)application {
    // all good things must come to an end
    [FBSession.activeSession close];
}

// FBSample logic
// The session management and login behavior of this sample is very simplistic; for deeper coverage of
// this topic see the "Just Login" or "Switch User" sample applicaitons
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[BOGFirstViewController alloc] initWithNibName:@"BOGFirstViewController_iPhone" bundle:nil];
        viewController2 = [[BOGSecondViewController alloc] initWithNibName:@"BOGSecondViewController_iPhone" bundle:nil];
    } else {
        viewController1 = [[BOGFirstViewController alloc] initWithNibName:@"BOGFirstViewController_iPad" bundle:nil];
        viewController2 = [[BOGSecondViewController alloc] initWithNibName:@"BOGSecondViewController_iPad" bundle:nil];
    }
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:viewController1, viewController2, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];

    // FBSample logic
    // We create and open a session at the outset here; if login is cancelled or fails, the application ignores
    // this and continues to provide whatever functionality that it can
    NSArray *permissions = [NSArray arrayWithObjects:@"publish_actions", nil];
    [FBSession sessionOpenWithPermissions:permissions completionHandler:nil];
    
    return YES;
}

@end
