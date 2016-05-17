//
//  CheckLocation.m
//  DBSC4
//
//  Created by Tan Chun Yew on 1/18/16.
//  Copyright © 2016 ncs. All rights reserved.
//

#import "CheckLocation.h"
#import <CoreLocation/CoreLocation.h>

@interface CheckLocation() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation CheckLocation

+ (instancetype)sharedManager
{
    static id sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (void)startGetLocation
{
    //Check if the locationServices is Enabled
    if ([CLLocationManager locationServicesEnabled]) {
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
            if ([[self locationManager] respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
                [[self locationManager] requestWhenInUseAuthorization];
            }
        } else {
            [self startUpdateLocation:[CLLocationManager authorizationStatus]];
        }
    }
}

#pragma mark - Lazy loading

- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    }
    return _locationManager;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    [manager stopUpdatingLocation];
    
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:[locations firstObject] completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"reverseGeocodeLocation error: %@", error.description);
        }
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks firstObject];
            [[NSNotificationCenter defaultCenter] postNotificationName:K_NOTIFICATION_LOCATION_GET object:self userInfo:@{@"placemark":placemark}];
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"locationManager didFailWithError: %@", error.description);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"locationManager didChangeAuthorizationStatus");
    [self startUpdateLocation:status];
}

#pragma mark - Private methods
- (void)startUpdateLocation:(CLAuthorizationStatus)status {
    
    BOOL shouldFetchLocation= NO;
    
    switch (status) {
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 80000
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"AuthorizedAlways");
            shouldFetchLocation = YES;
            break;
#else
        case kCLAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            shouldFetchLocation = YES;
            break;
#endif
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"WhenInUse");
            shouldFetchLocation = YES;
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"Denied");
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"NotDetermined");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
    
    if (shouldFetchLocation) {
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - Location services alert


@end
