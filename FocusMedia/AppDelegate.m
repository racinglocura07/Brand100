#import "AppDelegate.h"
#import "Util/Utiles.h"
#import <CRToast/CRToast.h>
#import <AFNetworking/AFNetworking.h>
#import "MRProgress.h"
#import "Home.h"
#import "DBManager.h"


@interface AppDelegate ()
@property(nonatomic, strong) void (^registrationHandler)
(NSString *registrationToken, NSError *error);
@property(nonatomic, assign) BOOL connectedToGCM;
@property(nonatomic, strong) NSString* registrationToken;
@property(nonatomic, assign) BOOL subscribedToTopic;
@end

UIBackgroundTaskIdentifier task;
NSString *const urlGeneral = @"http://www.retail100.com.ar/APP/Sistemas";
NSString *const sistema = @"Brand100";

@implementation AppDelegate

NSMutableData *receivedData_;

//AIzaSyDGRk_fVkqJTSA09LOpX_-AUJmW56Q6gF4
//478628144390

// [START register_for_remote_notifications]
- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // [START_EXCLUDE]
    _registrationKey = @"onRegistrationCompleted";
    _messageKey = @"onMessageReceived";
    // Configure the Google context: parses the GoogleService-Info.plist, and initializes
    // the services that have entries in the file
    NSError* configureError;
    [[GGLContext sharedInstance] configureWithError:&configureError];
    NSAssert(!configureError, @"Error configuring Google services: %@", configureError);
    _gcmSenderID = [[[GGLContext sharedInstance] configuration] gcmSenderID];
    // Register for remote notifications
    //    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
    //        // iOS 7.1 or earlier
    //        UIRemoteNotificationType allNotificationTypes =
    //        (UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge);
    //        [application registerForRemoteNotificationTypes:allNotificationTypes];
    //    } else {
    //        // iOS 8 or later
    //        // [END_EXCLUDE]
    UIUserNotificationType allNotificationTypes =
    (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
    UIUserNotificationSettings *settings =
    [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    //    }
    
    // [END register_for_remote_notifications]
    // [START start_gcm_service]
    GCMConfig *gcmConfig = [GCMConfig defaultConfig];
    gcmConfig.receiverDelegate = self;
    [[GCMService sharedInstance] startWithConfig:gcmConfig];
    // [END start_gcm_service]
    __weak typeof(self) weakSelf = self;
    // Handler for registration token request
    _registrationHandler = ^(NSString *registrationToken, NSError *error){
        if (registrationToken != nil) {
            weakSelf.registrationToken = registrationToken;
            NSLog(@"Registration Token: %@", registrationToken);
            NSDictionary *userInfo = @{@"registrationToken":registrationToken};
            [[NSNotificationCenter defaultCenter] postNotificationName:weakSelf.registrationKey
                                                                object:nil
                                                              userInfo:userInfo];
        } else {
            NSLog(@"Registration to GCM failed with error: %@", error.localizedDescription);
            NSDictionary *userInfo = @{@"error":error.localizedDescription};
            [[NSNotificationCenter defaultCenter] postNotificationName:weakSelf.registrationKey
                                                                object:nil
                                                              userInfo:userInfo];
        }
    };
    
    Utiles * sharedManager = [Utiles sharedManager];
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterNoStyle;
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@/version.txt", urlGeneral,sistema];
    NSURL *myURL = [NSURL URLWithString:[urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    NSString *string = [NSString stringWithContentsOfURL:myURL encoding:NSUTF8StringEncoding error:nil];
    
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString * documentsPath = [NSString stringWithFormat:@"%@/%@", resourcePath, sharedManager.VersionUrl];
    NSString *myText = [NSString stringWithContentsOfFile:documentsPath encoding:NSUTF8StringEncoding error:nil];
    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    
    NSString * versionFile = [[documentsDirectoryURL path] stringByAppendingString:@"/Recursos/version"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:versionFile])
    {
        myText = [NSString stringWithContentsOfFile:versionFile encoding:NSUTF8StringEncoding error:nil];
    }
    
    int vWeb = [[f numberFromString:string] intValue];
    int vLocal = [[f numberFromString:myText] intValue];
    NSLog(@"Web = %d -- Local = %d", vWeb, vLocal);
    //<
    if ( vWeb > vLocal){
        NSString *notificationString = @"La aplicacion sera actualizada";
        NSDictionary *options = @{kCRToastTextKey : notificationString,
                                  kCRToastNotificationTypeKey : @(CRToastTypeStatusBar),
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey : [UIColor redColor],
                                  kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                                  kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),
                                  kCRToastTimeIntervalKey : @(5),
                                  };
        [CRToastManager showNotificationWithOptions:options completionBlock:^{
            if ([[UIDevice currentDevice] isMultitaskingSupported])
            {
                //Check if device supports mulitasking
                UIBackgroundTaskIdentifier bgTask;
                UIApplication  *app = [UIApplication sharedApplication];
                bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
                    [app endBackgroundTask:bgTask];
                }];
                [self downloadShowingProgress];
            }
        }];
    }
    else
    {
        application.applicationIconBadgeNumber = 0;
        
        UIColor * notiColor = [UIColor  colorWithRed:(67/255.0) green:(160/255.0) blue:(71/255.0) alpha:1];
        
        Utiles * sharedManager = [Utiles sharedManager];
        NSString * rutaTextos = [NSString stringWithFormat:@"%@/%@Textos.cfg", [[NSBundle mainBundle] resourcePath], sharedManager.HomeUrl ];
        NSString * Color = nil;
        
        if (sharedManager.TodoDescargado){
            rutaTextos =[NSString stringWithFormat:@"%@%@Textos.cfg", sharedManager.RutaDescarga,sharedManager.HomeUrl];;
        }
        
        NSString* fileContents = [NSString stringWithContentsOfFile:rutaTextos encoding:NSUTF8StringEncoding error:nil];
        NSArray * lines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        for ( NSString * line in lines ){
            if ( [line containsString:@"Color"] )
                Color = [[line componentsSeparatedByString:@"="][1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        }
        
        if ( Color != nil )
            notiColor = [Home colorWithHexString:Color ];
        
        NSString *notificationString = @"Aplicacion al dia!";
        NSDictionary *options = @{kCRToastTextKey : notificationString,
                                  kCRToastNotificationTypeKey : @(CRToastTypeStatusBar),
                                  kCRToastTextAlignmentKey : @(NSTextAlignmentCenter),
                                  kCRToastBackgroundColorKey :notiColor ,
                                  kCRToastAnimationInDirectionKey : @(CRToastAnimationDirectionTop),
                                  kCRToastAnimationOutDirectionKey : @(CRToastAnimationDirectionTop),
                                  kCRToastTimeIntervalKey : @(5),
                                  };
        [CRToastManager showNotificationWithOptions:options completionBlock:nil];
        
    }
    
    return YES;
}

-(void)downloadShowingProgress
{
    
    MRProgressOverlayView *overlayView = [MRProgressOverlayView showOverlayAddedTo:self.window title:@"Descargando" mode:MRProgressOverlayViewModeDeterminateCircular animated:YES];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@/Recursos.zip", urlGeneral, sistema]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    
    NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    [self borrarTodo:documentsDirectoryURL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%f",uploadProgress.fractionCompleted);
            [overlayView setProgress:uploadProgress.fractionCompleted];
            
        });
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
        [overlayView dismiss:true];
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        NSString * unzipPath = [documentsDirectoryURL path];// stringByAppendingString:@"/Recursos"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:unzipPath])
            [[NSFileManager defaultManager] createDirectoryAtPath:unzipPath withIntermediateDirectories:NO attributes:nil error:&error];
        
        NSString * file =[filePath path];
        [SSZipArchive unzipFileAtPath:file toDestination:unzipPath progressHandler:^(NSString * entry, unz_file_info zipInfo, long entryNumber, long total){
            
        } completionHandler:^(NSString * path, BOOL succeded, NSError * error){
            NSLog(@"%@", succeded ? @"Bien!" : [NSString stringWithFormat:@"Mal = %@", [error description]]);
            exit(0);
        }];
    }];
    [overlayView show:true];
    [downloadTask resume];
    
}

- (void)borrarTodo:(NSURL *)documentsDirectoryURL{
    NSFileManager *fm = [NSFileManager defaultManager];
    //    NSString *directory = [NSString stringWithFormat:@"%@/Recursos/",[documentsDirectoryURL path]];
    NSString *directory = [NSString stringWithFormat:@"%@/",[documentsDirectoryURL path]];
    NSError *errosr = nil;
    for (NSString *file in [fm contentsOfDirectoryAtPath:directory error:&errosr]) {
        if (![[file pathExtension] containsString:@"sqlite"]){
            
            BOOL success = [fm removeItemAtPath:[NSString stringWithFormat:@"%@%@", directory, file] error:&errosr];
            if (!success || errosr) {
                NSLog(@"Error borrando %@", [errosr description]);
            }
            else
                NSLog(@"Bien borrando");
        }
    }
}

// [START connect_gcm_service]
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Connect to the GCM server to receive non-APNS notifications
    [[GCMService sharedInstance] connectWithHandler:^(NSError *error) {
        if (error) {
            NSLog(@"Could not connect to GCM: %@", error.localizedDescription);
        } else {
            _connectedToGCM = true;
            NSLog(@"Connected to GCM");
            // [START_EXCLUDE]
            [self registrarUsuarioPost];
            
            // [END_EXCLUDE]
        }
    }];
}
// [END connect_gcm_service]

// [START disconnect_gcm_service]
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[GCMService sharedInstance] disconnect];
    // [START_EXCLUDE]
    _connectedToGCM = NO;
    
    // [END_EXCLUDE]
}
// [END disconnect_gcm_service]

// [START receive_apns_token]
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // [END receive_apns_token]
    // [START get_gcm_reg_token]
    // Create a config and set a delegate that implements the GGLInstaceIDDelegate protocol.
    GGLInstanceIDConfig *instanceIDConfig = [GGLInstanceIDConfig defaultConfig];
    instanceIDConfig.delegate = self;
    // Start the GGLInstanceID shared instance with the that config and request a registration
    // token to enable reception of notifications
    [[GGLInstanceID sharedInstance] startWithConfig:instanceIDConfig];
    _registrationOptions = @{kGGLInstanceIDRegisterAPNSOption:deviceToken,
                             kGGLInstanceIDAPNSServerTypeSandboxOption:@NO};
    [[GGLInstanceID sharedInstance] tokenWithAuthorizedEntity:_gcmSenderID
                                                        scope:kGGLInstanceIDScopeGCM
                                                      options:_registrationOptions
                                                      handler:_registrationHandler];
    // [END get_gcm_reg_token]
}

// [START receive_apns_token_error]
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Registration for remote notification failed with error: %@", error.localizedDescription);
    // [END receive_apns_token_error]
    NSDictionary *userInfo = @{@"error" :error.localizedDescription};
    [[NSNotificationCenter defaultCenter] postNotificationName:_registrationKey
                                                        object:nil
                                                      userInfo:userInfo];
}

// [START ack_message_reception]
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Notification received: %@", userInfo);
    // This works only if the app started the GCM service
    [[GCMService sharedInstance] appDidReceiveMessage:userInfo];
    // Handle the received message
    // [START_EXCLUDE]
    [[NSNotificationCenter defaultCenter] postNotificationName:_messageKey
                                                        object:nil
                                                      userInfo:userInfo];
    // [END_EXCLUDE]
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))handler {
    
    NSLog(@"Contenido del JSON: %@", userInfo);
    
    // Schedule the notification
    
    NSString * Titulo = userInfo[@"Titulo"];
    NSString * Cuerpo = userInfo[@"Mensaje"];
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [[NSDate date] dateByAddingTimeInterval:0];
    localNotification.alertBody = Cuerpo;
    
    if ([Titulo caseInsensitiveCompare:@"actuali"])
        localNotification.applicationIconBadgeNumber = 1;
    
    DBManager * dbManager = [[DBManager alloc] initWithDatabaseFilename:@"notificaciones.db"];
    
    NSString *query = [NSString stringWithFormat:@"insert into notificaciones ('titulo', 'mensaje') values('%@', '%@')", Titulo, Cuerpo];
    [dbManager executeQuery:query];
    if (dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", dbManager.affectedRows);
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    handler(UIBackgroundFetchResultNoData);
    // [END_EXCLUDE]
}
// [END ack_message_reception]

// [START on_token_refresh]
- (void)onTokenRefresh {
    // A rotation of the registration tokens is happening, so the app needs to request a new token.
    NSLog(@"The GCM registration token needs to be changed.");
    [[GGLInstanceID sharedInstance] tokenWithAuthorizedEntity:_gcmSenderID
                                                        scope:kGGLInstanceIDScopeGCM
                                                      options:_registrationOptions
                                                      handler:_registrationHandler];
}
// [END on_token_refresh]

// [START upstream_callbacks]
- (void)willSendDataMessageWithID:(NSString *)messageID error:(NSError *)error {
    if (error) {
        // Failed to send the message.
    } else {
        // Will send message, you can save the messageID to track the message
    }
}

- (void)didSendDataMessageWithID:(NSString *)messageID {
    // Did successfully send message identified by messageID
}
// [END upstream_callbacks]

- (void)didDeleteMessagesOnServer {
    // Some messages sent to this device were deleted on the GCM server before reception, likely
    // because the TTL expired. The client should notify the app server of this, so that the app
    // server can resend those messages.
}

- (void) registrarUsuarioPost{
    
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSLog(@"%@",uniqueIdentifier);
    
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                             "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<soap:Body>\n"
                             "<RegistrarUsuario xmlns=\"http://tempuri.org/\">\n"
                             "<email>%@</email >\n"
                             "<regId>%@</regId >\n"
                             "<sistema>%@</sistema >\n"
                             "</RegistrarUsuario >\n"
                             "</soap:Body>\n"
                             "</soap:Envelope>\n", uniqueIdentifier, _registrationToken,sistema];
    
    
    
    //NSString *post = [NSString stringWithFormat: @"email=%@&regId=%@&sistema=%@", uniqueIdentifier, _registrationToken, @"Brand100"];
    NSData *postData = [soapMessage dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:[NSURL URLWithString:@"http://www.retail100.com.ar/app/Notificaciones.asmx?op=RegistrarUsuario"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    [request setTimeoutInterval:20.0];
    [request setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         
     }];
}

@end