//
//  JokeListViewController.m
//  JokeEveryDay
//
//  Created by shaxquan  on 3/6/13.
//  Copyright (c) 2013 shaxquan . All rights reserved.
//

#import "JokeListViewController.h"
#import "IIViewDeckController.h"
#import "DataManager.h"
#import "JokeDetailViewController.h"

@interface JokeListViewController ()

@end

@implementation JokeListViewController
@synthesize tableView = tableView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
    [tableView_ release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *toggle_left_view_button = [UIImage imageNamed:@"reveal_menu_icon_portrait"];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithImage:toggle_left_view_button style:UIBarButtonItemStylePlain target:self.viewDeckController action:@selector(toggleLeftView)] autorelease];
    self.viewDeckController.leftSize = 60;
    
    tableView_ = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height-44-20-110) style:UITableViewStylePlain];
//    tableView_.backgroundColor = [UIColor redColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
     
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)reloadDataWithURLStr:(NSString *)urlStr {
    [[DataManager sharedDataManager] loadJokeListWithDelegate:self AndUrlStr:urlStr];
}

- (void)reloadListTable {
    [self.tableView reloadData];
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
    if ([DataManager sharedDataManager].list == nil || [[DataManager sharedDataManager].list count]==0) {
        return 0;
    }
    return [[DataManager sharedDataManager].list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if ([[DataManager sharedDataManager].list count]) {
        if (indexPath.row < 10 && indexPath.row >= 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"  00%d. %@",indexPath.row,[[[DataManager sharedDataManager].list objectAtIndex:indexPath.row] objectForKey:@"title"]];
            //   [cell setCellTitle:[NSString stringWithFormat:@"  00%d. %@",indexPath.row,[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]]];
        }
        if (indexPath.row < 100 && indexPath.row >= 10) {
            cell.textLabel.text = [NSString stringWithFormat:@"  0%d. %@",indexPath.row,[[[DataManager sharedDataManager].list objectAtIndex:indexPath.row] objectForKey:@"title"]];
            // [cell setCellTitle:[NSString stringWithFormat:@"  0%d. %@",indexPath.row,[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]]];
        }
        else {
            cell.textLabel.text = [NSString stringWithFormat:@"  %d. %@",indexPath.row,[[[DataManager sharedDataManager].list objectAtIndex:indexPath.row] objectForKey:@"title"]];
            // [cell setCellTitle:[NSString stringWithFormat:@"  %d. %@",indexPath.row,[[arryList objectAtIndex:indexPath.row] objectForKey:@"title"]]];
        }
    }

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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
    JokeDetailViewController *jokeDetailViewController = [[JokeDetailViewController alloc] initWithNibName:@"JokeDetailViewController" bundle:nil];
    [jokeDetailViewController reloadDataWithURLStr:[[[DataManager sharedDataManager].list objectAtIndex:indexPath.row] objectForKey:@"href"]];
    [self.navigationController pushViewController:jokeDetailViewController animated:YES];
    [jokeDetailViewController release];
}

@end
