//
//  Project.h
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Project : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSSet *tasks;
@property (nonatomic, retain) NSNumber *isBoy;

+ (Project*)projectWithName:(NSString*)name isBoy:(BOOL)isBoy;

// his/her
- (NSString*)possessive;
// him/her
- (NSString*)objectivePronoun;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addTasksObject:(NSManagedObject *)value;
- (void)removeTasksObject:(NSManagedObject *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;

@end
