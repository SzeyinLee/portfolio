//
//  AddPhotoViewController.m
//  ScrapBook
//
//  Created by Szeyin Lee on 9/29/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import "AddPhotoViewController.h"

@interface AddPhotoViewController ()

@end

@implementation AddPhotoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Custom initialization
        [self.navigationItem setTitle:@"Add Photo"];
        self.imageSearchViewController = [[ImageSearchViewController alloc] initWithStyle:UITableViewStylePlain];
        self.imageSearchViewController.target = self;
        self.imageSearchViewController.action = @selector(addSelectedImage:);
    }
    return self;
}

-(void)addSelectedImage:(UIImage *)photo
{
    [self.photo setImage:photo];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.photo setImage:nil];
}


-(IBAction)addButtonDidGetPressed:(id)sender {
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(self.photo.image)];
    NSMutableDictionary *temp = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:self.imageTitle.text, self.caption.text, imageData, nil] forKeys:[NSArray arrayWithObjects:@"title", @"caption", @"photo", nil]];
    [self.target performSelector:self.action withObject:temp];
    [self.navigationController popViewControllerAnimated:YES];
    [self clearFields];
    
}

-(void)clearFields
{
    [self.photo setImage:nil];
    [self.imageTitle setText:@""];
    [self.caption setText:@""];
}

-(IBAction)imageSearchButtonDidGetPressed:(id)sender {
    [self.navigationController pushViewController:self.imageSearchViewController animated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.imageTitle.isFirstResponder) {
        [self.imageTitle resignFirstResponder];
    }
    if (self.caption.isFirstResponder) {
        [self.caption resignFirstResponder];
    }
    return YES;
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
