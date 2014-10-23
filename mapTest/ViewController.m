//
//  ViewController.m
//  mapTest
//
//  Created by Joao Alves on 9/25/14.
//  Copyright (c) 2014 joaopaulo. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    PFUser *user = [PFUser user];
    user.username = @"joao";
    user.password = @"12345";
    user.email = @"jalves59@ford.com";
    
    if (nil == self.locationManager){
        self.locationManager = [[CLLocationManager alloc] init];
    
        self.locationManager.delegate = self;
    //Configure Accuracy depending on your needs, default is kCLLocationAccuracyBest
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
        // Set a movement threshold for new events.
        self.locationManager.distanceFilter = 500; // meters
    
        [self.locationManager startUpdatingLocation];
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    
    
    CLLocation *location = [self.locationManager location];
    CLLocationCoordinate2D coordinateActual = [location coordinate];
//    NSLog(@"%@",coordinate);
    
    
//    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
//        //        NSLog(@"%@",geoPoint);
//        
//        NSLog(@"%@",geoPoint);
//        
//    }];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coordinateActual.latitude
                                                            longitude:coordinateActual.longitude
                                                                 zoom:15];
    
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.view = self.mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(coordinateActual.latitude, coordinateActual.longitude);
    marker.title = @"Estou";
    marker.snippet = @"Aqui";
    marker.map = self.mapView;
    
    
}

#pragma mark - Location Manager Callbacks

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    

    
//    PFGeoPoint *point = [PFGeoPoint geoPointWithLocation:[self.locationManager location]];
//    PFGeoPoint *point = currentLocation[@"lat_long"];
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        if (!error) {
            
            
            // Check current Location
             NSLog(@"%@", [locations lastObject]);
            
            
//            // Save Current Location
//            PFObject *currentLocation = [PFObject objectWithClassName:@"Local"];
//            PFGeoPoint *point = [PFGeoPoint geoPointWithLocation:[locations lastObject]];
//            
//            // Relate a location for a current user?
////            [currentLocation setObject:[PFUser currentUser] forKey:@"lat_long"];
//            
//            currentLocation[@"lat_long"] = point;
//            
//            [currentLocation saveInBackground];
            
            
            // Define Offer's objects and its points
            PFObject *offersLocation = [PFObject objectWithClassName:@"Places"];
            PFGeoPoint *offersPoint = offersLocation[@"places_coordinate"];
            
            // Create a query for Places of interest near current location
            PFQuery *query = [PFQuery queryWithClassName:@"Places"];
        
            [query whereKey:@"places_coordinate" nearGeoPoint:geoPoint];
            
            
            // Limit the query
            query.limit = 10;
            
            // Store query in an Array
            NSArray *offersList = [offersLocation objectForKey:@"places_coordinate"];
            
            
            // Find objects from the Array
            offersList = [query findObjects];
            
            NSLog(@"Oferta: %@",offersList);
            
            // Create a GeoPoint for markers
            offersPoint = offersLocation[@"places_coordinate"];
            
            NSLog(@"Marker: %@",offersPoint);
       
            // Place a marker on every Point of interest
            GMSMarker *markerPlaces = [[GMSMarker alloc] init];
            markerPlaces.position = CLLocationCoordinate2DMake(offersPoint.latitude, offersPoint.longitude);
            markerPlaces.title = @"Estou";
            markerPlaces.snippet = @"Aqui";
            markerPlaces.map = self.mapView;
            
            //Changing pin pictures for creating a conflict to creating
                
//                [self.locationManager startUpdatingLocation];
//                [self.locationManager requestWhenInUseAuthorization];
//                [self.locationManager requestAlwaysAuthorization];

//            [self.locationManager startUpdatingLocation];

//                 NSLog(@"Coordinates %@",query);

            //Test for stashing

//                 NSLog(@"Coordinates %@",query);

            
        }
    }];
    
    
    

//"Change Pin icon method"
//Test for resolving merge conflicts
//Another test merge conflicts

    
    
}

@end





























