//
//  CandySearchViewController.h
//  CandySearch
//
//  Created by Jonathan Carnie on 22/08/12.
//  Copyright (c) 2012 Jonathan Carnie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CandySearchViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSArray *candyArray;
@property (strong, nonatomic) NSMutableArray *filteredCandyArray;
@property IBOutlet UISearchBar *candySearchBar;


@end
