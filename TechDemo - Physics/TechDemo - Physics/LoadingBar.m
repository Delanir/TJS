//
//  LoadingBar.m
//  L'Archer
//
//  Created by jp on 26/04/13.
//
//

#import "LoadingBar.h"

@implementation LoadingBar

@synthesize loadingTimer;

-(id) init
{
    if(self = [super init])
    {
        //CCProgressTimer
        CCSprite * loadingSprite = [[CCSprite alloc] initWithFile:@"plus.png"];
        [self setLoadingTimer:[CCProgressTimer progressWithSprite:loadingSprite]];
        [loadingTimer setType: kCCProgressTimerTypeRadial];
        [loadingTimer setPercentage:0];
        [self addChild:loadingTimer z:2];
    }
    return self;
}

-(void) dealloc
{
    [loadingTimer release];
    [super dealloc];
}

-(void) addProgress:(float) variation
{
    float currentPercentage = [loadingTimer percentage];
    [loadingTimer setPercentage:currentPercentage+variation];
}

@end
