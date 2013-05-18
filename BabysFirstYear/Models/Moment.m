//
//  Moment.m
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "Moment.h"
#import "SflyUtility.h"
#import "SflyCore.h"
#import "AssetsLibraryController.h"
#import "Task.h"

@implementation Moment

@dynamic height;
@dynamic width;
@dynamic uid;
@dynamic tasks;

+ (Moment*)moment {
    Moment *moment = [NSEntityDescription insertNewObjectForEntityForName:@"Moment" inManagedObjectContext:[SflyCore context]];
    moment.uid = [SflyUtility genUUID];
    return moment;
}

/*- (UIImage*)image {
    NSURL *url = [[NSURL alloc] initWithString:@"asdfasdf"];
    
}*/

@end
