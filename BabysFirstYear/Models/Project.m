//
//  Project.m
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "Project.h"
#import "SflyCore.h"
#import "SflyUtility.h"
#import "Task.h"

@implementation Project

@dynamic name;
@dynamic startTime;
@dynamic uid;
@dynamic tasks;

+ (Project*)projectWithName:(NSString*)name {
    Project *project = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:[SflyCore context]];
    
    project.uid = [SflyUtility genUUID];
    project.name = name;

    
    Task *t1 = [Task taskWithCaption:@"baby's arrival" weeksFromStart:1];
    [project addTasksObject:t1];
    
    [project addTasksObject:[Task taskWithCaption:@"tiny body part with parent body part" weeksFromStart:2]];
    [project addTasksObject:[Task taskWithCaption:@"family photo" weeksFromStart:3]];
    [project addTasksObject:[Task taskWithCaption:@"baby's nursery or house" weeksFromStart:4]];
    [project addTasksObject:[Task taskWithCaption:@"sleeping baby" weeksFromStart:5]];
    [project addTasksObject:[Task taskWithCaption:@"first smile" weeksFromStart:6]];
    [project addTasksObject:[Task taskWithCaption:@"being held by family" weeksFromStart:7]];
    [project addTasksObject:[Task taskWithCaption:@"tummy time" weeksFromStart:8]];
    [project addTasksObject:[Task taskWithCaption:@"baby out for a stroll in stroller" weeksFromStart:9]];
    
    Task *t10 = [Task taskWithCaption:@"baby time/water time" weeksFromStart:10];
    [project addTasksObject:t10];
    
    [project addTasksObject:[Task taskWithCaption:@"baby in crib" weeksFromStart:11]];
    [project addTasksObject:[Task taskWithCaption:@"baby with hands/feet in mouth" weeksFromStart:12]];
    [project addTasksObject:[Task taskWithCaption:@"cuddle time with mom or dad" weeksFromStart:13]];
    [project addTasksObject:[Task taskWithCaption:@"baby playing with favorite toy/rattle" weeksFromStart:14]];
    
    [SflyCore saveContext];

    return project;
}

@end
