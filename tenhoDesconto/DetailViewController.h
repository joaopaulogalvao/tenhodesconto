//
//  DetailViewController.h
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 11/22/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import <Parse/Parse.h>

@interface DetailViewController : PFQueryTableViewController

@property(nonatomic, strong) PFObject *clickedDealDetail;

@end
