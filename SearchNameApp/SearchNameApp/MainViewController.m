//
//  MainViewController.m
//  SearchNameApp
//
//  Created by Szeyin Lee on 1/3/14.
//  Copyright (c) 2014 Szeyin Lee. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.names = [MainViewController getNames];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.searchbar=[[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 32)];
    self.searchbar.delegate = self;


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


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.searchbar;
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    self.searchresults=nil;
    [self.tableView reloadData];

}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchbar
{
    
    if (self.searchbar.isFirstResponder) {
        [self.searchbar resignFirstResponder];
    }
    NSString *name = searchbar.text;
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    name];
    
    self.searchresults = [self.names filteredArrayUsingPredicate:resultPredicate];
    /*
    for (NSString *a in self.searchresults){
        NSLog(@"%@", a);}
    */
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    if (self.searchresults.count!=0) {
        return self.searchresults.count;
    } else {
        return self.names.count;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    
    

    /*
    if (cell == nil)
    {cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];}
    */
    if (self.searchresults.count!=0) {
        cell.textLabel.text = [self.searchresults objectAtIndex:indexPath.row];
    } else {
        cell.textLabel.text = [self.names objectAtIndex:indexPath.row];
    }
    
    
    return cell;
}


+ (NSArray *)getNames {
    NSMutableArray *a = [[NSMutableArray alloc] init];
    
    [a addObject:@"George Washington"];
    [a addObject:@"John Adams"];
    [a addObject:@"Thomas Jefferson"];
    [a addObject:@"James Madison"];
    [a addObject:@"James Monroe"];
    [a addObject:@"John Quincy Adams"];
    [a addObject:@"Andrew Jackson"];
    [a addObject:@"Martin Van Buren"];
    [a addObject:@"William Henry Harrison"];
    [a addObject:@"John Tyler"];
    [a addObject:@"James K. Polk"];
    [a addObject:@"Zachary Taylor"];
    [a addObject:@"Millard Fillmore"];
    [a addObject:@"Franklin Pierce"];
    [a addObject:@"James Buchanan"];
    [a addObject:@"Abraham Lincoln"];
    [a addObject:@"Andrew Johnson"];
    [a addObject:@"Ulysses S. Grant"];
    [a addObject:@"Rutherford B. Hayes"];
    [a addObject:@"James Garfield"];
    [a addObject:@"Chester Arthur"];
    [a addObject:@"Grover Cleveland"];
    [a addObject:@"Benjamin Harrison"];
    [a addObject:@"Grover Cleveland"];
    [a addObject:@"William McKinley"];
    [a addObject:@"Theodore Roosevelt"];
    [a addObject:@"William Howard Taft"];
    [a addObject:@"Woodrow Wilson"];
    [a addObject:@"Warren Harding"];
    [a addObject:@"Calvin Coolidge"];
    [a addObject:@"Herbert Hoover"];
    [a addObject:@"Franklin Roosevelt"];
    [a addObject:@"Harry S. Truman"];
    [a addObject:@"Dwight Eisenhower"];
    [a addObject:@"John F. Kennedy"];
    [a addObject:@"Lyndon B. Johnson"];
    [a addObject:@"Richard Nixon"];
    [a addObject:@"Gerald Ford"];
    [a addObject:@"James Carter"];
    [a addObject:@"Ronald Reagan"];
    [a addObject:@"George H. W. Bush"];
    [a addObject:@"Bill Clinton"];
    [a addObject:@"George W. Bush"];
    [a addObject:@"Barack Obama"];
    
    [a sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSString * string1 = obj1;
        NSString * string2 = obj2;
        return [string1 compare:string2];
    }];
    
    return [NSArray arrayWithArray:a];
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
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
