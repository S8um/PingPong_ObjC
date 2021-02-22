//
//  AppDelegate.m
//  PingPong
//
//  Created by admin on 22.02.2021.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%@ - %@", @"Успешный запуска приложения", @"didFinishLaunchingWithOptions");
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"%@ - %@", @"Переход в активное состояние", @"applicationDidBecomeActive");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"%@ - %@", @"Переход в неактивное состояние", @"applicationWillResignActive");
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"%@ - %@", @"Переход приложения в Background", @"applicationDidEnterBackground");
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%@ - %@", @"Переход приложения из Background в Foreground", @"applicationWillEnterForeground");
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"%@ - %@", @"Закрытие приложения", @"applicationWillTerminate");
}

@end
