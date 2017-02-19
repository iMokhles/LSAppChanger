//
//  LSAppChangerListController.h
//  LSAppChanger
//
//  Created by iMokhles on 19.02.2017.
//  Copyright (c) 2017 iMokhles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <substrate.h>

@interface LSAppChangerHelper : NSObject

// Preferences
+ (NSString *)preferencesPath;
+ (CFStringRef)preferencesChanged;

// UIWindow to present your elements
// u can show/hide it using ( setHidden: NO/YES )
+ (UIWindow *)mainLSAppChangerWindow;
+ (UIViewController *)mainLSAppChangerViewController;

// Checking App Version
+ (BOOL)isAppVersionGreaterThanOrEqualTo:(NSString *)appversion;
+ (BOOL)isAppVersionLessThanOrEqualTo:(NSString *)appversion;

// Checking OS Version
+ (BOOL)isIOS83_OrGreater;
+ (BOOL)isIOS80_OrGreater;
+ (BOOL)isIOS70_OrGreater;
+ (BOOL)isIOS60_OrGreater;
+ (BOOL)isIOS50_OrGreater;
+ (BOOL)isIOS40_OrGreater;

// Checking Device Type
+ (BOOL)isIPhone6_Plus;
+ (BOOL)isIPhone6;
+ (BOOL)isIPhone5;
+ (BOOL)isIPhone4_OrLess;

// Checking Device Interface
+ (BOOL)isIPad;
+ (BOOL)isIPhone;

// Checking Device Retina
+ (BOOL)isRetina;

// Checking UIScreen sizes
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

@end
