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

-(CCSprite *) getPauseButton
{
  return _pause;
};

-(CCSprite *) getMenuButton
{
    return _menu;
};

-(CCSprite *) getRetryButton{
    return _retry;
};




@end
