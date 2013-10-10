//
//  PhotoDetailViewController.h
//  ScrapBook
//
//  Created by Szeyin Lee on 9/28/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "INETImageView.h"

@interface PhotoDetailViewController : UIViewController

@property IBOutlet UIImageView *photo;

@property IBOutlet UILabel *imageTitle;

@property IBOutlet UILabel *caption;

- (void)setFieldsWithPhoto:(UIImage *)newPic andTitle:(NSString *)newTitle andCap:(NSString *)newCap;

@end
