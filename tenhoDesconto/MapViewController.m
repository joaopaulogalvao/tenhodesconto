//
//  MapViewController.m
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 4/22/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "CadastroViewController.h"
#import <MapKit/MapKit.h>



@interface MapViewController (){
    
//    GMSMapView *mapView_;
}


@end

@implementation MapViewController

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
            
            
            // Create Object
            PFObject *offersLocation = [PFObject objectWithClassName:@"Places"];
            
            //Create a point for markers
            PFGeoPoint *offersPoint = offersLocation[@"places_coordinate"];
            
            // Check current Location
            NSLog(@"%@", offersPoint);
            
            // Create a query for Places of interest near current location
            PFQuery *query = [PFQuery queryWithClassName:@"Places"];
            
            [query whereKey:@"places_coordinate" nearGeoPoint:geoPoint withinKilometers:5.0];
            
            NSLog(@"Query: %@",query);
            
            // Limit the query
            query.limit = 10;
            
            
            NSArray *offersArray = [query findObjects];
            
            
            NSLog(@"Array: %@",offersArray);
            
            
            
            
            if (!error) {
                for (query in offersArray) {
                    MKPointAnnotation *geoPointAnnotation = [[MKPointAnnotation alloc]
                                                             init];
                    [self.appleMap addAnnotation:geoPointAnnotation];
                    
                    NSLog(@"Annotation: %@",geoPointAnnotation);
                    
                }
            }
            
        }
    }];
    
}



#pragma mark - MKMapViewDelegate
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKPinAnnotationView *pinOffers = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    
    pinOffers.pinColor = MKPinAnnotationColorRed;
    
    pinOffers.canShowCallout = YES;
    
    pinOffers.animatesDrop = YES;
    
    return pinOffers;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
    
//    mapView_.padding = UIEdgeInsetsMake(self.topLayoutGuide.length + 5, 0, self.bottomLayoutGuide.length + 5, 0);
}






























@end
