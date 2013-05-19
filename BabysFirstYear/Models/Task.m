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
#import "SflyData.h"

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
    NSString *name = [[SflyData project] name];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"BABY" options:0 error:nil];
    NSMutableString *mutableCap = [NSMutableString stringWithString:cap];
    [regex replaceMatchesInString:mutableCap options:0 range:NSMakeRange(0, [cap length]) withTemplate:name];
    task.caption = mutableCap;
    return task;

}

@end
