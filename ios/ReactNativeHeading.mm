//
//  ReactNativeHeading.m
//  ReactNativeHeading
//
//  Created by Yonah Forst on 18/02/16.
//  Copyright © 2016 Yonah Forst. All rights reserved.
//

#import "ReactNativeHeading.h"
#import <CoreLocation/CoreLocation.h>
#import <React/RCTEventEmitter.h>
#import <React/RCTBridgeModule.h>
#import <ReactCommon/RCTTurboModule.h>

using namespace facebook::react;

@interface ReactNativeHeading () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locManager;
@end

@implementation ReactNativeHeading

RCT_EXPORT_MODULE(ReactNativeHeading);

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.locManager = [[CLLocationManager alloc] init];
        self.locManager.delegate = self;
    }
    
    return self;
}

#pragma mark - TurboModule provider

- (std::shared_ptr<TurboModule>)getTurboModule:
  (const ObjCTurboModule::InitParams &)params
{
  return std::make_shared<NativeReactNativeHeadingSpecJSI>(params);
}

#pragma mark - RCTEventEmitter

- (NSArray<NSString *> *)supportedEvents
{
  return @[@"headingUpdated"];
}

#pragma mark - Spec methods

- (void)start:(double)filter
      resolve:(RCTPromiseResolveBlock)resolve
      reject:(RCTPromiseRejectBlock)reject
{
    if ([CLLocationManager headingAvailable]) {
        if (!filter)
            filter = 5;
        
        self.locManager.headingFilter = filter;
        [self.locManager startUpdatingHeading];
        resolve(@YES);
    } else {
        reject(@"E_HEADING_UNAVAILABLE", @"Heading not available", nil);
    }
}

- (void)stop
{
    [self.locManager stopUpdatingHeading];
}

- (void)addListener:(NSString *)eventName
{
    [super addListener:eventName];
}

- (void)removeListeners:(double)count
{
    [super removeListeners:count];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
        didUpdateHeading:(CLHeading *)newHeading
{
    if (newHeading.headingAccuracy < 0)
        return;
    
    // Use the true heading if it is valid.
    CLLocationDirection heading = ((newHeading.trueHeading > 0) ?
                                   newHeading.trueHeading : newHeading.magneticHeading);
    
    if (self.bridge != nil) {
        [self sendEventWithName:@"headingUpdated" body:@{@"heading": @(heading)}];
    }
}

@end
