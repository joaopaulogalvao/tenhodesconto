//
//  HomeViewController.h
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 4/11/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>
#import <UIKit/UIKit.h>


@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

//@property (weak, nonatomic) IBOutlet UIView *mapFrame;
@property (weak, nonatomic) IBOutlet UIView *mapFrame;

//@property (weak, nonatomic) IBOutlet GMSMapView *map1;

//@property (weak, nonatomic) IBOutlet UIView *map1;
//@property (weak, nonatomic) IBOutlet MKMapView *mapa;

//@property (weak, nonatomic) IBOutlet GMSMapView *mapa;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segementedOfertas;

@property (weak, nonatomic) IBOutlet UITableView *ofertasProximas;

@property (nonatomic, strong) NSArray* ofertas;

@property (strong, nonatomic) PFUser *user;


@end
