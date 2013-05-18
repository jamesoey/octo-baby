//
//  CaptureMomentViewController.h
//  BabysFirstYear
//
//  Created by James Oey on 5/17/13.
//  Copyright (c) 2013 Shutterfly, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Task;

@interface CaptureMomentViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (id)initWithTask:(Task*)t;

@end
