//
//  CartoesTableViewController.h
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 4/8/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartoesTableViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)NSArray* tableData;
@property(nonatomic, strong)NSArray* thumbnails;

@end
