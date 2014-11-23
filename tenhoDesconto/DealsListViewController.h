//
//  DealsListViewController.h
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 11/20/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import <Parse/Parse.h>

@interface DealsListViewController : PFQueryTableViewController

@property(nonatomic, strong) PFObject *clickedCell;
@property(nonatomic, strong) PFObject *clickedDeal;
@property (weak, nonatomic) IBOutlet PFImageView *paidOfferImageView;
@property (weak, nonatomic) IBOutlet UIView *paidOfferView;

@end
