//
//  AddPhotoViewController.h
//  ScrapBook
//
//  Created by Szeyin Lee on 9/29/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrapbookItem.h"
#import "ImageSearchViewController.h"

@interface AddPhotoViewController : UIViewController

@property IBOutlet UITextField *imageTitle;
@property IBOutlet UITextField *caption;
@property IBOutlet UIButton *addButton;
@property IBOutlet UIButton *selectImageButton;
@property IBOutlet UIImageView *photo;
@property id target;
@property SEL action;
@property ImageSearchViewController *imageSearchViewController;

-(IBAction)addButtonDidGetPressed:(id)sender;
-(IBAction)imageSearchButtonDidGetPressed:(id)sender;
-(void)clearFields;
-(void)addSelectedImage:(UIImage *)photo;

@end
