//
//  SearchViewController.m
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 11/23/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property(strong, nonatomic)IBOutlet UISearchBar *search;
@property(nonatomic, strong)NSMutableArray *searchResults;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    
//    if ([self.search isFirstResponder]) {
//        [self performSelector:@selector(searchBarSearchButtonClicked:)];
//    }
    
    self.search.delegate = self;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - SearchBar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self loadObjects];
    
}



-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    
    [self.search resignFirstResponder];
    [self clear];

}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    
    
    
    
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [self clear];
    
}



-(void)viewWillAppear:(BOOL)animated{
    
//    [self.searchResults removeAllObjects];
    [self becomeFirstResponder];
  
    
    
}


#pragma mark - PFQueryTableViewController

-(PFQuery*)queryForTable{
    
    
    if(![self.search.text isEqualToString:@""]){
        
        
        NSString *regexString = [NSString stringWithFormat:@"%@",self.search.text];
        
        PFQuery *categoryQuery = [[PFQuery alloc] initWithClassName:@"Offers"];
        [categoryQuery whereKey:@"categories" matchesRegex:regexString modifiers:@"i"];
        
        
        PFQuery *nameQuery = [[PFQuery alloc] initWithClassName:@"Offers"];
        [nameQuery whereKey:@"companyName" matchesRegex:regexString modifiers:@"i"];
        
        
        PFQuery *addressQuery = [[PFQuery alloc] initWithClassName:@"Offers"];
        [addressQuery whereKey:@"adress" matchesRegex:regexString modifiers:@"i"];
        
        PFQuery *companyCityQuery = [[PFQuery alloc] initWithClassName:@"Offers"];
        [companyCityQuery whereKey:@"companyCity" matchesRegex:regexString modifiers:@"i"];

        
        PFQuery *companyAreaQuery = [[PFQuery alloc] initWithClassName:@"Offers"];
        [companyAreaQuery whereKey:@"companyArea" matchesRegex:regexString modifiers:@"i"];
        
        PFQuery *benefitCardQuery = [[PFQuery alloc] initWithClassName:@"Offers"];
        [benefitCardQuery whereKey:@"benefitCard" matchesRegex:regexString modifiers:@"i"];

        
        PFQuery *companyStateQuery = [[PFQuery alloc] initWithClassName:@"Offers"];
        [companyStateQuery whereKey:@"companyState" matchesRegex:regexString modifiers:@"i"];

        
        PFQuery *descriptionQuery = [[PFQuery alloc] initWithClassName:@"Offers"];
        [descriptionQuery whereKey:@"description" matchesRegex:regexString modifiers:@"i"];
        
        
        NSLog(@"%@", self.search.text);
    
    
    PFQuery *searchQuery = [PFQuery orQueryWithSubqueries:@[categoryQuery,nameQuery, addressQuery,companyCityQuery,companyAreaQuery,benefitCardQuery,companyStateQuery, descriptionQuery]];
       
        return  searchQuery;
    }
    
    
    return [[PFQuery alloc] initWithClassName:@"Offers"];
}

-(PFTableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    static NSString *simpleTableIdentifier = @"SearchCell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //PFObject *categoriesObject = [PFObject objectWithClassName:@"Categories"];
    
    cell.textLabel.text = [object objectForKey:@"companyName"];
    
    return cell;
    
    
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












