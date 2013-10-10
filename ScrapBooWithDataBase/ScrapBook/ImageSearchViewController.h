//
//  ImageSearchViewController.h
//  ScrapBook
//
//  Created by Szeyin Lee on 9/30/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISInstagramTagSearcher.h"
#import "FSFlickrTagSearcher.h"
#import "INETImageView.h"

@interface ImageSearchViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) FSFlickrTagSearcher *flickrSearcher;
@property (strong, nonatomic) ISInstagramTagSearcher *instaSearcher;
@property NSMutableArray *imageSearchResults; // the main data array
@property UIView *imageSelected;
@property id target;
@property SEL action;

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;

@end
