//
//  AssetLibraryController.m
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "AssetsLibraryController.h"

@implementation AssetsLibraryController


+ (AssetsLibraryController*)sharedController {
    static AssetsLibraryController *_sharedController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedController = [AssetsLibraryController new];
    });
    return _sharedController;
}

@end
