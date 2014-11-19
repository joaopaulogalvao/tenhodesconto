//
//  DetailViewController.h
//  mapTest
//
//  Created by Joao Alves on 11/19/14.
//  Copyright (c) 2014 joaopaulo. All rights reserved.
//

#import <Parse/Parse.h>

@interface DetailViewController : PFQueryTableViewController

@property(nonatomic, strong) PFObject *clickedDealDetail;

@end
