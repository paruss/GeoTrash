//
//  CurrentLocationHandler.m
//  GeoTrash
//
//  Created by Patrick Russell on 20/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CurrentLocationHandler.h"


@implementation CurrentLocationHandler
@synthesize lat, lon, CLController;

- (void)start{
	
	// Initalise CLController and start the location updating
	
	CLController = [[Location alloc] init];
	CLController.delegate = self;
	CLController.locMgr.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
	[CLController.locMgr startUpdatingLocation];

}

- (void)locationUpdate:(CLLocation *)location {
	
	// Delegate of startUpdatingLocation
	// Get the current location and save them
	
	self.lat = [[NSString alloc]init];
	NSString *locLat;
	NSString *locLong;
	locLat  = [NSString stringWithFormat:@"%lf", location.coordinate.latitude];
	locLong  = [NSString stringWithFormat:@"%lf", location.coordinate.longitude];
	self.lat = locLat;
	self.lon = locLong;
}

-(void)locationError:(NSError *)error{
	
	NSLog(@"Problem with uploading");
	
}

- (void)dealloc {
	
	[lat release];
	[lon release];
    [CLController dealloc];
	[super dealloc];
}

@end
