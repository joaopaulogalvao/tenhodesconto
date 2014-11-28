//
//  CategoryViewController.h
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 11/13/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import <Parse/Parse.h>

@interface CategoryViewController : PFQueryTableViewController

@property(nonatomic, strong) PFObject *touchedCell;
@property(nonatomic, strong) PFRelation *relation;
@property(nonatomic, strong) NSArray *categories;

@end
