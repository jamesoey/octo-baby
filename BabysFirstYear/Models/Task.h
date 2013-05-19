//
//  Task.h
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Moment, Project;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSNumber * weeksFromStart;
@property (nonatomic, retain) NSString * caption;
@property (nonatomic, retain) NSString * instruction;
@property (nonatomic, retain) Moment *moment;
@property (nonatomic, retain) Project *projects;

+ (Task*)taskWithCaption:(NSString*)cap weeksFromStart:(int)weeks;

@end
