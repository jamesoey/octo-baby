//
//  Task.m
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "Task.h"
#import "Moment.h"
#import "Project.h"
#import "SflyCore.h"
#import "SflyUtility.h"

@implementation Task

@dynamic uid;
@dynamic weeksFromStart;
@dynamic caption;
@dynamic moment;
@dynamic projects;

+ (Task*)taskWithCaption:(NSString*)cap weeksFromStart:(int)weeks {
    Task *task = [NSEntityDescription insertNewObjectForEntityForName:@"Task" inManagedObjectContext:[SflyCore context]];
    
    task.uid = [SflyUtility genUUID];
    task.weeksFromStart = [NSNumber numberWithInt:weeks];
    task.caption = cap;
    
    [SflyCore saveContext];
    
    return task;

}

@end
