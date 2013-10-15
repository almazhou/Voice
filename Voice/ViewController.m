//
//  ViewController.m
//  Voice
//
//  Created by xzhou on 10/8/13.
//  Copyright (c) 2013 xzhou. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "ViewController.h"
#import "AppDelegate.h"
#import "RateViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.imageView.image = [UIImage imageNamed:@"flower.png"];
    if(indexPath.section ==0){
    cell.textLabel.text = @"常用语句";
    }else if(indexPath.section ==1){
    cell.textLabel.text = @"聊天";
    } else if(indexPath.section ==2){
    cell.textLabel.text = @"评定";
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
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section==0) {
        [self performSegueWithIdentifier:@"sentenceViewControllerSegue" sender:self];
    }else if(indexPath.section == 1){
        [self performSegueWithIdentifier:@"detailViewControllerSegue" sender:self];
    }else if(indexPath.section == 2){
        [self performSegueWithIdentifier:@"rateViewControllerSegue" sender:self];
    }
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"detailViewControllerSegue"]){
        DetailViewController *dest0 = [segue destinationViewController];
    } else if([[segue identifier] isEqualToString:@"sentenceViewControllerSegue"]){
        SentenceViewController *dest1 = [segue destinationViewController];

        AppDelegate *appDelegate =[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context =[appDelegate managedObjectContext];
        NSEntityDescription *entityDesc =[NSEntityDescription entityForName:@"Sentences" inManagedObjectContext:context];
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:entityDesc];

        NSError *error1 = nil;
        NSMutableArray *muArray;
        NSArray *totalObjects = [context executeFetchRequest:request error:&error1];
        if (totalObjects == nil) {
            NSLog(@"Sorry,no objects found");
        }
        else {
            int length = [totalObjects count];
            muArray = [NSMutableArray arrayWithCapacity:length];
            for(int i =0;i<[totalObjects count];i++) {
                [muArray addObject:[[totalObjects objectAtIndex:i] valueForKey:@"name"]];
            }
        }

        dest1._items =muArray;
    }else if([[segue identifier] isEqualToString:@"rateViewControllerSegue"]){
        RateViewController *rateViewController = [segue destinationViewController];

    }
}

@end
