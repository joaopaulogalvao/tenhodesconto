//
//  MapViewController.h
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 4/22/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController<CLLocationManagerDelegate,GMSMapViewDelegate,MKMapViewDelegate,UISearchBarDelegate>

@property(nonatomic, strong)CLLocationManager *locationManager;
@property(nonatomic, strong) MKPinAnnotationView *geoPointAnnotation;
@property(nonatomic, strong)CLLocation *location;
@property (nonatomic, strong) PFObject *detailItem;
@property (weak, nonatomic) IBOutlet MKMapView *appleMap;
@property (weak, nonatomic) IBOutlet UIButton *locationButton;

- (IBAction)centerMap:(id)sender;



@end
