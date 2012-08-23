//
//  CandySearchViewController.m
//  CandySearch
//
//  Created by Jonathan Carnie on 22/08/12.
//  Copyright (c) 2012 Jonathan Carnie. All rights reserved.
//

#import "CandySearchViewController.h"
#import "Candy.h"

@interface CandySearchViewController ()


@end

@implementation CandySearchViewController

@synthesize candyArray;
@synthesize candySearchBar;
@synthesize filteredCandyArray;

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
    //sample data for candy array
    
    candyArray = [NSArray arrayWithObjects:
                  [Candy candyOfCategory:@"Chocolate" name:@"chocolate bar"],
                  [Candy candyOfCategory:@"Chocolate" name:@"chocolate chip"],
                  [Candy candyOfCategory:@"Chocolate" name:@"dark chocolate"],
                  [Candy candyOfCategory:@"Hard" name:@"lollipop"],
                  [Candy candyOfCategory:@"Hard" name:@"candy cane"],
                  [Candy candyOfCategory:@"Hard" name:@"jaw breaker"],
                  [Candy candyOfCategory:@"Other" name:@"caramel"],
                  [Candy candyOfCategory:@"Other" name:@"sour chew"],
                  [Candy candyOfCategory:@"Other" name:@"Peanut butter cup"],
                  [Candy candyOfCategory:@"Other" name:@"Gummi bear"], nil];
    // reload table
    
    self.filteredCandyArray = [NSMutableArray arrayWithCapacity:[candyArray count]];
    
    [self.tableView reloadData];
    
    
                  
                  
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredCandyArray count];
    } else {
        return [candyArray count];
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //create a new candy object
    Candy *candy = nil;
 //  candy = [candyArray objectAtIndex:indexPath.row];
    // Check to see whether the normal table or search results table is being displayed and set the Candy object from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        candy = [filteredCandyArray objectAtIndex:indexPath.row];
    } else {
        candy = [candyArray objectAtIndex:indexPath.row];
    }
    
    
    // Configure the cell...
    cell.textLabel.text = candy.name;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected something at row ");
    [self performSegueWithIdentifier:@"candyDetail" sender:tableView];
    // Navigation logic may go here. Create and push another view controller.
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"candyDetail"]) {
                
        UIViewController *candyDetailViewController = [segue destinationViewController];
        
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            NSString *destinationTitle = [[filteredCandyArray objectAtIndex:[indexPath row]] name];
            [candyDetailViewController setTitle:destinationTitle];
        }else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NSString *destinationTitle = [[candyArray objectAtIndex:[indexPath row]] name];
            [candyDetailViewController setTitle:destinationTitle];
        }
    }
}


#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredCandyArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    filteredCandyArray = [NSMutableArray arrayWithArray:[candyArray filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption{
    // tells the table data source to reload when the scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles]objectAtIndex:searchOption]];
    return YES;
}



@end
