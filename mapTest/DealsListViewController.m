//
//  DealsListViewController.m
//  mapTest
//
//  Created by Joao Alves on 11/12/14.
//  Copyright (c) 2014 joaopaulo. All rights reserved.
//

#import "DealsListViewController.h"
#import "CategoryViewController.h"

@interface DealsListViewController ()

@end

@implementation DealsListViewController


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
        self.parseClassName = @"Places";
        
        // The key of the PFObject to display in the label of the default cell style
        //self.textKey = @"Name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
    }
    return self;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - PFQueryTableView

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    CategoryViewController *categorySelected = [[CategoryViewController alloc]init];
//    
//    [[categorySelected.relation query] findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        
//        if (error) {
//            //
//        } else {
            NSLog(@"%@",query);
//        }
//    }];
    
    return [categorySelected.relation query];
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    static NSString *simpleTableIdentifier = @"DealsCell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    CategoryViewController *categorySelected = [[CategoryViewController alloc]init];
    
    //PFObject *categoriesObject = [PFObject objectWithClassName:@"Categories"];
    
    //PFRelation *relationCatSelected = [[PFRelation alloc]init];
    
    //[relationCatSelected addObject:categorySelected.touchedCell];
    
    cell.textLabel.text = categorySelected.touchedCell[@"Name"];
    
    //cell.textLabel.text = [object objectForKey:@"Name"];
    
    return cell;
    
}


@end
