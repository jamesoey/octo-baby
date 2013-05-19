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
#import "SflyData.h"

@implementation AssetsLibraryController


+ (AssetsLibraryController*)sharedController {
    static AssetsLibraryController *_sharedController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedController = [AssetsLibraryController new];
        _sharedController.assetsLibrary = [[ALAssetsLibrary alloc] init];
        _sharedController.queue =[[NSOperationQueue alloc] init];
    });
    return _sharedController;
}

- (void)saveImage:(UIImage*)image completion:(void (^)(NSURL *assetURL))successBlock {
    CGImageRef imageRef = image.CGImage;
    [self.assetsLibrary writeImageToSavedPhotosAlbum:imageRef
                                         orientation:(ALAssetOrientation)[image imageOrientation]
                                     completionBlock:^(NSURL *assetURL, NSError *error) {
                                         if (error == nil) {
                                             if (successBlock) {
                                                 successBlock(assetURL);
                                             }
                                         } else {
                                             NSLog(@"ERROR: Could not write image to photo album. %@", [error localizedDescription]);
                                         }
                                     }];
}

- (void)imageForURL:(NSString*)urlString success:(void (^)(UIImage *image))successBlock failureBlock:(void (^)(NSError *error))failureBlock {
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        CGFloat scale  = 1;

        ALAssetOrientation orientation = [[myasset valueForProperty:@"ALAssetPropertyOrientation"] intValue];
        // Retrieve the image orientation from the EXIF data
        if (iref) {
            UIImage *image = [UIImage imageWithCGImage:iref scale:scale orientation:orientation];
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
