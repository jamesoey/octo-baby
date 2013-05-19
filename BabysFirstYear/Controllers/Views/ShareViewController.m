//
//  ShareViewController.m
//  BabysFirstYear
//
//  Created by Ming Fu on 5/18/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import "ShareViewController.h"
#import "Task.h"
#import "AssetsLibraryController.h"
#import "TopBarView.h"
#import <QuartzCore/QuartzCore.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface ShareViewController ()

@end

@implementation ShareViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithTask:(Task *)t andProject:(Project *)p {
    self = [super init];
    if (self) {
        self.task = t;
        self.project = p;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    TopBarView *topBarView = [[TopBarView alloc] initWithTitle:self.task.caption];
    [self.view addSubview:topBarView];
    [topBarView.iconMenuButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"imgIntroTile.png"]];
    
    UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(25,100,270,270)];
    photo.layer.borderWidth = 10.0;
    photo.layer.borderColor = [UIColor whiteColor].CGColor;
    
    photo.layer.shadowColor = [[UIColor blackColor] CGColor];
    photo.layer.shadowOffset = CGSizeMake(0, 2);
    photo.layer.shadowOpacity = 0.7;
    photo.layer.masksToBounds = NO;
    
    [self.view addSubview:photo];
    
    UIImageView *overLay = [[UIImageView alloc] initWithFrame:CGRectMake(0,398,360,150)];
    overLay.image = [UIImage imageNamed:@"fmv_overlay.png"];
    [self.view addSubview:overLay];
    
    [[AssetsLibraryController sharedController] imageForURL:self.task.moment.uid success:^(UIImage *image) {
        photo.image = image;
    } failureBlock:^(NSError *error) {
        NSLog(@"ERROR: Cannot add image to FMV image view");
    }];
    
    UIImage *closeImage = [UIImage imageNamed:@"img_delete_face_tag_btn.png"];
    UIButton *close = [UIButton buttonWithType:UIButtonTypeCustom];
    [close setImage:closeImage forState:UIControlStateNormal];
    close.frame = CGRectMake(277,83,closeImage.size.width,closeImage.size.height);
    [close addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:close];
    
    UIImage *shareImage = [UIImage imageNamed:@"fmv_share_btn.png"];
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    [share setImage:shareImage forState:UIControlStateNormal];
    share.frame = CGRectMake(60,482,shareImage.size.width/2.0,shareImage.size.height/2.0);
    [share addTarget:self action:@selector(emailPDFFromUIView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:share];
    
    UIImage *uploadImage = [UIImage imageNamed:@"fmv_upload_btn.png"];
    UIButton *upload = [UIButton buttonWithType:UIButtonTypeCustom];
    [upload setImage:uploadImage forState:UIControlStateNormal];
    upload.frame = CGRectMake(180,482,uploadImage.size.width/2.0,uploadImage.size.height/2.0);
    [upload addTarget:self action:@selector(emailPDFFromUIView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:upload];
    
    UIImage *love = [UIImage imageNamed:@"side_menu_love_photos.png"];
    UIImageView *loveImage = [[UIImageView alloc] initWithImage:love];
    loveImage.frame = CGRectMake(100,400,love.size.width/2.0, love.size.height/2.0);
    [self.view addSubview:loveImage];
    
    
    NSSortDescriptor *weekSort = [[NSSortDescriptor alloc] initWithKey:@"weeksFromStart" ascending:YES];
    NSArray *tasks = [self.project.tasks sortedArrayUsingDescriptors:@[weekSort]];
    
    self.pdfView = [[UIView alloc] initWithFrame:CGRectMake(0,0,400,320*[tasks count]+20)];
    
    int yoffset = 20;
    for (Task *t in tasks) {
        
        UIImageView *photo = [[UIImageView alloc] initWithFrame:CGRectMake(50,yoffset,300,300)];
        [[AssetsLibraryController sharedController] imageForURL:t.moment.uid success:^(UIImage *image) {
            photo.image = image;
        } failureBlock:^(NSError *error) {
        }];
        yoffset += 320;
        [self.pdfView addSubview:photo];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)emailPDFFromUIView {
    
    NSMutableData *pdfData = [NSMutableData data];
    UIGraphicsBeginPDFContextToData(pdfData, self.pdfView.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    [self.pdfView.layer renderInContext:pdfContext];
    UIGraphicsEndPDFContext();
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailer = [[MFMailComposeViewController alloc] init];
        mailer.mailComposeDelegate = self;
        [mailer setSubject:[NSString stringWithFormat:@"Print Order: %@'s First Year Photobook!", self.project.name]];
        [mailer setMessageBody:@"This photobook is amazing! Take all my moonies." isHTML:NO];
        [mailer addAttachmentData:pdfData mimeType:@"application/pdf" fileName:@"BabysFirstYear"];
        [self presentModalViewController:mailer animated:YES];
    }
    
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissModalViewControllerAnimated:YES];
}

@end
