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
#import "Moment.h"
#import "AssetsLibraryController.h"

@implementation Project

@dynamic name;
@dynamic startTime;
@dynamic uid;
@dynamic tasks;

+ (Project*)project {
    Project *project = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:[SflyCore context]];
    
    project.uid = [SflyUtility genUUID];

    
    Task *t1 = [Task taskWithCaption:@"baby's arrival" weeksFromStart:1];
    [project addTasksObject:t1];
    Moment *m1 = [Moment moment];
    [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"baby0.jpg"] toMoment:m1];
    t1.moment = m1;
    
    Task *t2 = [Task taskWithCaption:@"tiny body part with parent body part" weeksFromStart:2];
    [project addTasksObject:t2];
    Moment *m2 = [Moment moment];
    [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"baby1.jpg"] toMoment:m2];
    t2.moment = m2;

    Task *t3 = [Task taskWithCaption:@"family photo" weeksFromStart:3];
    [project addTasksObject:t3];
    Moment *m3 = [Moment moment];
    [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"baby2.jpg"] toMoment:m3];
    t3.moment = m3;

    [project addTasksObject:[Task taskWithCaption:@"baby's nursery or house" weeksFromStart:4]];
    [project addTasksObject:[Task taskWithCaption:@"sleeping baby" weeksFromStart:5]];
    [project addTasksObject:[Task taskWithCaption:@"first smile" weeksFromStart:6]];
    [project addTasksObject:[Task taskWithCaption:@"being held by family" weeksFromStart:7]];
    [project addTasksObject:[Task taskWithCaption:@"tummy time" weeksFromStart:8]];
    [project addTasksObject:[Task taskWithCaption:@"baby out for a stroll in stroller" weeksFromStart:9]];
    
    Task *t10 = [Task taskWithCaption:@"baby time/water time" weeksFromStart:10];
    [project addTasksObject:t10];
    Moment *m10 = [Moment moment];
    [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"bath.jpg"] toMoment:m10];
    t10.moment = m10;
    
    [project addTasksObject:[Task taskWithCaption:@"baby in crib" weeksFromStart:11]];
    [project addTasksObject:[Task taskWithCaption:@"baby with hands/feet in mouth" weeksFromStart:12]];
    [project addTasksObject:[Task taskWithCaption:@"cuddle time with mom or dad" weeksFromStart:13]];
    [project addTasksObject:[Task taskWithCaption:@"baby playing with favorite toy/rattle" weeksFromStart:14]];
    
    [SflyCore saveContext];

    return project;
}

@end
