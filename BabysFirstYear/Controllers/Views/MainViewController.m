//
//  MainViewController.m
//  BabysFirstYear
//
//  Created by James Oey on 5/16/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "MainViewController.h"
#import "Project.h"
#import "MainView.h"
#import "TaskTableViewCell.h"
#import "SflyData.h"

@interface MainViewController () {
    Project *project;
    MainView *mainView;
    NSArray *tasks;
}
@end

@implementation MainViewController

- (id)initWithProject:(Project*)p {
    self = [super init];
    if (self) {
        project = p;
        NSSortDescriptor *weekSort = [[NSSortDescriptor alloc] initWithKey:@"weeksFromStart" ascending:YES];
        tasks = [project.tasks sortedArrayUsingDescriptors:@[weekSort]];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) loadView {
    CGRect bounds = [[UIScreen mainScreen] bounds];
    mainView = [[MainView alloc] initWithFrame:bounds project:project];
    
    mainView.taskTableView.dataSource = self;
    mainView.taskTableView.delegate = self;
    
    
    self.view = mainView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView functions

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tasks count];
}

- (int)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskTableViewCell"];
    if (!cell) {
        cell = [[TaskTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TaskTableViewCell"];
    }

    [cell updateWithTask:[tasks objectAtIndex:indexPath.row]];
    return cell;
}


@end
