//
//  ScrapbookViewController.m
//  ScrapBook
//
//  Created by Szeyin Lee on 9/28/13.
//  Copyright (c) 2013 Szeyin Lee. All rights reserved.
//

#import "ScrapbookViewController.h"
#import "Database.h"

@interface ScrapbookViewController ()

@end

@implementation ScrapbookViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
        self.photolist = [[NSMutableArray alloc] initWithCapacity:0];
        self.photolist = [Database fetchAllScrapbookItem];
    
        // start with some scrapbook items
        
        NSMutableDictionary *scr = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Scripps", @"Logo of Scripps", [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.scrippscollege.edu/about/images/scripps-traditions/la-semeuse.gif"]], nil] forKeys:[NSArray arrayWithObjects:@"title", @"caption", @"photo", nil]];
        
        NSMutableDictionary *pomona = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Pomona", @"Logo of Pomona", [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.claremontportside.com/wp-content/uploads/2012/11/pclogo-4c-noborder-pv.jpg"]], nil] forKeys:[NSArray arrayWithObjects:@"title", @"caption", @"photo", nil]];
        
        NSMutableDictionary *mudd = [NSMutableDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Mudd", @"Logo of Mudd", [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://static.squarespace.com/static/5056c03584aedaeee9199a39/513ddf64e4b0b4b41fd6831e/5187fdd0e4b07f4d551f7613/1367866832651/Harvey%20Mudd.jpg"]], nil] forKeys:[NSArray arrayWithObjects:@"title", @"caption", @"photo", nil]];
        if ([self.photolist count] < 3)
        {
            [self addPhoto:scr];
            [self addPhoto:pomona];
            [self addPhoto:mudd];
            
        }

        // register the type of view to create for a table cell
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
        
        // initialize the contact creation view controller
        self.addPhotoViewController = [[AddPhotoViewController alloc] initWithNibName:@"AddPhotoViewController" bundle:nil];
        self.addPhotoViewController.target = self;
        self.addPhotoViewController.action = @selector(addPhoto:);
        
        // initialize the contact detail view controller
        self.photoDetailViewController = [[PhotoDetailViewController alloc] initWithNibName:@"PhotoDetailViewController" bundle:nil];
    }
    return self;
}

- (void)addPhoto:(NSMutableDictionary *)photoInfo
{
    // we have to tell the tableView to reload itself after we modify the data array

    [Database saveScrapbookItemWithTitle:[photoInfo objectForKey:@"title"] andCaption:[photoInfo objectForKey:@"caption"] andPhoto:[photoInfo objectForKey:@"photo"]];
    self.photolist = [Database fetchAllScrapbookItem];
    [self.tableView reloadData];
}

- (void)addButtonPressed
{
    [self.navigationController pushViewController:self.addPhotoViewController animated:YES];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.photolist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    ScrapbookItem *temp = [self.photolist objectAtIndex:indexPath.row];
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@", temp.title]];
    [[cell imageView] setImage:temp.photo];
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 5.0;
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


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [Database deleteScrapbookItem:[[self.photolist objectAtIndex:indexPath.row] rowid]] ;
        self.photolist = [Database fetchAllScrapbookItem];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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


#pragma mark - Navigation

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScrapbookItem *temp = [self.photolist objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:self.photoDetailViewController animated:YES];
    [self.photoDetailViewController setFieldsWithPhoto:temp.photo andTitle:temp.title andCap:temp.caption];
}
/*
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
 

@end
