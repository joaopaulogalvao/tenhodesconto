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
#import "DetailViewController.h"



@interface MapViewController () <UISearchBarDelegate>{
    
//    GMSMapView *mapView_;
}

@property(strong, nonatomic)IBOutlet UISearchBar *searchBar;
-(IBAction)search;

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

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    
    
    //    mapView_.padding = UIEdgeInsetsMake(self.topLayoutGuide.length + 5, 0, self.bottomLayoutGuide.length + 5, 0);
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    
    //Hide search bar
    [self.view bringSubviewToFront:self.searchBar];
//    self.searchBar.delegate = self;
    self.searchBar.hidden = YES;
    
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
    MKCoordinateSpan zoom = MKCoordinateSpanMake(10.0, 10.0); //MKCoordinateSpan zoom = MKCoordinateSpanMake(0.010, 0.010);
    
    // Create a region
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinateActual, zoom);
    
    // Method which sets exibition method
    [self.appleMap setRegion:region animated:YES];
    
    self.appleMap.userTrackingMode = MKUserTrackingModeFollow;
    
    //Map's type
    self.appleMap.mapType = MKMapTypeStandard;
    

}


#pragma mark - Search Actions

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder geocodeAddressString:searchBar.text completionHandler:^(NSArray* placeMarks, NSError *error){
        if(error){
            //handle error
        }else if(placeMarks.count > 0){
            
            //Get the placemark
            CLPlacemark *addressPlacemark = placeMarks[0];
            
            //Zoom the map in appropriately.
            float zoom = 70.0;
            
            if (addressPlacemark.country) {
                zoom-=25.0; //45
                NSLog(@"Country: %@",addressPlacemark.country);
            }
            if (addressPlacemark.administrativeArea){
                zoom -= 39.0; //6
                NSLog(@"State: %@",addressPlacemark.administrativeArea);
            }
            if (addressPlacemark.locality) {
                zoom -= 5.8; //0.2
                NSLog(@"City: %@",addressPlacemark.locality);
            }
            if (addressPlacemark.subLocality) {
                zoom += 5.0 - 5.15; //0.05
                NSLog(@"Area: %@",addressPlacemark.subLocality);
            }
            if (addressPlacemark.thoroughfare){
                zoom -= 0.04;
                NSLog(@"Street: %@",addressPlacemark.thoroughfare);
            }
            
            // //Zoom the map in appropriately.
            
            // float zoom = 45.0;
            // if(addressPlacemark.country){
            //     zoom -= 0.0;
            //     NSLog(@"País: %@",addressPlacemark.country);
                
            //     if(addressPlacemark.administrativeArea){
            //         zoom -= 38.0;
            //         NSLog(@"Estado: %@",addressPlacemark.administrativeArea);
                    
            //         if(addressPlacemark.subAdministrativeArea){
            //             zoom -= 4.0;
            //             NSLog(@"Area: %@",addressPlacemark);
                        
            //             if(addressPlacemark.thoroughfare    ){
            //                 zoom -= 2.0;
            //             }
            //         }
            //     }
            // }
            
            NSLog(@"Zoom = %f", zoom);
            MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(addressPlacemark.location.coordinate, MKCoordinateSpanMake(zoom, zoom));
            
            //Move the map to the placemark
            [self.appleMap setRegion:coordinateRegion animated:YES];
   
        }
    }];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    
    [self.searchBar resignFirstResponder];
//    [self clear];
    
}

-(IBAction)search{
    
    self.searchBar.hidden = !self.searchBar.hidden;
}

#pragma mark - Location Manager Callbacks

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
   
    
    [PFGeoPoint geoPointForCurrentLocationInBackground:^(PFGeoPoint *geoPoint, NSError *error) {
        
        if (!error) {
            
            
            // Create Object
            PFObject *offersLocation = [PFObject objectWithClassName:@"Offers"];
            
            //Create a point for markers
            PFGeoPoint *offersPoint = offersLocation[@"places_coordinate"];
            
            // Check current Location
            NSLog(@"OffersPoint: %@", offersPoint);
            
            // Create a query for Places of interest near current location
            PFQuery *query = [PFQuery queryWithClassName:@"Offers"];
            
            [query whereKey:@"places_coordinate" nearGeoPoint:geoPoint withinKilometers:5.0];
            
            NSLog(@"Query: %@",query);
            
            // Limit the query
            query.limit = 10;
            
            // Store query in an Array
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                
                NSLog(@"Array: %@",objects);
                
                if (!error) {
                    for (PFObject *offerObject in objects) {
                        
                        
                        PFGeoPoint *offerPoint = [offerObject objectForKey:@"places_coordinate"];
                        
                        MKPointAnnotation *geoPointAnnotation = [[MKPointAnnotation alloc]
                                                                 init];
                        
                        geoPointAnnotation.coordinate = CLLocationCoordinate2DMake(offerPoint.latitude, offerPoint.longitude);
                        
                        geoPointAnnotation.title = offerObject[@"companyName"];
                        
                        [self.appleMap addAnnotation:geoPointAnnotation];
                        
                        NSLog(@"Annotation: %@",geoPointAnnotation);
                        
                    }
                }

            }];
        }
    }];
    
}



#pragma mark - MKMapViewDelegate


-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    NSLog(@"latitude delta = %f", mapView.region.span.latitudeDelta);
    if(mapView.region.span.latitudeDelta < 0.02){
        NSLog(@"threshold passed");
        
        PFGeoPoint *centerPoint = [PFGeoPoint geoPointWithLatitude:mapView.region.center.latitude longitude:mapView.region.center.longitude];
        
        // Create Object
        PFObject *offersLocation = [PFObject objectWithClassName:@"Offers"];
        
        //Create a point for markers
        PFGeoPoint *offersPoint = offersLocation[@"places_coordinate"];
        
        // Check current Location
        NSLog(@"OffersPoint: %@", offersPoint);
        
        // Create a query for Places of interest near current location
        PFQuery *query = [PFQuery queryWithClassName:@"Offers"];
        
        [query whereKey:@"places_coordinate" nearGeoPoint:centerPoint withinKilometers:5.0];
        
        //NSLog(@"Query: %@",query);
        
        // Limit the query
        query.limit = 10;
        
        // Store query in an Array
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            NSLog(@"Array: %@",objects);
            
            
            for (PFObject *offerObject in objects) {
                
                
                PFGeoPoint *offerPoint = [offerObject objectForKey:@"places_coordinate"];
                
                MKPointAnnotation *geoPointAnnotation = [[MKPointAnnotation alloc]
                                                         init];
                
                geoPointAnnotation.coordinate = CLLocationCoordinate2DMake(offerPoint.latitude, offerPoint.longitude);
                
                geoPointAnnotation.title = offerObject[@"companyName"];
                
                [self.appleMap addAnnotation:geoPointAnnotation];
                
                NSLog(@"Annotation: %@",geoPointAnnotation);
                
            }
        }];
    }
}



-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKAnnotationView *pinOffers = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    
    pinOffers.image = [UIImage imageNamed:@"tenhoDesconto_logo.png"];
    
    //pinOffers.pinColor = MKPinAnnotationColorRed;
    
    pinOffers.canShowCallout = YES;
    
    pinOffers.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    return pinOffers;
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    CGPoint annotationCenter=CGPointMake(control.frame.origin.x+(control.frame.size.width/2),control.frame.origin.y+(control.frame.size.height/2));
    
    CLLocationCoordinate2D newCenter=[mapView convertPoint:annotationCenter toCoordinateFromView:control.superview];
    
    [mapView setCenterCoordinate:newCenter animated:YES];
    
    UIViewController *offer = [self.storyboard instantiateViewControllerWithIdentifier:@"offersFromMap"];
    
    [self presentViewController:offer animated:YES completion:nil];
    
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    
    
    
}






#pragma mark - Actions


- (IBAction)centerMap:(id)sender {
    
    if ([sender isTouchInside]) {
        
        [sender setImage:[UIImage imageNamed:@"location48_full"] forState:UIControlStateSelected];
        
    } else if(![sender isTouchInside]){
        [sender setImage:[UIImage imageNamed:@"location48"] forState:UIControlStateNormal];
        [sender setSelected:NO];
    }
    
    [self.appleMap setCenterCoordinate:self.appleMap.userLocation.location.coordinate animated:YES];
    
}

#pragma mark - Navigation

//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    if ([segue.identifier isEqualToString:@"detail"]) {
//        DetailViewController *destinationDetail = segue.destinationViewController;
//        destinationDetail.clickedDealDetail = self.clickedDeal;
//    }
//}

@end









