//
//  HomeViewController.m
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 4/11/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import "HomeViewController.h"
//#import "AppDelegate.h"
//#import <GoogleMaps/GoogleMaps.h>
#import <Parse/Parse.h>

@interface HomeViewController ()
//{
    
    //GMSMapView *mapView_;
//}


@end

@implementation HomeViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
       
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.ofertasProximas.delegate = self;
    self.ofertasProximas.dataSource = self;
    self.navigationController.navigationBarHidden = NO;
    
   //    CLLocationCoordinate2D position;
    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
//                                                            longitude:151.20
//                                                                 zoom:6];
//    
//    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 108, 320, 208) camera:camera];
//    
//    mapView_.myLocationEnabled = YES;
//    self.view = mapView_;
//    
////    [self.view addSubview:self.mapFrame];
////    
//    // Creates a marker in the center of the map.
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
//    marker.title = @"Sydney";
//    marker.snippet = @"Australia";
//    marker.map = mapView_;

    
    

//
//    GMSCameraUpdate *camera = [GMSCameraUpdate setTarget:position];
//
//    
//    // Create a GMSCameraPosition that tells the map to display the
    

    
    
   
    

////    
//    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
//        NSLog(@"User is currently at %f, %f", geoPoint.latitude, geoPoint.longitude);
//        
//        [self.user setObject:geoPoint forKey:@"currentLocation"];
//        [self.user saveInBackground];
//        [self.map1 setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude),MKCoordinateSpanMake(0.01, 0.01))];
//
//        [self refreshMap:nil];
//    }];

    
    
    
    
}

//-(void)loadView{
    
    //CGRectMake(0, 108, 320, 208)
   

    
    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
//                                                            longitude:151.20
//                                                                 zoom:6];
    
//    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 108, 320, 208) camera:camera];
    
//    mapView_.myLocationEnabled = YES;
//    self.map1 = mapView_;
    
//    [self.view addSubview:self.map1];
    
    // Creates a marker in the center of the map.
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
//    marker.title = @"Sydney";
//    marker.snippet = @"Australia";
//    marker.map = mapView_;

    
        
    
    
    
    
//}



-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self loadOfertas];
    
    
    

    
}

- (void)loadOfertas
{
    PFQuery *query = [PFQuery queryWithClassName:@"Oferta"];
    [query orderByDescending:@"createdAt"];
    
    __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray* results, NSError* error) {
        weakSelf.self.ofertas = results;
        [weakSelf.ofertasProximas reloadData];
    }];
}



#pragma mark - Map Actions

// Localização atual do usuário



- (IBAction)refreshMap:(id)sender {
//    
//    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:self.mapa.centerCoordinate.latitude longitude:self.mapa.centerCoordinate.longitude];
//    PFQuery *query = [PFUser query];
//    
//    //query parse database for user
//    [query whereKey:@"currentLocation" nearGeoPoint:geoPoint withinMiles:10.0f];
//    
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
//     {
//         if(error)
//         {
//             NSLog(@"%@",error);
//         }
//         for (id object in objects)
//         {
//             
//             MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//             annotation.title = [object objectForKey:@"userFullName"];
//             PFGeoPoint *geoPoint= [object objectForKey:@"currentLocation"];
//             annotation.coordinate = CLLocationCoordinate2DMake(geoPoint.latitude,geoPoint.longitude);
//             
//             [self.mapa addAnnotation:annotation];
//             
//         }
//         
//         
//         
//     }];
    
    
}



#pragma mark - PFQueryTableView Data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    return 1;
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.ofertas count];

    
}




#pragma mark - PFQueryTableView Delegate


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Create the Object
    PFObject* oferta = [self.ofertas objectAtIndex:indexPath.row];
    
    
    // Configure the Cell
    static NSString *simpleTableIdentifier = @"homeCells";
    
    PFTableViewCell *cell = [self.ofertasProximas dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    // Offer Name
    UILabel* title = (UILabel*)[cell viewWithTag:101];
    title.text = [oferta objectForKey:@"nomeEmpresa"];
    
    // Offer Description
    UILabel* offerDs = (UILabel*)[cell viewWithTag:102];
    offerDs.text = [oferta objectForKey:@"dsOferta"];
    cell.textLabel.textAlignment = NSTextAlignmentRight;
    
    
    // Offer Photo
    PFFile *thumbnail = [oferta objectForKey:@"fotoOferta"];
    PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
    thumbnailImageView.image = [UIImage imageNamed:@"promotion_logo_placeholder.png"];
    thumbnailImageView.file = thumbnail;
    [thumbnailImageView loadInBackground];
    
   	
    
    
    return cell;
}










@end









































