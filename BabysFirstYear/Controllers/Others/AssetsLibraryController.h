//
//  AssetLibraryController.h
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "Moment.h"

@interface AssetsLibraryController : NSObject

+ (AssetsLibraryController*)sharedController;
- (void)saveImage:(UIImage*)image toMoment:(Moment*)moment completion:(void (^)())successBlock ;
- (void)imageForURL:(NSString*)urlString success:(void (^)(UIImage *image))successBlock failureBlock:(void (^)(NSError *error))failureBlock;

@property (nonatomic, retain) ALAssetsLibrary *assetsLibrary;

@end
