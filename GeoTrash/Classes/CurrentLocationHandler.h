//
//  CurrentLocationHandler.h
//  GeoTrash
//
//  Created by Patrick Russell on 20/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h";


@interface CurrentLocationHandler : NSObject <LocationDelegate, CLLocationManagerDelegate> {

	NSString *lat;
	NSString *lon;
	Location *CLController;
}

- (void)start;

@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lon;
@property (nonatomic, retain) Location *CLController;

@end
