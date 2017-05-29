//
//  AppDelegate.h
//  FocusMedia
//
//  Created by Administrador on 5/3/16.
//  Copyright © 2016 No Fue Magia. All rights reserved.
//

//#import "UIApplication+SimulatorRemoteNotifications.h"
#import <Google/CloudMessaging.h>
#import <UIKit/UIKit.h>
#import <SSZipArchive.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, GGLInstanceIDDelegate, GCMReceiverDelegate, SSZipArchiveDelegate, NSURLSessionTaskDelegate>

@property(nonatomic, strong) UIWindow *window;
@property(nonatomic, readonly, strong) NSString *registrationKey;
@property(nonatomic, readonly, strong) NSString *messageKey;
@property(nonatomic, readonly, strong) NSString *gcmSenderID;
@property(nonatomic, readonly, strong) NSDictionary *registrationOptions;
@property(nonatomic,strong) NSMutableData * receivedData;


@end

//NSString *deviceID = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceID"];
//NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];