//
//  DetailViewController.m
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 11/22/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        // The className to query on
        self.parseClassName = @"Deals_Details";
        
        // The key of the PFObject to display in the label of the default cell style
        //self.textKey = @"Name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
    }
    return self;
}

#pragma mark - PFQueryTableViewController delegates

-(PFQuery *)queryForTable{
    
    //Creates a relation based on a clicked cell at CategoryViewController and what the Relation is pointing at on Parse
    PFRelation *detailsRelation = [self.clickedDealDetail relationForKey:@"detailRelation"];
    
    
    return [detailsRelation query];
    
    
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    static NSString *simpleTableIdentifier = @"DetailCell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //Offer Title
    UILabel* title = (UILabel*)[cell viewWithTag:103];
    title.text = [object objectForKey:@"companyName"];
    //cell.textLabel.text = [object objectForKey:@"companyName"];
    
    //Offer Address
    UILabel* address = (UILabel*)[cell viewWithTag:104];
    address.text = [object objectForKey:@"address"];
    
    //Offer Area
    UILabel* companyArea = (UILabel*)[cell viewWithTag:105];
    companyArea.text = [object objectForKey:@"companyArea"];
    
    //Offer City
    UILabel* companyCity = (UILabel*)[cell viewWithTag:106];
    companyCity.text = [object objectForKey:@"companyCity"];
    
    //Offer State
    UILabel* companyState = (UILabel*)[cell viewWithTag:107];
    companyState.text = [object objectForKey:@"companyState"];
    
    //Offer Telephone
    UILabel* companyTelephone = (UILabel*)[cell viewWithTag:108];
    companyTelephone.text = [object objectForKey:@"companyTelephone"];
    
    //Offer Opening Time
    UILabel* companyOpening = (UILabel*)[cell viewWithTag:109];
    companyOpening.text = [object objectForKey:@"companyOpening"];

    
    
//    cell.textLabel.text = [object objectForKey:@"deal_description"];
    
    
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
























