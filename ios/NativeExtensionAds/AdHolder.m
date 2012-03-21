//
//  TestANe.m
//  DFPExample
//
//  Created by Emil Atanasov on 11/25/11.
//  Copyright 2011  Lancelotmobile ltd. All rights reserved.
//

#import "AdHolder.h"

@interface AdHolder ()
  - (void)showAdPanel: (CGRect) rect;
@end

@implementation AdHolder

@synthesize isInRealMode;
@synthesize viewFrame;
@synthesize unitId;
@synthesize context;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = viewFrame;
    
    [self showAdPanel:CGRectMake(0.0,0.0,viewFrame.size.width,viewFrame.size.height)];

}

- (void) refresh
{
    if(_bannerView)
    {
        if(isInRealMode)
        {
            // Initiate a generic request to load it with an ad.
            [_bannerView loadRequest:[GADRequest request]];
        }
//        else
//        {
//            //test request
//            GADRequest * request = [GADRequest request];
//            request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID,[[UIDevice currentDevice] uniqueIdentifier], nil];
//            [_bannerView loadRequest:request];
//        }

    }
}

- (void)showAdPanel: (CGRect) rect
{
    //add the ad view to the screen
    // Create a view of the standard size at the bottom of the screen.
    _bannerView = [[GADBannerView alloc] initWithFrame:rect];
    
    // Specify the ad's "unit identifier." This is your AdMob Publisher ID.
    _bannerView.adUnitID = unitId;
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    _bannerView.rootViewController = self;
    _bannerView.delegate = self;
    [self.view addSubview:_bannerView];
    if(isInRealMode)
    {
        // Initiate a generic request to load it with an ad.
        [_bannerView loadRequest:[GADRequest request]];
    }
    else
    {
        //test request
        GADRequest * request = [GADRequest request];
        request.testDevices = [NSArray arrayWithObjects:GAD_SIMULATOR_ID,[[UIDevice currentDevice] uniqueIdentifier], nil];
        [_bannerView loadRequest:request];
    }
    NSLog(@"Ad initialized");
    
    
}

- (void)adViewWillDismissScreen:(GADBannerView *)adView
{
    NSLog(@"Ad adViewWillDismissScreen");
    self.view.hidden = YES;

}

- (void)adViewDidDismissScreen:(GADBannerView *)adView
{
     NSLog(@"Ad adViewDidDismissScreen");
     self.view.frame = viewFrame;
     self.view.hidden = NO;

}

- (void)adViewWillPresentScreen:(GADBannerView *)bannerView
{
    //This is the event name we will use in actionscript to know it is our
    //event that was dispatched.
    NSString *event_name = @"AD_CLICKED";
    NSString *event_level = @"AD_CLICKED_LEVEL";
    
    FREDispatchStatusEventAsync(self.context, (uint8_t*)[event_name UTF8String], (uint8_t*)[event_level UTF8String]);

}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSString *event_name = @"AD_ERROR";
    NSString *event_level = @"AD_ERROR_LEVEL";
//    NSLog(@"Some problem %@",error);
    FREDispatchStatusEventAsync(self.context, (uint8_t*)[event_name UTF8String], (uint8_t*)[event_level UTF8String]);
}

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView
{
    NSString *event_name = @"AD_RECEIVED";
    NSString *event_level = @"AD_RECEIVED_LEVEL";

    FREDispatchStatusEventAsync(self.context, (uint8_t*)[event_name UTF8String], (uint8_t*)[event_level UTF8String]);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _bannerView.delegate = nil;
    [_bannerView release];
    _bannerView = nil;
    
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc
{
    [super dealloc];
    [_bannerView release];
    _bannerView = nil;
    context = NULL;
    self.unitId = nil;
}

@end
