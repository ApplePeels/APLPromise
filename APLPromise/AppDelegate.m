//
//  AppDelegate.m
//  APLPromise
//
//  Created by wangxingming on 2019/4/16.
//  Copyright © 2019 wangxingming. All rights reserved.
//

#import "AppDelegate.h"
#import "APLPromise.h"

@implementation AppDelegate

- (void(^)(APLPromiseResult))testWithFunction {
    return ^(APLPromiseResult result) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            result(@(100));
        });
    };
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    __block NSInteger index = 0;
    [APLPromise async:^(APLPromise* _Nonnull promise){
        NSInteger value = [[promise await:[self testWithFunction]] integerValue];
        NSLog(@"value %ld", value);
        id ret1 = [promise await:^(APLPromiseResult result) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                index++;
                result(@(index));
            });
        }];
        NSLog(@"ret1 %@", ret1);
        id ret2 = [promise await:^(APLPromiseResult result) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                index++;
                result(@(index));
            });
        }];
        NSLog(@"ret2 %@", ret2);
        
        NSLog(@"index:%ld", index);
    }];

    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
