//
//  ImageView.h
//  GeoTrash
//
//  Created by Patrick Russell on 15/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageView : UIViewController {

	UIImageView * theImageView;
	
}

@property (nonatomic, retain) IBOutlet UIImageView * theImageView;

- (IBAction)upload:(id)sender;

@end
