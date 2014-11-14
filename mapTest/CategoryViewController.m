//
//  CategoryViewController.m
//  mapTest
//
//  Created by Joao Alves on 11/12/14.
//  Copyright (c) 2014 joaopaulo. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    
    UIBarButtonItem *btn =
    [[UIBarButtonItem alloc] initWithTitle:@"Voltar"
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:btn];
}


-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        // The className to query on
        self.parseClassName = @"Categories";
        
        // The key of the PFObject to display in the label of the default cell style
        //self.textKey = @"name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
    }
    return self;
}

#pragma mark - PFQueryTableViewController delegates

- (PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    
    return query;
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    static NSString *simpleTableIdentifier = @"CategoriesCell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //PFObject *categoriesObject = [PFObject objectWithClassName:@"Categories"];
    
    cell.textLabel.text = [object objectForKey:@"Categories"];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Recognizes touched cell
    self.touchedCell = [self.objects objectAtIndex:indexPath.row];
    
    // Sets de ID for the touched cell to the catRelation key(Which will acces the desired class)
    [self.touchedCell setObject:self.touchedCell forKey:@"catRelation"];
    
    // Adds touched cell with the previously clicked ID to the Key that will be related
    self.relation = [self.touchedCell relationForKey:@"Name"];
    [self.relation addObject:self.touchedCell];
    
    // Returns Touched Cell and its Relation
    NSLog(@"%@",self.touchedCell);
    NSLog(@"%@",self.relation);
    
    

//    self.touchedCell = [PFObject objectWithClassName:@"Places"];
//    
//    PFQuery *queryForSelectedCat = [PFQuery queryWithClassName:@"Places"];
//    
//    [queryForSelectedCat whereKey:@"Categories" equalTo:self.touchedCell];
//    
//     NSLog(@"%@",queryForSelectedCat);
//    
//
    // generate a query based on that relation
//    PFQuery *query = [self.relation query];
////    
//    [query whereKey:@"Categories" equalTo:@"Categories"];
    
//    NSArray *offersArray = [queryForSelectedCat findObjects];
    
    
    
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
