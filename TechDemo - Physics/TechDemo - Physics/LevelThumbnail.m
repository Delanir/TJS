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
#import "SimpleAudioEngine.h"


@implementation LevelThumbnail
@synthesize isEnabled,numberStars,level;

-(id) init
{
    self = [super init];
#ifdef kDebugMode
    [[Registry shared] addToCreatedEntities:self];
#endif
    return self;
}

-(void)initLevel
{
    [_thumbnail setIsEnabled:isEnabled];
    [_stars makeVisible:numberStars];
}

- (void) goToLevel:(id)sender
{
    [[SimpleAudioEngine sharedEngine] playEffect:[[Config shared] getStringProperty:@"click"]];
    [[GameManager shared] runLevel:level];
}


-(void) setThumbnail:(NSString *) sprite
{
    CCSprite * spriteImage1 = [CCSprite spriteWithSpriteFrameName:sprite];
    CCSprite * spriteImage2 = [CCSprite spriteWithSpriteFrameName:sprite];
    [_thumbnail setNormalImage: spriteImage1];
    [_thumbnail setSelectedImage: spriteImage2];
}

-(void) onExit
{
    [self removeAllChildrenWithCleanup:YES];
    [super onExit];
}

-(void) dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}


@end
