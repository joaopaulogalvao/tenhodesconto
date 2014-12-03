//
//  SearchViewController.m
//  mapTest
//
//  Created by Ryan Maciel on 11/20/14.
//  Copyright (c) 2014 joaopaulo. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property(strong, nonatomic)IBOutlet UISearchBar *search;
@end

@implementation SearchViewController

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self loadObjects];
}


-(PFQuery*)queryForTable{
    PFQuery *nameQuery = [[PFQuery alloc] initWithClassName:@"Places"];
    [nameQuery whereKey:@"Name" containsString:self.search.text];
    NSLog(@"%@", self.search.text);
    
    PFQuery *descriptionQuery = [[PFQuery alloc] initWithClassName:@"Places"];
    [descriptionQuery whereKey:@"deal_description" containsString:self.search.text];
    
    PFQuery *categoryQuery = [[PFQuery alloc] initWithClassName:@"Places"];
    [categoryQuery whereKey:@"Categories" containsString:self.search.text];
    
    PFQuery *addressQuery = [[PFQuery alloc] initWithClassName:@"Places"];
    [addressQuery whereKey:@"address" containsString:self.search.text];
    
    PFQuery *searchQuery = [PFQuery orQueryWithSubqueries:@[nameQuery, descriptionQuery, categoryQuery, addressQuery]];
    return  searchQuery;
}

-(PFTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{

    static NSString *simpleTableIdentifier = @"ResultCell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //PFObject *categoriesObject = [PFObject objectWithClassName:@"Categories"];
    
    cell.textLabel.text = [object objectForKey:@"Name"];
    
    return cell;

    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
