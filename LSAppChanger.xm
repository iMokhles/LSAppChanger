//
//  LSAppChanger.x
//  LSAppChanger
//
//  Created by iMokhles on 19.02.2017.
//  Copyright (c) 2017 iMokhles. All rights reserved.
//

#import "LSAppChangerHelper.h"

%group main

@interface SBApplication : NSObject
- (id)launchInterfaceFileName;
- (id)defaultLaunchImageFile;

- (id)bundleVersion;
- (id)_parseCustomSpotlightIconPaths;
- (void)purgeAllCaches;
- (void)purgeBundleCaches;
- (id)bundle;
- (double)modificationDate;
- (id)bundleContainerPath;
- (id)dataContainerPath;
- (id)path;
- (id)iconIdentifier;
- (id)bundleIdentifier;
@end

@interface SBAppView : UIView
@property(readonly, nonatomic) SBApplication *application;

- (id)_launchInterfaceView;
@end

@interface SBApplicationController : NSObject
+ (id)sharedInstanceIfExists;
+ (id)sharedInstance;
- (id)applicationWithBundleIdentifier:(id)arg1;
- (id)cameraApplication;
@end

BOOL isTweakEnabled;
NSString *LSAC_AppId;
static void LSAppChanger_Prefs() {

	NSDictionary *LSAppChangerSettings = [NSDictionary dictionaryWithContentsOfFile:[LSAppChangerHelper preferencesPath]];
	NSNumber *isTweakEnabledNU = LSAppChangerSettings[@"isTweakEnabled"];
    isTweakEnabled = isTweakEnabledNU ? [isTweakEnabledNU boolValue] : 0;
    LSAC_AppId = LSAppChangerSettings[@"LSAC_AppId"];
}

static void lsac_HandleUpdate() {
	LSAppChanger_Prefs();

	[[%c(SBApplicationController) sharedInstance] cameraApplication];

}

static void lsacInit()
{
	[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *block) {
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)lsac_HandleUpdate, [LSAppChangerHelper preferencesChanged], NULL, 0);
		lsac_HandleUpdate();
 
     }];
}

// ( other apps uses Storyboard ) [ only camera app contains LaunchPhoto.nib ]
// so it cause crash 
// *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 
// 'Could not load NIB in bundle: 'NSBundle </Applications/AppStore.app> (not yet loaded)' with name 'LaunchScreen''

// 
%hook SBAppView
- (BOOL)_shouldLoadInterfaceFileBasedStaticContent {

	NSDictionary *LSAppChangerSettings = [NSDictionary dictionaryWithContentsOfFile:[LSAppChangerHelper preferencesPath]];
	NSNumber *isTweakEnabledNU = LSAppChangerSettings[@"isTweakEnabled"];
    isTweakEnabled = [isTweakEnabledNU boolValue];
    LSAC_AppId = LSAppChangerSettings[@"LSAC_AppId"];

    if (isTweakEnabled) {
    	if ([self.application.bundleIdentifier isEqualToString:LSAC_AppId]) {
			return NO;
		}
		return %orig();
   	} else {
   		return %orig();
    }
	
	
}
// - (id)_launchInterfaceView {

// 	UIView *customView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
// 	[customView setBackgroundColor:[UIColor clearColor]];
// 	return customView;
// }
%end

%hook SBApplicationController
- (id)cameraApplication {
	NSDictionary *LSAppChangerSettings = [NSDictionary dictionaryWithContentsOfFile:[LSAppChangerHelper preferencesPath]];
	NSNumber *isTweakEnabledNU = LSAppChangerSettings[@"isTweakEnabled"];
    isTweakEnabled = [isTweakEnabledNU boolValue];
    LSAC_AppId = LSAppChangerSettings[@"LSAC_AppId"];


	if (isTweakEnabled) {
		if ([LSAC_AppId isEqualToString:@"com.apple.camera"]) {
    		return %orig();
    	} else {
    		return [self applicationWithBundleIdentifier:LSAC_AppId];
    	}
	} else {
		return %orig();
	}
}
%end

%end


%ctor {
	@autoreleasepool {
		[[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *block) {
	        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)LSAppChanger_Prefs, [LSAppChangerHelper preferencesChanged], NULL, 0);
	        LSAppChanger_Prefs();
	 
	    }];
		%init(main);
	}
}
