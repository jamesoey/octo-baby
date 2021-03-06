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
@dynamic isBoy;


+ (Project*)projectWithName:(NSString*)name isBoy:(BOOL)isBoy; {
    Project *project = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:[SflyCore context]];
    
    project.uid = [SflyUtility genUUID];
    project.name = name;
    project.isBoy = [NSNumber numberWithBool:isBoy];
    
    Task *t0 = [Task taskWithCaption:@"First Photo of BABY" weeksFromStart:0];
    t0.instruction = @"Let's get started. Take a photo of BABY right now.";
    [project addTasksObject:t0];
    Moment *m0 = [Moment moment];
    [t0 setMoment:m0];
    
    Task *t1 = [Task taskWithCaption:@"BABY arrives" weeksFromStart:1];
    t1.instruction = @"Take a photo of BABY's arrival.";
    [project addTasksObject:t1];
    Moment *m1 = [Moment moment];
    [t1 setMoment:m1];
    
    Task *t2 = [Task taskWithCaption:@"Tiny hands" weeksFromStart:2];
    t2.instruction = @"Capture BABY's tiny hands.";
    [project addTasksObject:t2];
    Moment *m2 = [Moment moment];
    [t2 setMoment:m2];

    Task *t3 = [Task taskWithCaption:@"Grandma holding BABY" weeksFromStart:3];
    t3.instruction = @"Take a picture of Grandma holding BABY.";
    [project addTasksObject:t3];
    Moment *m3 = [Moment moment];
    [t3 setMoment:m3];
    
    Task *t4 = [Task taskWithCaption:@"BABY sleeping" weeksFromStart:4];
    t4.instruction = @"Take a picture when BABY is sleeping.";
    [project addTasksObject:t4];
    Moment *m4 = [Moment moment];
    [t4 setMoment:m4];
    
    Task *t5 = [Task taskWithCaption:@"Funny face" weeksFromStart:5];
    t5.instruction = @"Capture a picture of BABY's funny face.";
    [project addTasksObject:t5];
    Moment *m5 = [Moment moment];
    [t5 setMoment:m5];
    
    Task *t6 = [Task taskWithCaption:@"Sleeping on dad" weeksFromStart:6];
    t6.instruction = @"Take a picture of BABY sleeping on dad.";
    [project addTasksObject:t6];
    Moment *m6 = [Moment moment];
    [t6 setMoment:m6];
    
    Task *t7 = [Task taskWithCaption:@"Held by mom" weeksFromStart:7];
    t7.instruction = @"Capture a picture of BABY being held by mom.";
    [project addTasksObject:t7];
    Moment *m7 = [Moment moment];
    [t7 setMoment:m7];
    
    Task *t8 = [Task taskWithCaption:@"Bundled up BABY" weeksFromStart:8];
    t8.instruction = @"Take a picture of BABY all bundled up.";
    [project addTasksObject:t8];
    Moment *m8 = [Moment moment];
    [t8 setMoment:m8];
    
    Task *t9 = [Task taskWithCaption:@"Favorite toy" weeksFromStart:9];
    t9.instruction = [NSString stringWithFormat:@"Take a picture of BABY with %@ favorite toy.", [project possessive]];
    [project addTasksObject:t9];
    Moment *m9 = [Moment moment];
    [t9 setMoment:m9];
    
    Task *t10 = [Task taskWithCaption:@"BABY in the sling" weeksFromStart:10];
    t10.instruction = [NSString stringWithFormat:@"Take a picture of BABY with %@ in her sling.", [project possessive]];
    [project addTasksObject:t10];
    Moment *m10 = [Moment moment];
    [t10 setMoment:m10];
    
    Task *t11 = [Task taskWithCaption:@"Burping BABY" weeksFromStart:11];
    t11.instruction = @"Take a picture of BABY being burped.";
    [project addTasksObject:t11];
    Moment *m11 = [Moment moment];
    [t11 setMoment:m11];
    
    Task *t12 = [Task taskWithCaption:@"Wearing a bonnet" weeksFromStart:12];
    t12.instruction = @"Take a picture of BABY wearing a bonnet.";
    [project addTasksObject:t12];
    Moment *m12 = [Moment moment];
    [t12 setMoment:m12];
    
    Task *t13 = [Task taskWithCaption:@"Mom kissing BABY" weeksFromStart:13];
    t13.instruction = @"Take a picture of mom kissing BABY.";
    [project addTasksObject:t13];
    Moment *m13 = [Moment moment];
    [t13 setMoment:m13];
    
    Task *t14 = [Task taskWithCaption:@"Cuddle time" weeksFromStart:14];
    t14.instruction = @"Capture cuddle time.";
    [project addTasksObject:t14];
    Moment *m14 = [Moment moment];
    [t14 setMoment:m14];
    
    Task *t15 = [Task taskWithCaption:@"Hanging out" weeksFromStart:15];
    t15.instruction = @"Capture a moment of BABY hanging out.";
    [project addTasksObject:t15];
    Moment *m15 = [Moment moment];
    [t15 setMoment:m15];
    
    Task *t16 = [Task taskWithCaption:@"Fast asleep" weeksFromStart:16];
    t16.instruction = @"Capture a picture of BABY's fast asleep.";
    [project addTasksObject:t16];
    Moment *m16 = [Moment moment];
    [t16 setMoment:m16];
    
    Task *t17 = [Task taskWithCaption:@"In the bath" weeksFromStart:17];
    t17.instruction = @"Capture a picture of BABY taking a bath.";
    [project addTasksObject:t17];
    Moment *m17 = [Moment moment];
    [t17 setMoment:m17];
    
    Task *t18 = [Task taskWithCaption:@"Adorable" weeksFromStart:18];
    t18.instruction = @"Capture an adorable moment.";
    [project addTasksObject:t18];
    Moment *m18 = [Moment moment];
    [t18 setMoment:m18];
    
    Task *t19 = [Task taskWithCaption:@"BABY's smile" weeksFromStart:19];
    t19.instruction = [NSString stringWithFormat:@"Capture a picture of BABY with %@ smile.", [project possessive]];
    [project addTasksObject:t19];
    Moment *m19 = [Moment moment];
    [t19 setMoment:m19];
    
    Task *t20 = [Task taskWithCaption:@"Family" weeksFromStart:20];
    t20.instruction = [NSString stringWithFormat:@"Capture a picture of BABY and %@ family.", [project possessive]];
    [project addTasksObject:t20];
    
    Task *t21 = [Task taskWithCaption:@"The nursery" weeksFromStart:21];
    t21.instruction = @"Capture a picture of BABY's nursery.";
    [project addTasksObject:t21];
    
    Task *t22 = [Task taskWithCaption:@"Tummy time" weeksFromStart:22];
    t22.instruction = @"Capture a picture of tummy time.";
    [project addTasksObject:t22];
    
    Task *t23 = [Task taskWithCaption:@"Out for a stroll" weeksFromStart:23];
    t23.instruction = @"Capture a picture of BABY out for a stroll.";
    [project addTasksObject:t23];
    
    Task *t24 = [Task taskWithCaption:@"Cribbing" weeksFromStart:24];
    t24.instruction = [NSString stringWithFormat:@"Capture a picture of BABY in %@ crib.", [project possessive]];
    [project addTasksObject:t24];
    
    Task *t25 = [Task taskWithCaption:@"Hands in mouth" weeksFromStart:25];
    t25.instruction = [NSString stringWithFormat:@"Capture a picture of BABY's hand in %@ mouth.", [project possessive]];
    [project addTasksObject:t25];
    
    Task *t26 = [Task taskWithCaption:@"BABY yawning" weeksFromStart:26];
    t26.instruction = @"Take a picture of BABY yawning.";
    [project addTasksObject:t26];
    
    Task *t27 = [Task taskWithCaption:@"BABY sitting up" weeksFromStart:27];
    t27.instruction = @"Capture a picture of BABY sitting up.";
    [project addTasksObject:t27];
    
    Task *t28 = [Task taskWithCaption:@"Haircut" weeksFromStart:28];
    t28.instruction = [NSString stringWithFormat:@"Capture a picture of BABY getting %@ first haircut.", [project possessive]];
    [project addTasksObject:t28];
    
    Task *t29 = [Task taskWithCaption:@"Favorite blanket" weeksFromStart:29];
    t29.instruction = [NSString stringWithFormat:@"Capture a picture of BABY with %@ favorite blanket.", [project possessive]];
    [project addTasksObject:t29];

    
    [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"01.jpg"] completion:^(NSURL *assetURL) {
        NSLog(@"saved image 1");
        m1.uid = [assetURL absoluteString];
        [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"02.jpg"] completion:^(NSURL *assetURL) {
            NSLog(@"saved image 2");
            m2.uid = [assetURL absoluteString];
            [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"03.jpg"] completion:^(NSURL *assetURL) {
                NSLog(@"saved image 3");
                m3.uid = [assetURL absoluteString];
                [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"04.jpg"] completion:^(NSURL *assetURL) {
                    NSLog(@"saved image 4");
                    m4.uid = [assetURL absoluteString];
                    [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"05.jpg"] completion:^(NSURL *assetURL) {
                        NSLog(@"saved image 5");
                        m5.uid = [assetURL absoluteString];
                        [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"06.jpg"] completion:^(NSURL *assetURL) {
                            NSLog(@"saved image 6");
                            m6.uid = [assetURL absoluteString];
                            [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"07.jpg"] completion:^(NSURL *assetURL) {
                                NSLog(@"saved image 7");
                                m7.uid = [assetURL absoluteString];
                                [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"08.jpg"] completion:^(NSURL *assetURL) {
                                    NSLog(@"saved image 8");
                                    m8.uid = [assetURL absoluteString];
                                    [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"09.jpg"] completion:^(NSURL *assetURL) {
                                        NSLog(@"saved image 9");
                                        m9.uid = [assetURL absoluteString];
                                        [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"10.jpg"] completion:^(NSURL *assetURL) {
                                            NSLog(@"saved image 10");
                                            m10.uid = [assetURL absoluteString];
                                            [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"11.jpg"] completion:^(NSURL *assetURL) {
                                                NSLog(@"saved image 11");
                                                m11.uid = [assetURL absoluteString];
                                                [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"12.jpg"] completion:^(NSURL *assetURL) {
                                                    NSLog(@"saved image 12");
                                                    m12.uid = [assetURL absoluteString];
                                                    [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"13.jpg"] completion:^(NSURL *assetURL) {
                                                        NSLog(@"saved image 13");
                                                        m13.uid = [assetURL absoluteString];
                                                        [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"14.jpg"] completion:^(NSURL *assetURL) {
                                                            NSLog(@"saved image 14");
                                                            m14.uid = [assetURL absoluteString];
                                                            [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"15.jpg"] completion:^(NSURL *assetURL) {
                                                                NSLog(@"saved image 15");
                                                                m15.uid = [assetURL absoluteString];
                                                                [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"16.jpg"] completion:^(NSURL *assetURL) {
                                                                    NSLog(@"saved image 16");
                                                                    m16.uid = [assetURL absoluteString];
                                                                    [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"17.jpg"] completion:^(NSURL *assetURL) {
                                                                        NSLog(@"saved image 17");
                                                                        m17.uid = [assetURL absoluteString];
                                                                        [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"18.jpg"] completion:^(NSURL *assetURL) {
                                                                            NSLog(@"saved image 18");
                                                                            m18.uid = [assetURL absoluteString];
                                                                            [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"19.jpg"] completion:^(NSURL *assetURL) {
                                                                                NSLog(@"saved image 19");
                                                                                m19.uid = [assetURL absoluteString];
                                                                                [[AssetsLibraryController sharedController] saveImage:[UIImage imageNamed:@"title_page.jpg"] completion:^(NSURL *assetURL) {
                                                                                    NSLog(@"saved image title_page");
                                                                                }];
                                                                            }];
                                                                        }];
                                                                    }];
                                                                }];
                                                            }];
                                                        }];
                                                    }];
                                                }];
                                            }];
                                        }];
                                    }];
                                }];
                            }];
                        }];
                    }];
                }];
            }];
        }];
    }];

    
    
    return project;
}


- (NSString*)possessive {
    if ([self.isBoy boolValue]) {
        return @"his";
    } else {
        return @"her";
    }
}

- (NSString*)objectivePronoun {
    if ([self.isBoy boolValue]) {
        return @"him";
    } else {
        return @"her";
    }
}

@end
