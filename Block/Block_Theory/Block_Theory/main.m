//
//  main.m
//  Block_Theory
//
//  Created by L on 2020/4/21.
//  Copyright © 2020 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
        int age = 10;
        void(^block)(int ,int ) = ^(int a,int b){
            NSLog(@"this is block,a = %d,b = %d",a,b);
            NSLog(@"this is block,age = %d",age);
        };
        block(3,5);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
