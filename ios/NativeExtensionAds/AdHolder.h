//
//  TestANe.h
//  DFPExample
//
//  Created by Emil Atanasov on 11/25/11.
//  Copyright 2011  Lancelotmobile ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GADBannerView.h"
#import "FlashRuntimeExtensions.h"

@interface AdHolder : UIViewController <GADBannerViewDelegate> {
   GADBannerView *_bannerView; 
}

@property (nonatomic,assign) BOOL isInRealMode;
@property (nonatomic,assign) CGRect viewFrame;
@property (nonatomic,retain) NSString *unitId;
@property (nonatomic,assign) FREContext context;

- (void) refresh;

@end
