//
//  SflyUtility.h
//  SFLibSandBox
//
//  Created by James Oey on 11/12/12.
//  Copyright (c) 2012 Shutterfly. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    PERSISTENT_ITEM_OAUTH_TOKEN,
    PERSISTENT_ITEM_OFLY_TOKEN,
    PERSISTENT_ITEM_REFRESH_TOKEN,
    PERSISTENT_ITEM_OAUTH_EXPIRE
} PersistentItemEnum;

typedef enum {
    DEFAULT_ITEM_SITE,
    DEFAULT_ITEM_MODULE,
    LOGIN_FLAG
} DefaultItemEnum;

@interface SflyUtility : NSObject


+ (NSDate*)sflyDateToNSDate:(NSString*)dateString;
+ (NSString*)nsDateToSflyDate:(NSDate*)date;

+ (NSString*)sha1:(NSData*)input;
+ (NSString *)genUUID;

+ (void)startLogTime:(NSString*)name;
+ (NSTimeInterval)endLogTime:(NSString*)name;

// Functions for persistent storage
// Note that depending on the item key, the item may be stored securely
// or insecurely (keychain vs NSUserDefault
+ (void)storePersistentItem:(id)object withKey:(PersistentItemEnum)item;
+ (id)getPersistentItemWithKey:(PersistentItemEnum)item;


// Functions for storing defaults
+ (void) storeDefault: (id) object withKey: (DefaultItemEnum) item;
+ (id) getDefaultItemWithKey: (DefaultItemEnum) item;
+ (void) removeDefault: (DefaultItemEnum) item;

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

// Functions for storing last network call information
+ (void)updateDateForRequest:(Class)request site:(NSString*)siteId extraIdentifier:(NSString*)extraIdentifier;
+ (NSDate*)getDateForLastRequest:(Class) request site:(NSString*)siteId extraIdentifier:(NSString*)extraIdentifier;
+ (NSTimeInterval)timeSinceRequest:(Class)request site:(NSString*)siteId extraIdentifier:(NSString*)extraIdentifier;

// Login success, used by both sign in and sign up
+ (void) loginSuccess: (UIViewController *) viewController;

// Resize label to fit text
+ (CGRect) resizeLabel: (UILabel *) label text: (NSString *) text;
+ (CGRect) resizeLabelHeight: (UILabel *) label;

//Reachability utilitieis
+ (BOOL)apiServerAvailable;
+ (BOOL)internetConnectionAvailable;
+ (BOOL)shareServerAvailable;

@end
