//
//  GameOver.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/18/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "GameOver.h"
#import "SimpleAudioEngine.h"
#import "LevelLayer.h"

@implementation GameOver

-(id) init
{
    self = [super init];
#ifdef kDebugMode
    [[Registry shared] addToCreatedEntities:self];
#endif
    return self;
}

-(CCSprite *) getMenuButton
{
    return _menu;
};

-(CCSprite *) getRetryButton{
    return _retry;
};

-(CCSprite *) getSkillButton{
    return _skill;
};

-(CCSprite *) getMainButton
{
    return _main;
};

-(void) dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}



@end
