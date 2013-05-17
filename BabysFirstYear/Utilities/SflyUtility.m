//
//  SflyUtility.m
//  SFLibSandBox
//
//  Created by James Oey on 11/12/12.
//  Copyright (c) 2012 Shutterfly. All rights reserved.
//

#import "SflyUtility.h"
#import "SflyCore.h"
#import <CommonCrypto/CommonDigest.h>


#define DATEFORMATSTRING @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

@implementation SflyUtility

static NSMutableDictionary *timePoints;

+ (NSDate*)sflyDateToNSDate:(NSString*)dateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATEFORMATSTRING];
    return [formatter dateFromString:dateString];
}

+ (NSString*)nsDateToSflyDate:(NSDate*)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:DATEFORMATSTRING];
    return [formatter stringFromDate:date];
}

+ (NSString*)sha1:(NSData*)input {
    //NSString *inputString = [[NSString alloc] initWithData:input encoding:NSUTF8StringEncoding];
    //const char *cstr = [inputString cStringUsingEncoding:NSUTF8StringEncoding];
    //NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(input.bytes, input.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH*2];
    
    for(int i=0;i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

+ (NSString *)genUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    NSString *uuidString = (__bridge NSString*) CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return uuidString;
}

+ (void)startLogTime:(NSString*)name {
    if (timePoints == NULL) {
        timePoints = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    [timePoints setValue:[NSDate date] forKey:name];
}

+ (NSTimeInterval)endLogTime:(NSString*)name {
    NSTimeInterval interval;
    NSDate *start = [timePoints valueForKey:name];
    if (start != NULL) {
        interval = -[start timeIntervalSinceNow];
        NSLog(@"LOGTIME(%@):%f seconds", name, interval);
        [timePoints removeObjectForKey:name];
        return interval;
    } else {
        return 0;
    }
}

// Two main methods of storage (function doesn't limit to two, but secure
// and insecure are pretty much the two main types you'd really need
// NSUserDefaults for insecure
//   use [NSUserDefault set***:*** forKey:***]
//   and [NSUserDefault ***ForKey:***]
//
//   NOTE that you need to convert to an object for the "get", i.e. NSNumber
//   because the "get" returns generic objects.
//
// Keychain for secure - use sparingly because of unnecessary bloat to the
// keychain; need to find a good "key" to store in the keychain
//
//
/*
 Available keychain keys
 
 KEY                                 TYPE          USE
kSecAttrAccessGroup			-		CFStringRef
kSecAttrCreationDate		-		CFDateRef      tokenExpire
kSecAttrModificationDate    -		CFDateRef
kSecAttrDescription			-		CFStringRef    refreshToken
kSecAttrComment				-		CFStringRef
kSecAttrCreator				-		CFNumberRef
kSecAttrType                -		CFNumberRef
kSecAttrLabel				-		CFStringRef
kSecAttrIsInvisible			-		CFBooleanRef
kSecAttrIsNegative			-		CFBooleanRef
kSecAttrAccount				-		CFStringRef    oAuthToken
kSecAttrService				-		CFStringRef    oflyToken
kSecAttrGeneric				-		CFDataRef
*/
/*
+ (void)storePersistentItem:(id)object withKey:(PersistentItemEnum)item {
    switch (item) {
        case PERSISTENT_ITEM_OAUTH_TOKEN:
            if ([object isKindOfClass:[NSString class]]) {
                [[SflyCore keychain] setObject:object forKey:(__bridge id)(kSecAttrAccount)];
            } else {
                NSLog(@"ERROR: object must be NSString for PERSISTENT_ITEM_OAUTH_TOKEN");
            }
            break;
        case PERSISTENT_ITEM_OFLY_TOKEN:
            if ([object isKindOfClass:[NSString class]]) {
                [[SflyCore keychain] setObject:object forKey:(__bridge id)(kSecAttrService)];
            } else {
                NSLog(@"ERROR: object must be NSString for PERSISTENT_ITEM_OAUTH_TOKEN");
            }
            break;
        case PERSISTENT_ITEM_REFRESH_TOKEN:
            if ([object isKindOfClass:[NSString class]]) {
                [[SflyCore keychain] setObject:object forKey:(__bridge id)(kSecAttrDescription)];
            } else {
                NSLog(@"ERROR: object must be NSString for PERSISTENT_ITEM_OAUTH_TOKEN");
            }
            break;
        case PERSISTENT_ITEM_OAUTH_EXPIRE:
            if ([object isKindOfClass:[NSDate class]]) {
                [[SflyCore keychain] setObject:object forKey:(__bridge id)(kSecAttrCreationDate)];
            } else {
                NSLog(@"ERROR: object must be NSDate for PERSISTENT_ITEM_OAUTH_EXPIRE");
            }
            break;
    }
}

+ (id)getPersistentItemWithKey:(PersistentItemEnum)item {
    switch (item) {
        case PERSISTENT_ITEM_OAUTH_TOKEN:
            return [[SflyCore keychain] objectForKey:(__bridge id)(kSecAttrAccount)];
            break;
        case PERSISTENT_ITEM_OFLY_TOKEN:
            return [[SflyCore keychain] objectForKey:(__bridge id)(kSecAttrService)];
            break;
        case PERSISTENT_ITEM_REFRESH_TOKEN:
            return [[SflyCore keychain] objectForKey:(__bridge id)(kSecAttrDescription)];
            break;
        case PERSISTENT_ITEM_OAUTH_EXPIRE:
            return [[SflyCore keychain] objectForKey:(__bridge id)(kSecAttrCreationDate)];
            break;
    }
}
*/

// Taken from http://developer.apple.com/library/ios/#qa/qa1719/_index.html
// Note that the use of this function forces the minimum iOS version for the app to be iOS 5.1
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL {
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+ (void) storeDefault: (id) object withKey: (DefaultItemEnum) item {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch (item) {
        case DEFAULT_ITEM_SITE:
            if ([object isKindOfClass:[NSString class]]) {
                [defaults setObject:object forKey:@"lastSite"];
            } else {
                NSLog(@"ERROR: object must be NSString for DEFAULT_ITEM_SITE");
            }
            break;
        case DEFAULT_ITEM_MODULE:
            if ([object isKindOfClass:[NSString class]]) {
                [defaults setObject:object forKey:@"lastModule"];
            } else {
                NSLog(@"ERROR: object must be NSString for DEFAULT_ITEM_MODULE");
            }
            break;
        case LOGIN_FLAG:
            if ([object isKindOfClass:[NSString class]]) {
                [defaults setObject:object forKey:@"loginFlag"];
            } else {
                NSLog(@"ERROR: object must be NSString for DEFAULT_ITEM_MODULE");
            }
            break;

    }
    [defaults synchronize];

}


+ (id) getDefaultItemWithKey: (DefaultItemEnum) item {
    switch (item) {
        case DEFAULT_ITEM_SITE:
            return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastSite"];
            break;
        case DEFAULT_ITEM_MODULE:
            return [[NSUserDefaults standardUserDefaults] objectForKey:@"lastModule"];
            break;
        case LOGIN_FLAG:
            return [[NSUserDefaults standardUserDefaults] objectForKey:@"loginFlag"];
            break;
    }

}
+ (void) removeDefault: (DefaultItemEnum) item {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    switch (item) {
        case DEFAULT_ITEM_SITE:
            [defaults removeObjectForKey: @"lastSite"];
            break;
        case DEFAULT_ITEM_MODULE:
            [defaults removeObjectForKey:@"lastModule"];
            break;
        case LOGIN_FLAG:
            [defaults removeObjectForKey:@"loginFlag"];
            break;
    }
    [defaults synchronize];

}

// Functions for storing last network call information
+ (void)updateDateForRequest:(Class) request site:(NSString*)siteId extraIdentifier:(NSString*)extraIdentifier {
    NSString *key = [NSString stringWithFormat:@"%@+%@+%@", [request description], siteId, extraIdentifier];
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:key];
}

+ (NSDate*)getDateForLastRequest:(Class)request site:(NSString*)siteId extraIdentifier:(NSString*)extraIdentifier {
    NSString *key = [NSString stringWithFormat:@"%@+%@+%@", [request description], siteId, extraIdentifier];
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (NSTimeInterval)timeSinceRequest:(Class)request site:(NSString*)siteId extraIdentifier:(NSString*)extraIdentifier {
    NSTimeInterval timeElapsed = NSTimeIntervalSince1970;
    NSString *key = [NSString stringWithFormat:@"%@+%@+%@", [request description], siteId, extraIdentifier];
    NSDate *requestTime = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (requestTime != NULL) {
        timeElapsed = [[NSDate date] timeIntervalSinceDate:requestTime];
    }
    return timeElapsed;
}

+ (CGRect) resizeLabel: (UILabel *) label text: (NSString *) text {
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    CGSize expectedLabelSize = [text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    CGRect newFrame = label.frame;
    newFrame.size.width = expectedLabelSize.width;
    return newFrame;
}

+ (CGRect) resizeLabelHeight: (UILabel *) label {
    CGSize maximumLabelSize = CGSizeMake(320, FLT_MAX);
    CGSize expectedLabelSize = [label.text sizeWithFont:label.font constrainedToSize:maximumLabelSize lineBreakMode:label.lineBreakMode];
    CGRect newFrame = label.frame;
    newFrame.size.height = expectedLabelSize.height;
    return newFrame;
}

/*+ (BOOL)internetConnectionAvailable {
    return [[Reachability reachabilityForInternetConnection] isReachable];
}

+ (BOOL)apiServerAvailable {
    return [[Reachability reachabilityWithHostname:[SflyConfig shutterflyServerBaseURL]] isReachable];
}

+ (BOOL)shareServerAvailable {
    return [[Reachability reachabilityWithHostname:[SflyConfig shareServerBaseURL]] isReachable];
}*/

@end
