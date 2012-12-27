//
//  LMUAppDelegate.m
//  Stats
//
//  Created by Scott Sirowy on 4/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LMUAppDelegate.h"

#import "LMUViewController.h"
#import "SSZipArchive.h"
#import "LMUModule.h"
#import "SZJSONParser.h"
#import <mach/mach_time.h>

@interface LMUAppDelegate () 

- (void)initializeModules;

@property (nonatomic, retain) NSArray*  modules;

@end

void logMachTime_withIdentifier_(uint64_t machTime, NSString *identifier)
{
    static double timeScaleSeconds = 0.0;
    if (timeScaleSeconds == 0.0) {
        mach_timebase_info_data_t timebaseInfo;
        if (mach_timebase_info(&timebaseInfo) == KERN_SUCCESS) {    // returns scale factor for ns
            double timeScaleMicroSeconds = ((double) timebaseInfo.numer / (double) timebaseInfo.denom) / 1000;
            timeScaleSeconds = timeScaleMicroSeconds / 1000000;
        }
    }
    
    NSLog(@"%@: %g seconds", identifier, timeScaleSeconds*machTime);
}

@implementation LMUAppDelegate

- (void)dealloc
{
    [_window            release];
    [_viewController    release];
    [_modules           release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    [self initializeModules];
    
    self.viewController = [[[LMUViewController alloc] initWithModules:self.modules] autorelease];
    self.window.rootViewController = self.viewController;
    
    
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
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initializeModules
{    
    NSString *jsonTextFilePath = [[NSBundle mainBundle] pathForResource:@"gradrates2" ofType:@"txt"];
    NSString *jsonTxt = [NSString stringWithContentsOfFile:jsonTextFilePath encoding:NSStringEncodingConversionAllowLossy error:nil];
    
    uint64_t startTime, stopTime;
    startTime = mach_absolute_time();
    
    NSDictionary *json = (NSDictionary *)[jsonTxt jsonObject];
    
    self.modules = [LMUModule modulesFromJSON:json forKey:@"filters"];
    
    stopTime = mach_absolute_time();
    logMachTime_withIdentifier_(stopTime - startTime, @"10000000 class messages");
    
    /*
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"];
    
    //Create a place for unzipped modules
    NSString *folderPath = [docsDir stringByAppendingPathComponent:@"Modules"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:folderPath 
                                  withIntermediateDirectories:NO 
                                                   attributes:nil 
                                                        error:nil]; //Create folder
    }

     //taken from Apple's doc at 
     //http://developer.apple.com/library/ios/#documentation/cocoa/reference/foundation/Classes/NSFileManager_Class/Reference/Reference.html#//apple_ref/doc/uid/20000305-CHDDDIED   
    
    //Find all new zip files dumped into Documents directory, add to a Modules folder, and then delete zip file (TODO)
    NSFileManager *localFileManager=[[NSFileManager alloc] init];
    NSArray *dirContents = [localFileManager contentsOfDirectoryAtPath:docsDir error:nil];
    
    for(NSString *file in dirContents)
    {
        if ([[file pathExtension] isEqualToString: @"zip"]) 
        {
            NSString *zipPath = [docsDir stringByAppendingPathComponent:file];
            NSString *unzippedPath = [folderPath stringByAppendingPathComponent:[file stringByDeletingPathExtension]];
            [SSZipArchive unzipFileAtPath:zipPath toDestination:unzippedPath];
        } 
    }
    
    NSArray *moduleDirContents = [localFileManager contentsOfDirectoryAtPath:folderPath error:nil];
    for (NSString *moduleName in moduleDirContents)
    {
        if ([moduleName isEqualToString:@".DS_Store"]) 
            continue;
                
        LMUModule *newModule = [[LMUModule alloc] initWithName:moduleName atPath:folderPath];
        [self.modules addObject:newModule];
        [newModule release];
    }
    
    [localFileManager release]; 
    */
}

@end
