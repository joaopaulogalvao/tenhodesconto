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
    
    self.appleMap.delegate = self;
    
    // Map will show current location
    self.appleMap.showsUserLocation = YES;
    
    // Maps' opening spot
    self.location = [self.locationManager location];
    CLLocationCoordinate2D coordinateActual = [self.location coordinate];
    
    // Map's zoom
    MKCoordinateSpan zoom = MKCoordinateSpanMake(0.010, 0.010);
    
    // Create a region
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinateActual, zoom);
    
    // Method which sets exibition method
    [self.appleMap setRegion:region animated:YES];
    
    //Map's type
    self.appleMap.mapType = MKMapTypeStandard;
    
    
}

#pragma mark - Location Manager Callbacks

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        if (!error) {
            
            // Check current Location
             NSLog(@"%@", [locations lastObject]);
            
            // Create a query for Places of interest near current location
            PFQuery *query = [PFQuery queryWithClassName:@"Places"];
        
            [query whereKey:@"coordenadas" nearGeoPoint:geoPoint];
            
            NSLog(@"Query: %@",query);
            
            // Limit the query
            query.limit = 10;
            
            
            NSMutableArray *offersArray = [NSMutableArray array];
            
            [offersArray addObject:query];
            
            
            
            NSLog(@"Array: %@",offersArray);
            
            
            
            
            if (!error) {
                for (query in offersArray) {
                    MKPointAnnotation *geoPointAnnotation = [[MKPointAnnotation alloc]
                                                             init];
                    [self.appleMap addAnnotation:geoPointAnnotation];
                    
                    NSLog(@"Annotation: %@",geoPointAnnotation);
                
                }
            }
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                
                // Create Object
                PFObject *offersLocation = [PFObject objectWithClassName:@"Oferta"];
                
                //Create a point for markers
                PFGeoPoint *offersPoint = [offersLocation objectForKey:@"coordenadas"];
                
                offersPoint = offersLocation[@"coordenadas"];
                
                NSLog(@"Marker: %@",offersPoint);
                
                NSMutableArray *offersArray = [NSMutableArray array];
                
                [offersArray addObject:geoPoint];
                
                NSLog(@"Oferta: %@",offersArray);
                
                if (!error) {
                    for (offersPoint in offersArray) {
                        MKPointAnnotation *geoPointAnnotation = [[MKPointAnnotation alloc]
                                                                 init];
                        [self.appleMap addAnnotation:geoPointAnnotation];
                    }
                }
                
            }];
            
        }
    }];
    
    
}

@end





























