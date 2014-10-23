//
//  ViewController.h
//  mapTest
//
//  Created by Joao Alves on 9/25/14.
//  Copyright (c) 2014 joaopaulo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate>

@property (nonatomic, strong) GMSMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;


@end

