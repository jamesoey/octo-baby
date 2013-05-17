//
//  SflyData.h
//  SFLibSandBox
//
//  Created by James Oey on 11/14/12.
//  Copyright (c) 2012 Shutterfly. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Project;

@interface SflyData : NSObject

+(SflyData*)sharedClient;
+(Project*)project;

@end
