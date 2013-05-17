//
//  AssetLibraryController.m
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "AssetsLibraryController.h"
#import "Moment.h"
#import "SflyCore.h"

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
                                             [SflyCore saveContext];
                                         } else {
                                             NSLog(@"ERROR: Could not write image to photo album");
                                         }
                                     }];
}

- (void)imageForURL:(NSString*)urlString success:(void (^)(UIImage *image))successBlock failureBlock:(void (^)(NSError *error))failureBlock {
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            UIImage *image = [UIImage imageWithCGImage:iref];
            successBlock(image);
        }
    };
    
    //
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *error)
    {
        NSLog(@"booya, cant get image - %@",[error localizedDescription]);
        if (failureBlock) {
            failureBlock(error);
        }
    };
    
    if(urlString && [urlString length]) {
        NSURL *asseturl = [NSURL URLWithString:urlString];
        [self.assetsLibrary assetForURL:asseturl
                       resultBlock:resultblock
                      failureBlock:failureblock];
    }}

@end
