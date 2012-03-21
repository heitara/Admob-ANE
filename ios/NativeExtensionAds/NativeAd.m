//
//  NativeAd.m
//  NativeExtensionAds
//
//  Created by Emil Atanasov on 11/24/11.
//  Copyright 2011 Lancelotmobile ltd. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "AdHolder.h"


AdHolder *adHolder;
NSString *bannerUnitId;
BOOL inRealMode;
FREContext aContext;

FREObject initAd(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
    //Temporary values to hold our actionscript code.    
    int32_t x;
    int32_t y;
    int32_t w;
    int32_t h;
    
    //Turn our actionscrpt code into native code.
    FREGetObjectAsInt32(argv[0], &x);
    FREGetObjectAsInt32(argv[1], &y);
    FREGetObjectAsInt32(argv[2], &w);
    FREGetObjectAsInt32(argv[3], &h);
    
    //    NSString *messageString = [NSString stringWithUTF8String:(char*)message];
    
    CGRect rect = CGRectMake(x,y,w,h);
    adHolder = [[AdHolder alloc] init];
    adHolder.viewFrame = rect;
    adHolder.unitId = bannerUnitId;
    adHolder.isInRealMode = inRealMode;
    adHolder.context = ctx;
//    id delegate = [[UIApplication sharedApplication] delegate];
//    UIWindow * win = [delegate window];
//    [win addSubview:adHolder.view];
    
    return NULL;    
}

FREObject setAdMode(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
    uint32_t isInRealMode;
    //convert our actionscrpt code into native code.
    if( FREGetObjectAsBool(argv[0], &isInRealMode) == FRE_OK)
    {
        if (isInRealMode) 
        {
            inRealMode = YES;
        }
        else
        {
            inRealMode = NO;
        }
    }
    
    return NULL;
}


FREObject showAd(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
    //Temporary values to hold our actionscript values.    
    int32_t x;
    int32_t y;
    int32_t w;
    int32_t h;
    
    //Turn our actionscrpt code into native code.
    FREGetObjectAsInt32(argv[0], &x);
    FREGetObjectAsInt32(argv[1], &y);
    FREGetObjectAsInt32(argv[2], &w);
    FREGetObjectAsInt32(argv[3], &h);
    
//    NSString *messageString = [NSString stringWithUTF8String:(char*)message];
    
    if(adHolder)
    {
        CGRect rect = CGRectMake(x,y,w,h);
        adHolder.viewFrame = rect;
        adHolder.view.frame = rect;
        [adHolder refresh];
        
        id delegate = [[UIApplication sharedApplication] delegate];
        UIWindow * win = [delegate window];
        [win addSubview:adHolder.view];
    }
    return NULL;    
}

FREObject hideAd(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
    [adHolder.view removeFromSuperview];

    return NULL;    
}


FREObject removeAd(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{

    [adHolder release];
    adHolder = nil;
    
    return NULL;    
}


FREObject setUnitId(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
    uint32_t length = 0;
    const uint8_t *value;
    if( FREGetObjectAsUTF8( argv[0], &length, &value ) == FRE_OK )
    {
        bannerUnitId = [NSString stringWithUTF8String: (char*) value];
        [bannerUnitId retain];
    }
    
    return NULL;    
}

// ContextFinalizer().
void NADContextFinalizer(FREContext ctx) 
{
    //Cleanup Here.
    [adHolder release];
    [bannerUnitId release];
    adHolder = nil;
    bannerUnitId = nil;
    aContext = NULL;
    return;
}

// ContextInitializer()
void NADContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, 
						uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) 
{
    *numFunctionsToTest = 6;
    
	FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * 6);
	func[0].name = (const uint8_t*) "initAd";
	func[0].functionData = NULL;
    func[0].function = &initAd;
    
	func[1].name = (const uint8_t*) "setAdMode";
	func[1].functionData = NULL;
    func[1].function = &setAdMode;
    
    func[2].name = (const uint8_t*) "setUnitId";
	func[2].functionData = NULL;
    func[2].function = &setUnitId;
    
    func[3].name = (const uint8_t*) "showAd";
	func[3].functionData = NULL;
    func[3].function = &showAd;
    
    func[4].name = (const uint8_t*) "hideAd";
	func[4].functionData = NULL;
    func[4].function = &hideAd;
    
    func[5].name = (const uint8_t*) "removeAd";
	func[5].functionData = NULL;
    func[5].function = &removeAd;
    
    
	*functionsToSet = func;
    
    bannerUnitId = nil;
    adHolder = nil;
    inRealMode = false;
    aContext = ctx;
}


// ExtInitializer()
void ExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, 
                    FREContextFinalizer* ctxFinalizerToSet) 
{    
    *extDataToSet = NULL;
    *ctxInitializerToSet = &NADContextInitializer;
    *ctxFinalizerToSet = &NADContextFinalizer;
}

// ExtFinalizer()
void ExtFinalizer(void* extData) {
    
    // Do Cleanup here.
    return;
}
