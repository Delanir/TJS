//
//  MainScene.m
//  TechDemo - Physics
//
//  Created by jp on 01/04/13.
//
//

#import "MainScene.h"
#import "Registry.h"

@implementation MainScene


- (id) init;
{
    if( (self=[super init]))
    {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite * bg= [CCSprite spriteWithFile:@"background.png"];
        [bg setPosition:ccp(winSize.width/2, winSize.height/2)];
        [self addChild:bg z:-1000];
        
        Wall * wall = [[Wall alloc] init];
        [self addChild:wall];
        
        [[Registry shared] registerEntity:wall withName:@"Wall"];
        
        [wall release];
    }
    return self;
    
}

@end
