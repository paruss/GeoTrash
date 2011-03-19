//
//  UnitTestCase.m
//  GeoTrash
//
//  Created by Patrick Russell on 15/03/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UnitTestCase.h"


@implementation UnitTestCase

#if USE_APPLICATION_UNIT_TEST     // all code under test is in the iPhone Application

- (void) testAppDelegate {
    
    id yourApplicationDelegate = [[UIApplication sharedApplication] delegate];
    STAssertNotNil(yourApplicationDelegate, @"UIApplication failed to find the AppDelegate");
    
}

#else                           // all code under test must be linked into the Unit Test bundle

- (void) testMath {
    
    STAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );
    
}

- (void)testTestFramework
{
    NSString *string1 = @"test";
    NSString *string2 = @"test";
    STAssertEquals(string1, 
                   string2, 
                   @"FAILURE");
    NSUInteger uint_1 = 4;
    NSUInteger uint_2 = 4;
    STAssertEquals(uint_1, 
                   uint_2, 
                   @"FAILURE");
}


#endif


@end
