//
//  HomeViewController.m
//  tenhoDesconto
//
//  Created by Joao Paulo Galvao Alves on 4/11/14.
//  Copyright (c) 2014 tenhoDesconto. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface HomeViewController ()

@property (nonatomic, strong) NSArray* ofertas;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapa.delegate = self;
    self.mapa.showsUserLocation = YES;
    self.navigationController.navigationBarHidden = NO;
//    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    
    [self.locationManager startUpdatingLocation];
    
    // Listen for annotation updates. Triggers a refresh whenever an annotation is dragged and dropped.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadObjects) name:@"geoPointAnnotiationUpdated" object:nil];

    
    
    // Objetos mais próximos
    
    
    
//
//    // Ponto de Abertura do Mapa
//    CLLocationCoordinate2D coordenadaInicial = CLLocationCoordinate2DMake(22.5892751, -81.2443237);
    
    // Definir o Zoom
//    MKCoordinateSpan zoom = MKCoordinateSpanMake(2, 2);
    
    // Criar uma Região
//    MKCoordinateRegion regiao = MKCoordinateRegionMake(coordenadaInicial, zoom);
    
//    [self.mapa setRegion:regiao animated:YES];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadOfertas];
}

- (void)loadOfertas
{
    PFQuery *query = [PFQuery queryWithClassName:@"Oferta"];
    [query orderByDescending:@"createdAt"];
    
    __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray* results, NSError* error) {
        weakSelf.ofertas = results;
        [weakSelf.ofertasProximas reloadData];
    }];
}

// Localização atual do usuário

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapa setRegion:[self.mapa regionThatFits:region] animated:YES];
}

#pragma mark - PFQueryTableView Data Source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.ofertas count];
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFObject* oferta = [self.ofertas objectAtIndex:indexPath.row];
    
    // Criar a célula
    
    static NSString *simpleTableIdentifier = @"homeCells";
    
    PFTableViewCell *cell = [self.ofertasProximas dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    cell.textLabel.text = [oferta objectForKey:@"nomeEmpresa"];
    
   	
    
    
    return cell;
}























@end
