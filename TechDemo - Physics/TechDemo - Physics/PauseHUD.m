//
//  PauseHUD.m
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//

#import "PauseHUD.h"
#import "SimpleAudioEngine.h"
#import "LevelLayer.h"

@implementation PauseHUD

-(id) init
{
    self = [super init];
#ifdef kDebugMode
    [[Registry shared] addToCreatedEntities:self];
#endif
    return self;
}

-(CCSprite *) getPauseButton
{
  return _pause;
};

-(CCSprite *) getMenuButton
{
    return _menu;
};

-(CCSprite *) getMainButton
{
    return _main;
};

-(CCSprite *) getRetryButton{
    return _retry;
};

-(void) dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}


@end
