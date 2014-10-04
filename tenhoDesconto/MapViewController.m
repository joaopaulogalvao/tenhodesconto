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



@interface MapViewController (){
    
    GMSMapView *mapView_;
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
    
    
    // Do any additional setup after loading the view.
    
    if (nil == self.locationManager){
        self.locationManager = [[CLLocationManager alloc] init];
        
        self.locationManager.delegate = self;
        
        self.locationManager.distanceFilter = 500;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        
        
        [self.locationManager startUpdatingLocation];
    }
    
//    mapView_.delegate = self;
    
    
    CLLocation *location = [self.locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    
//    CLLocation *newLocation = mapView_.myLocation;
//    CLLocationCoordinate2D target =
//    CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    mapView_.camera = [GMSCameraPosition cameraWithTarget:coordinate zoom:15];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:coordinate.latitude
                                                            longitude:coordinate.longitude
                                                                 zoom:15];
    
    
    
    
    mapView_ = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    
    [self.view addSubview:mapView_];
    
    mapView_.mapType = kGMSTypeNormal;
    mapView_.settings.myLocationButton = YES;
    mapView_.indoorEnabled = YES;
    
    mapView_.myLocationEnabled = YES;
    
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        if (!error) {
            NSLog(@"GeoPoint é %@",geoPoint);
        }
    }];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Oferta"];
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        [query whereKey:@"coordenadas" nearGeoPoint:self.detailItem[@"coordenadas"] withinKilometers:5.0];
        
        
    }];

    
    
    
//   MKCoordinateRegion region;
//   region.center = target;
//   [mapView_ setCamera:camera];
    
//   Creates a marker in the center of the map.
//   GMSMarker *marker = [[GMSMarker alloc] init];
//   marker.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
//   marker.title = @"Current";
//   marker.snippet = @"Location";
//   marker.map = mapView_;
    

}

//-(PFQuery*)queryOffers{
//    
//    return query;
//}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    if (self.detailItem) {
        // obtain the geopoint
        PFGeoPoint *geoPoint = self.detailItem[@"coordenadas"];
        
        // center our map view around this geopoint
        GMSMarker *marker = [[GMSMarker alloc]init];
        marker.position = CLLocationCoordinate2DMake(geoPoint.longitude, geoPoint.longitude);
       
        
        // add the annotation
        marker.title = self.detailItem[@"nomeEmpresa"];
        marker.snippet = self.detailItem[@"cartaoOferta"];
        marker.map = mapView_;
    }

    
    
    

}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
    
    mapView_.padding = UIEdgeInsetsMake(self.topLayoutGuide.length + 5, 0, self.bottomLayoutGuide.length + 5, 0);
}



#pragma mark - PFQuery




























@end
