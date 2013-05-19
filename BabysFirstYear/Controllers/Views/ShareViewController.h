//
//  ShareViewController.h
//  BabysFirstYear
//
//  Created by Ming Fu on 5/18/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "Project.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ShareViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) Task *task;
@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) UIView *pdfView;

- (id)initWithTask:(Task *)t andProject:(Project *)p;

@end
