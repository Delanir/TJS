//
//  LevelThumbnail.m
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//

#import "LevelThumbnail.h"
#import "LevelLayer.h"
#import "GameManager.h"
#import "LoadingBar.h"


@implementation LevelThumbnail
@synthesize isEnabled,numberStars,level;


-(void)initLevel
{
    [_thumbnail setIsEnabled:isEnabled];
    [_stars makeVisible:numberStars];
}

- (void) goToLevel:(id)sender
{
#warning estou aqui a mais
    LoadingBar * loading = [[LoadingBar alloc] init];
    [[loading loadingTimer] setPercentage:100]; // temporario
    [loading setPosition: ccp(512, 384)];
    [loading setZOrder:2000];
    [self addChild:loading];
    [loading release];
    [[CCDirector sharedDirector] drawScene];
#warning estou aqui a mais
    [[GameManager shared] runLevel:level];
}

-(void) setThumbnail:(NSString *) sprite
{
    CCSprite * spriteImage1 = [CCSprite spriteWithSpriteFrameName:sprite];
    CCSprite * spriteImage2 = [CCSprite spriteWithSpriteFrameName:sprite];
    [_thumbnail setNormalImage: spriteImage1];
    [_thumbnail setSelectedImage: spriteImage2];
}

@end
