//
//  SflyCore.h
//  SFLibSandBox
//
//  Created by James Oey on 11/12/12.
//  Copyright (c) 2012 Shutterfly. All rights reserved.
//

#import <Foundation/Foundation.h>


// Protocol to connect key singletons outside of SflyLibrary
// to within the library
@protocol SflyLibraryDelegate
- (NSManagedObjectContext *)managedObjectContext;
- (NSString *)applicationDocumentsDirectory;
@end

@interface SflyCore : NSObject

//+ (SflyCore*)sharedCore;
+ (void)initWithAppDelegate:(id<SflyLibraryDelegate>)del;

+ (NSManagedObjectContext*)context;
+ (NSString*)documentsDirectory;
+ (void)saveContext;
+ (NSOperationQueue*)imageQueue;
+ (CGFloat)drawScale;
+ (void)storeMainViewController:(UIViewController*)vc;
+ (UIViewController*)mainViewController;

@end
