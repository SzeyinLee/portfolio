//
//  ImageSearchViewController.m
//  ScrapBook
//
//  Created by Szeyin Lee on 9/30/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import "ImageSearchViewController.h"

@interface ImageSearchViewController ()

@end

@implementation ImageSearchViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.imageSearchResults = [[NSMutableArray alloc] initWithCapacity:0];
        
        // register the type of view to create for a table cell
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
        //Setup SearchBar
        self.searchBar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
        self.searchBar.delegate = self;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.searchBar;
}

//IF USER PRESS BACK, CLEAR FILLED FIELDS
- (void)viewWillDisappear:(BOOL)animated {
    [self.imageSearchResults removeAllObjects];
    [self.tableView reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    if (self.searchBar.isFirstResponder) {
        [self.searchBar resignFirstResponder];
    }
    NSString *tag = searchBar.text;
    //For Debugging
    //NSLog(@"%@", tag);
    [self.imageSearchResults removeAllObjects];
    [self.tableView reloadData];
    self.instaSearcher = [[ISInstagramTagSearcher alloc] initWithTagQuery:tag andTarget:self andAction:@selector(handleInstagramData:)];
    self.flickrSearcher = [[FSFlickrTagSearcher alloc] initWithTagQuery:tag andTarget:self andAction:@selector(handleFlickrData:)];
}


- (void) handleInstagramData:(NSMutableDictionary *)data
{
    NSMutableArray *photos = [data objectForKey:@"data"];
    
    int i = 0;
    for (NSMutableDictionary *photo in photos) {
        NSString *photo_link = [[[photo objectForKey:@"images"] objectForKey:@"low_resolution"] objectForKey:@"url"];
        INETImageView* image = [[INETImageView alloc] initWithURL:[NSURL URLWithString:photo_link] andFrame:CGRectMake(100, 0, 100, 150)];
        [self.imageSearchResults addObject:image];
        ++i;
    }
    NSLog(@"reach instagram");
    //NSUInteger intVal = [self.imageSearchResults count];
    //int iInt1 = (int)intVal;
    //NSLog(@"value : %lu %d", (unsigned long)intVal, iInt1);
    
}

- (void) handleFlickrData:(NSMutableDictionary *)data
{
    NSMutableArray *photos = [[data objectForKey:@"photos"] objectForKey:@"photo"];
    
    int i = 0;
    for (NSMutableDictionary *photo in photos) {
        
        NSString *farm = [photo objectForKey:@"farm"];
        NSString *server = [photo objectForKey:@"server"];
        NSString *photo_id = [photo objectForKey:@"id"];
        NSString *secret = [photo objectForKey:@"secret"];
        
        NSArray *p_link = [ NSArray arrayWithObjects: @"http://farm", farm, @".staticflickr.com/", server, @"/", photo_id, @"_", secret, @"_m.jpg", nil];
        NSString *photo_link= [p_link componentsJoinedByString: @""];
        INETImageView* image = [[INETImageView alloc] initWithURL:[NSURL URLWithString:photo_link] andFrame:CGRectMake(100, 0, 100, 150)];
        // coordinates are how top left corners of the picture
        [self.imageSearchResults addObject:image];
        ++i;
    }
    NSLog(@"reach flickr");
    [self.tableView reloadData];
    //NSUInteger intVal = [self.imageSearchResults count];
    //int iInt1 = (int)intVal;
    //NSLog(@"value : %lu %d", (unsigned long)intVal, iInt1);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"selected");
    UIImage *temp=cell.imageView.image;
    [self.target performSelector:self.action withObject:temp];
    [self.navigationController popViewControllerAnimated:YES];
    [self.imageSearchResults removeAllObjects];
    self.searchBar.text=@"";
    [self.tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.imageSearchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    INETImageView *temp =[self.imageSearchResults objectAtIndex:indexPath.row];
    //UIImage *temp = [self.imageSearchResults objectAtIndex:indexPath.row];
    [[cell imageView] setImage:temp.image];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];

    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
 
 */

@end
