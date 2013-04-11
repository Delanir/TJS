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
    //TODO criar aqui o mapa do jogo
 
    
    CCSprite * bg= [CCSprite spriteWithFile:@"background.png"];
    [bg setPosition:ccp(winSize.width/2, winSize.height/2)];
    [self addChild:bg z:-1000];
    
    Wall * wall = [[Wall alloc] init];
    [self addChild:wall];
    
    [wall setTag:0];
    [wall release];
}

- (void) mountScene
{
    [(Wall*)[self getChildByTag:0] mountWall];
}

- (void) dealloc
{
    [super dealloc];
}

@end
