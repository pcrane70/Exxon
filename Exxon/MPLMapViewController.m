//
//  MPLMapViewController.m
//  Exxon
//
//  Created by won kim on 2/24/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "MPLMapViewController.h"
#import "MobilAnnotation.h"
#import "ExxonAnnotation.h"

enum PinAnnotationTypeTag {
    PinAnnotationTypeExxon = 0,
    PinAnnotationTypeMobil = 1
};


@interface MPLMapViewController ()
{
    
}

@end

@implementation MPLMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initFakedata];
}

//TODO: remove test purpose

-(void)initFakedata
{

    
    
    NSLog(@"pressButton");
    CLLocationCoordinate2D location;
	location.latitude = (double) 40.749078;
	location.longitude = (double) -74.000473;
    ExxonAnnotation *newAnnotation = [[ExxonAnnotation alloc] initWithCoordinate:location ];
    [self.mapView addAnnotation:newAnnotation];
    
    location.latitude = (double) 40.761561;
	location.longitude = (double)-73.99395;
    MobilAnnotation *newAnnotation1 = [[MobilAnnotation alloc] initWithCoordinate:location ];
    [self.mapView  addAnnotation:newAnnotation1];
    
    
    location.latitude = (double) 40.765201;
	location.longitude = (double)-73.962021;
    MobilAnnotation *newAnnotation2 = [[MobilAnnotation alloc] initWithCoordinate:location ];
    [self.mapView  addAnnotation:newAnnotation2];

    location.latitude = (double) 40.754019;
	location.longitude = (double)-73.980904;
    ExxonAnnotation *newAnnotation3 = [[ExxonAnnotation alloc] initWithCoordinate:location ];
    [self.mapView  addAnnotation:newAnnotation3];
   
    //curPos
    location.latitude = (double) 40.745176;
	location.longitude = (double)-73.979187;
    MobilAnnotation *newAnnotation4 = [[MobilAnnotation alloc] initWithCoordinate:location ];
    newAnnotation4.title=@"user";
    [self.mapView  addAnnotation:newAnnotation4];
    
    location.latitude = (double) 40.738933;
	location.longitude = (double)-73.98674;
    MobilAnnotation *newAnnotation5 = [[MobilAnnotation alloc] initWithCoordinate:location ];
    [self.mapView  addAnnotation:newAnnotation5];
    
    location.latitude = (double) 40.728267;
	location.longitude = (double)-73.983994;
    ExxonAnnotation *newAnnotation6 = [[ExxonAnnotation alloc] initWithCoordinate:location ];
    [self.mapView  addAnnotation:newAnnotation6];
    
    
    location.latitude = (double) 40.736332;
	location.longitude = (double)-73.997383;
    MobilAnnotation *newAnnotation7 = [[MobilAnnotation alloc] initWithCoordinate:location ];
    [self.mapView  addAnnotation:newAnnotation7];
    
   //  [self.mapView setRegion:MKCoordinateRegionForMapRect([poly boundingMapRect]) animated:YES];
    
    
    
    [self zoomToFitMapAnnotations];
    
    
    NSString* text=@"What's for dinner? Kim Kardashian wants to know!";
    
    
   
    NSMutableCharacterSet *AcceptedCharacterSet = [[NSMutableCharacterSet alloc] init];
    [AcceptedCharacterSet formUnionWithCharacterSet:[NSCharacterSet letterCharacterSet]];
    [AcceptedCharacterSet formUnionWithCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
    [AcceptedCharacterSet addCharactersInString:@"'"];

     NSArray *words = [text componentsSeparatedByCharactersInSet:[AcceptedCharacterSet invertedSet]];
    NSLog(@"%@",words);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)zoomToFitMapAnnotations {
    
    if ([self.mapView.annotations count] == 0) return;
    
    int i = 0;
    MKMapPoint points[[self.mapView.annotations count]];
    
    //build array of annotation points
    for (id<MKAnnotation> annotation in [self.mapView annotations])
        points[i++] = MKMapPointForCoordinate(annotation.coordinate);
    
    MKPolygon *poly = [MKPolygon polygonWithPoints:points count:i];
    
    MKMapRect rect=MKMapRectMake([poly boundingMapRect].origin.x-10000, [poly boundingMapRect].origin.y-10000, [poly boundingMapRect].size.width+20000, [poly boundingMapRect].size.height+20000);
    
    NSLog(@" %f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height);
    
    [self.mapView setRegion:MKCoordinateRegionForMapRect(rect) animated:YES];
    
    
}

#pragma  mark- mapView delegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation: (MKUserLocation *)userLocation
{
    //   mapView.centerCoordinate =userLocation.location.coordinate;
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString *ExxonAnnotationIdentifier = @"RedPinAnnotation";
    static NSString *MobilAnnotationIdentifier = @"PurplePinAnnotation";
    static NSString *userAnnotationIdentifier = @"UserPinAnnotation";
    
    if ([annotation isKindOfClass:[ExxonAnnotation class]]) {
        MKPinAnnotationView *annotationView =
        (MKPinAnnotationView *)[mapView
                                dequeueReusableAnnotationViewWithIdentifier:ExxonAnnotationIdentifier];
        
        if (!annotationView) {
            annotationView = [[MKPinAnnotationView alloc]
                              initWithAnnotation:annotation
                              reuseIdentifier:ExxonAnnotationIdentifier];
            annotationView.tag = PinAnnotationTypeExxon;
        //    annotationView.canShowCallout = YES;
        //    annotationView.pinColor = MKPinAnnotationColorRed;
         //   annotationView.animatesDrop = YES;
         //   annotationView.draggable = NO;
            annotationView.image=[UIImage imageNamed:@"icon_Exxon.png"];
           
        }
        
        return annotationView;
    } else if ([annotation isKindOfClass:[MobilAnnotation class]]) {
        MKPinAnnotationView *annotationView =
        (MKPinAnnotationView *)[mapView
                                dequeueReusableAnnotationViewWithIdentifier:MobilAnnotationIdentifier];
        
        if (!annotationView) {
            annotationView = [[MKPinAnnotationView alloc]
                              initWithAnnotation:annotation
                              reuseIdentifier:MobilAnnotationIdentifier];
            annotationView.tag = PinAnnotationTypeMobil;
       //     annotationView.canShowCallout = YES;
        //    annotationView.pinColor = MKPinAnnotationColorPurple;
        //    annotationView.animatesDrop = YES;
         //   annotationView.draggable = NO;
            if ([[annotation title] isEqualToString:@"user"])
             annotationView.image=[UIImage imageNamed:@"userLocation.png"];
            else
               annotationView.image=[UIImage imageNamed:@"icon_Mobil.png"];
        }
        
        return annotationView;
    }
    else
    {
//        MKPinAnnotationView *annotationView =
//        (MKPinAnnotationView *)[mapView
//                                dequeueReusableAnnotationViewWithIdentifier:userAnnotationIdentifier];
//        if (!annotationView) {
//            annotationView = [[MKPinAnnotationView alloc]
//                              initWithAnnotation:annotation
//                              reuseIdentifier:userAnnotationIdentifier];
//            annotationView.tag = PinAnnotationTypeMobil;
//            //     annotationView.canShowCallout = YES;
//            //    annotationView.pinColor = MKPinAnnotationColorPurple;
//            //    annotationView.animatesDrop = YES;
//            //   annotationView.draggable = NO;
//            annotationView.image=[UIImage imageNamed:@"userLocation.png"];
//        }
        
    }
    
    
    return nil; 
}


@end
