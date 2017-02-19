//
//  LSAppChangerListController.m
//  LSAppChanger
//
//  Created by iMokhles on 19.02.2017.
//  Copyright (c) 2017 iMokhles. All rights reserved.
//

#import "LSAppChangerHelper.h"

@implementation LSAppChangerHelper

// Preferences
+ (NSString *)preferencesPath {
	return @"/var/mobile/Library/Preferences/com.imokhles.lsappchanger.plist";
}

+ (CFStringRef)preferencesChanged {
	return (__bridge CFStringRef)@"com.imokhles.lsappchanger.preferences-changed";
}

// UIWindow to present your elements
// u can show/hide it using ( setHidden: NO/YES )
+ (UIWindow *)mainLSAppChangerWindow {
	return nil;
}

+ (UIViewController *)mainLSAppChangerViewController {
	return nil;
}

// Checking App Version
+ (BOOL)isAppVersionGreaterThanOrEqualTo:(NSString *)appversion {
	return [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] compare:appversion options:NSNumericSearch] != NSOrderedAscending;
}
+ (BOOL)isAppVersionLessThanOrEqualTo:(NSString *)appversion {
	return [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] compare:appversion options:NSNumericSearch] != NSOrderedDescending;
}

// Checking OS Version
+ (BOOL)isIOS83_OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3;
}
+ (BOOL)isIOS80_OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0;
}
+ (BOOL)isIOS70_OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
}
+ (BOOL)isIOS60_OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0;
}
+ (BOOL)isIOS50_OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0;
}
+ (BOOL)isIOS40_OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0;
}

// Checking Device Type
+ (BOOL)isIPhone6_Plus {
	return [self isIPhone] && [self screenMaxLength] == 736.0;
}
+ (BOOL)isIPhone6 {
	return [self isIPhone] && [self screenMaxLength] == 667.0;
}
+ (BOOL)isIPhone5 {
	return [self isIPhone] && [self screenMaxLength] == 568.0;
}
+ (BOOL)isIPhone4_OrLess {
	return [self isIPhone] && [self screenMaxLength] < 568.0;
}

// Checking Device Interface
+ (BOOL)isIPad {
	return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}
+ (BOOL)isIPhone {
	return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

// Checking Device Retina
+ (BOOL)isRetina {
	if ([self isIOS80_OrGreater]) {
        return [UIScreen mainScreen].nativeScale>=2;
    }
	return [[UIScreen mainScreen] scale] >= 2.0;
}

// Checking UIScreen sizes
+ (CGFloat)screenWidth {
	return [[UIScreen mainScreen] bounds].size.width;
}
+ (CGFloat)screenHeight {
	return [[UIScreen mainScreen] bounds].size.height;
}

+ (CGFloat)screenMaxLength {
    return MAX([self screenWidth], [self screenHeight]);
}

+ (CGFloat)screenMinLength {
    return MIN([self screenWidth], [self screenHeight]);
}

@end
