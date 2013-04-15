//
//  LeftViewController.m
//  JokeEveryDay
//
//  Created by shaxquan  on 3/6/13.
//  Copyright (c) 2013 shaxquan . All rights reserved.
//

#import "LeftViewController.h"
#import "IIViewDeckController.h"
#import "JokeListViewController.h"
#import "AppDelegate.h"

#define KEY_TITLE @"title"
#define KEY_IMAGE_NAME @"image_name"
#define KEY_IMAGE @"image"
#define KEY_Url @"titleUrl"

@interface LeftViewController ()

@end

@implementation LeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UINavigationController *navigationController = (UINavigationController *)[AppDelegate sharedAppDelegate].centerController;
        JokeListViewController *jokeListViewController = (JokeListViewController *)navigationController.visibleViewController;
        jokeListViewController.navigationItem.title = @"夫妻";
        [jokeListViewController reloadDataWithURLStr:@"http://xiaohua.zol.com.cn/list_2_1.html"];
    }
    return self;
}

- (void)dealloc {

    [_settingButton release];
    [_tableView release];
    [super dealloc];
    [mDataSource release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    mDataSource = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"]];

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
    return [mDataSource count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 69.0;
//}

- (IBAction)openSetting:(id)sender {
    [self presentModalViewController:[AppDelegate sharedAppDelegate].settingController animated:YES];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary *info = [mDataSource objectAtIndex:[indexPath row]];
    //    cell.imageView.image = [UIImage imageNamed:[info objectForKey:KEY_IMAGE]];
    cell.textLabel.text = [info objectForKey:KEY_TITLE];

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
    }   `
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
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.viewDeckController closeLeftViewAnimated:YES completion:^(IIViewDeckController *controller, BOOL success) {
        self.viewDeckController.centerController = [AppDelegate sharedAppDelegate].centerController;
        UINavigationController *navigationController = (UINavigationController *)self.viewDeckController.centerController;
        JokeListViewController *jokeListViewController;
        if ([navigationController.visibleViewController isKindOfClass:[JokeListViewController class]]) {
            
        }
        else {
            [navigationController popToRootViewControllerAnimated:NO];
        }
        jokeListViewController = (JokeListViewController *)navigationController.visibleViewController;
        NSDictionary *info = [mDataSource objectAtIndex:[indexPath row]];
        jokeListViewController.navigationItem.title = [info objectForKey:KEY_TITLE];
        [jokeListViewController reloadDataWithURLStr:[info objectForKey:KEY_Url]];
    }];
}

- (void)viewDidUnload {

    [self setSettingButton:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
