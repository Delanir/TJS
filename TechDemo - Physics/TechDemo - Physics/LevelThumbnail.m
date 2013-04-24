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


@implementation LevelThumbnail
@synthesize isEnabled,numberStars,level;


-(void)initLevel
{
    [_thumbnail setIsEnabled:isEnabled];
    [_stars makeVisible:numberStars];
}

- (void) goToLevel:(id)sender
{
    [[GameManager shared] runLevel:level];
}

-(void) setThumbnail:(NSString *) sprite
{
    CCSprite * spriteImage = [CCSprite spriteWithSpriteFrameName:sprite];
    CGRect rect = CGRectMake (0,0,
                              [spriteImage contentSize].width,
                              [spriteImage contentSize].height);
    CCSpriteFrame * spriteFrame = [[CCSpriteFrame alloc] initWithTextureFilename:sprite rect:rect];
    
    [_thumbnail setSelectedSpriteFrame: spriteFrame];
    [_thumbnail setNormalSpriteFrame: spriteFrame];
}

@end
