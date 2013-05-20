//
//  SflyCore.m
//  SFLibSandBox
//
//  Created by James Oey on 11/12/12.
//  Copyright (c) 2012 Shutterfly. All rights reserved.
//

#import "SflyCore.h"

@implementation SflyCore

static id<SflyLibraryDelegate> appDelegate;
static UIViewController *mainVC;

+ (void)initWithAppDelegate:(id<SflyLibraryDelegate>)del {
    appDelegate = del;
}

+ (NSString*)documentsDirectory {
    return [appDelegate applicationDocumentsDirectory];
}

+ (NSManagedObjectContext*)context {
    return [appDelegate managedObjectContext];
}

+ (void)saveContext {
    dispatch_async(dispatch_get_main_queue(),
                  ^(void) {
                      //DLog(@"INFO: saving context");
                      NSError *error = nil;
                      NSManagedObjectContext *context = [SflyCore context];
                      if (context != nil) {
                          if ([context hasChanges] && ![context save:&error]) {
                              NSLog(@"Error in context save: %@, %@", error, [error userInfo]);
                          }
                      }
                  }
                  );
}

+ (void)saveContextWithCompletion:(void (^)(void))completion {
    dispatch_async(dispatch_get_main_queue(),
                   ^(void) {
                       //DLog(@"INFO: saving context");
                       NSError *error = nil;
                       NSManagedObjectContext *context = [SflyCore context];
                       if (context != nil) {
                           if ([context hasChanges] && ![context save:&error]) {
                               NSLog(@"Error in context save: %@, %@", error, [error userInfo]);
                           } else {
                               if (completion) completion();
                           }
                       }
                   }
                   
                );
}

+ (NSOperationQueue*)imageQueue {
    static NSOperationQueue *queue;
    if (queue == NULL) {
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 5;
    }
    return queue;
}


/*+ (CGFloat)drawScale {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"4.0")) {
        return [[UIScreen mainScreen] scale];
    } else {
        return 1.0;
    }
}*/

+ (void)storeMainViewController:(UIViewController*)vc {
    mainVC = vc;
}

+ (UIViewController*)mainViewController {
    return mainVC;
}

@end
