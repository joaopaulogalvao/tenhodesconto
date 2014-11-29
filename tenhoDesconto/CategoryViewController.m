//
//  CategoryViewController.m
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 11/13/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import "CategoryViewController.h"
#import "DealsListViewController.h"

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
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    
//    UIBarButtonItem *btn =
//    [[UIBarButtonItem alloc] initWithTitle:@"Voltar"
//                                     style:UIBarButtonItemStylePlain
//                                    target:nil
//                                    action:nil];
//    [[self navigationItem] setBackBarButtonItem:btn];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self loadOfertas];
    
    
    
    
    
}

- (void)loadOfertas
{
    PFQuery *query = [PFQuery queryWithClassName:@"Categories"];
    [query orderByAscending:@"categories"];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray* results, NSError* error) {
         self.categories = results;
        [self loadObjects];
    }];
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
    [query orderByAscending:@"categories"];
    
    
    return query;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.categories count];
    
    
}



-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    // Create the Object
    PFObject* categoriesObject = [self.categories objectAtIndex:indexPath.row];
    
     //PFObject *categoriesObject = [PFObject objectWithClassName:@"Categories"];
    
    //Configure the cell
    static NSString *simpleTableIdentifier = @"categoryCells";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    //Offer Name
    //cell.textLabel.text = [object objectForKey:@"categories"];
    UILabel* title = (UILabel*)[cell viewWithTag:98];
    title.text = [categoriesObject objectForKey:@"categories"];
    
    
    
    //Offer Photo
    PFFile *thumbnail = [categoriesObject objectForKey:@"categoryPhoto"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:99];
    thumbnailImageView.image = [UIImage imageNamed:@"promotion_logo_placeholder.png"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Recognizes touched cell
    self.touchedCell = [self objectAtIndexPath:indexPath];
    
    // Returns Touched Cell and its Relation
    NSLog(@"%@",self.touchedCell);
   
    
    [self performSegueWithIdentifier:@"deals" sender:self];
    
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"deals"]) {
        DealsListViewController *destinationDeals = segue.destinationViewController;
        destinationDeals.clickedCell = self.touchedCell;

    }

    
    
}


@end




























