//
//  PhotoDetailViewController.m
//  ScrapBook
//
//  Created by Szeyin Lee on 9/28/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import "PhotoDetailViewController.h"

@interface PhotoDetailViewController ()

@end

@implementation PhotoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.navigationItem setTitle:@"Photo Details"];
    }
    return self;
}

- (void)setFieldsWithPhoto:(UIImage *)newPic andTitle:(NSString *)newTitle andCap:(NSString *)newCap
{
    [self.view setNeedsDisplay];
    [self.photo setImage:newPic];
    [self.imageTitle setText:newTitle];
    [self.caption setText:newCap];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
