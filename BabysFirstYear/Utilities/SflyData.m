//
//  SFlyData.m
//  SFLibSandBox
//
//  Created by James Oey on 11/14/12.
//  Copyright (c) 2012 Shutterfly. All rights reserved.
//

#import "SflyData.h"
#import "SflyCore.h"


@implementation SflyData

+(SflyData*)sharedClient {
    static SflyData *sharedClient = nil;
    if(!sharedClient)
        sharedClient = [[SflyData alloc] init];
    return sharedClient;
}

+(NSArray*)genericRequestWithEntity:(NSString*)entityName predicate:(NSPredicate*)predicate {
    NSEntityDescription *description = [NSEntityDescription entityForName:entityName inManagedObjectContext:[SflyCore context]];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    if (predicate != nil) {
        [request setPredicate:predicate];
    }
    [request setEntity:description];
    
    NSError *error;
    NSArray *array = [[SflyCore context] executeFetchRequest:request error:&error];
    return array;
}

+(NSArray*)genericRequestWithEntity:(NSString*)entityName predicate:(NSPredicate*)predicate sortWithKey:(NSString*)key{
  NSEntityDescription *description = [NSEntityDescription entityForName:entityName inManagedObjectContext:[SflyCore context]];
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  if (predicate != nil) {
    [request setPredicate:predicate];
  }
  [request setEntity:description];
  
  NSSortDescriptor *sortDesc = [[NSSortDescriptor alloc] initWithKey:key ascending:YES selector:@selector(caseInsensitiveCompare:)];
  NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDesc, nil];
  [request setSortDescriptors:sortDescriptors];
  
  NSError *error;
  NSArray *array = [[SflyCore context] executeFetchRequest:request error:&error];
  return array;
}

+ (Project*)project {
    NSArray *projectArray = [SflyData genericRequestWithEntity:@"Project" predicate:nil];
    if ([projectArray count] == 0) {
        return nil;
    } else if ([projectArray count] != 1) {
        NSLog(@"ERROR: more than one project. Excpected 1!");
        return [projectArray objectAtIndex:0];
    } else {
        return [projectArray objectAtIndex:0];
    }
}

+ (NSArray*)moments {
    return [SflyData genericRequestWithEntity:@"Moment" predicate:nil];
}

@end