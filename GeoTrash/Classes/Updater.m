//
//  Updater.m
//  GeoTrash
//
//  Created by Patrick Russell on 15/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.


//  This class will update the current position and photo to the server.

#import "Updater.h"


@implementation Updater

- (void) update:(NSString *)lat setLon:(NSString *)lon {

	NSString *latPost = lat;
	NSString *lonPost = lon;
	NSURL *url = [NSURL URLWithString:@"http://www.skynet.ie/~paruss/iPhone/Uploader.php"];
	ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
	[request setPostValue:lonPost forKey:@"lon"];
	[request setPostValue:latPost forKey:@"lat"];
	[request start]; 
	NSError *error = [request error];
	if (!error) {
		
		NSString *response = [request responseString];
		NSLog(@"Output", response);
	}

}


@end
