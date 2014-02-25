//
//  MobilAnnotation.h
//  Exxon
//
//  Created by won kim on 2/25/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MobilAnnotation : NSObject<MKAnnotation>
{
    
}
@property (nonatomic, copy) NSString* title;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

-(id)initWithCoordinate:(CLLocationCoordinate2D)c2d;

@end
