//
//  ImageView.h
//  GeoTrash
//
//  Created by Patrick Russell on 15/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Location.h"

@interface ImageView : UIViewController <LocationDelegate, CLLocationManagerDelegate> {

	UIImageView * theImageView;
	UIActivityIndicatorView *myActivityIndicator;
	Location *CLController;
	NSString *lat;
	NSString *lon;
	
}
-(void)Update:(NSString *)imgLink;

@property (nonatomic, retain) IBOutlet UIImageView * theImageView;
@property (nonatomic, retain) Location *CLController;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lon;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *myActivityIndicator;

- (IBAction)upload:(id)sender;



@end
