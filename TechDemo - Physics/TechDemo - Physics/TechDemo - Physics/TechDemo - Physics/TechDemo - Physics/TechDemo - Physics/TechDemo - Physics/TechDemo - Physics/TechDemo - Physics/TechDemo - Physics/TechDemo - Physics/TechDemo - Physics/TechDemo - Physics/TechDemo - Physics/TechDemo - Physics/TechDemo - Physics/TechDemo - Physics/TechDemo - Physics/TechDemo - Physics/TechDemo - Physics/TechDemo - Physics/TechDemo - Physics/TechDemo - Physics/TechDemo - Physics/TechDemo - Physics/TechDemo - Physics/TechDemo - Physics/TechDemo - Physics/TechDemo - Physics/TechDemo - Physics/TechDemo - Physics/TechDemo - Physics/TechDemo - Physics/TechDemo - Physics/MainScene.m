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

- (id) initWithWinSize:(CGSize) winSz parent: (CCNode*) parent;
{
    if( (self=[super init]))
    {
        [self setWinSize:winSz];
        CCSprite * bg= [CCSprite spriteWithFile:@"background.png"];
        [bg setPosition:ccp(winSize.width/2, winSize.height/2)];
        [self addChild:bg z:-1000];
        
        Wall * wall = [[Wall alloc] initWithParent:parent];
        [self addChild:wall];
        
        [wall release];
    }
    return self;
    
}


- (void) dealloc
{
    [super dealloc];
}

@end
