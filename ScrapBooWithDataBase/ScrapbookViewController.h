//
//  ScrapbookViewController.h
//  ScrapBook
//
//  Created by Szeyin Lee on 9/28/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPhotoViewController.h"
#import "PhotoDetailViewController.h"
#import "ScrapbookItem.h"

@interface ScrapbookViewController : UITableViewController

@property NSMutableArray *photolist; // the main data array
@property AddPhotoViewController *addPhotoViewController;
@property PhotoDetailViewController *photoDetailViewController;

- (void)addPhoto:(NSMutableDictionary *)photoInfo;
- (void)addButtonPressed;



@end
