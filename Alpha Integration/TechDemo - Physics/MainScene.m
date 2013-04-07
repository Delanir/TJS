//
//  MainScene.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "MainScene.h"

@implementation MainScene

@synthesize winSize;

- (id) initWithWinSize:(CGSize)winSz
{
    if( (self=[super init]))
    {
        [self setWinSize:winSz];
        [self setupScene];
    }
    return self;
    
}

- (void) setupScene
{
    //@TODO criar aqui o mapa do jogo
    
    CCSprite * bg= [CCSprite spriteWithFile:@"background8@2x.jpg"];
    [bg setPosition:ccp(winSize.width/2, winSize.height/2)];
    [self addChild:bg z:0];
}

@end
