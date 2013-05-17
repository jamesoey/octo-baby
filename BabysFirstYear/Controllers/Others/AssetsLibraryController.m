//
//  AssetLibraryController.m
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "AssetsLibraryController.h"
#import "Moment.h"

@implementation AssetsLibraryController


+ (AssetsLibraryController*)sharedController {
    static AssetsLibraryController *_sharedController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedController = [AssetsLibraryController new];
        _sharedController.assetsLibrary = [[ALAssetsLibrary alloc] init];
    });
    return _sharedController;
}

- (void)saveImage:(UIImage*)image toMoment:(Moment*)moment {
    CGImageRef imageRef = image.CGImage;

    [self.assetsLibrary writeImageToSavedPhotosAlbum:imageRef
                                         orientation:ALAssetOrientationUp
                                     completionBlock:^(NSURL *assetURL, NSError *error) {
                                         if (error == nil) {
                                             moment.uid = [assetURL absoluteString];
                                         } else {
                                             NSLog(@"ERROR: Could not write image to photo album");
                                         }
                                     }];
}

@end
