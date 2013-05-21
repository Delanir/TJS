//
//  AchievementNode.m
//  L'Archer
//
//  Created by João Amaral on 3/5/13.
//
//

#import "AchievementNode.h"
#import "Registry.h"

@implementation AchievementNode
@synthesize isEnabled;

-(id) init
{
    self = [super init];
#ifdef kDebugMode
    [[Registry shared] addToCreatedEntities:self];
#endif
    return self;
}

-(void) initAchievement
{
    [spriteIcon setIsEnabled:isEnabled];
}

-(void) setInformation:(int) num
{
    NSDictionary * achievementInfo = [Utils openPlist:@"achievements"];
    NSArray* temp = [achievementInfo objectForKey:@"achievements"];
    
    NSString* title = [[temp objectAtIndex:num] objectAtIndex:0];
    [lblTitle setString:title];
    
    NSString* description = [[temp objectAtIndex:num] objectAtIndex:1];
    [lblDescription setString:description];
}

-(void) setImage:(NSString *)sprite
{
    CCSprite * spriteImage1 = [CCSprite spriteWithSpriteFrameName:sprite];
    CCSprite * spriteImage2 = [CCSprite spriteWithSpriteFrameName:sprite];
    [spriteShield setNormalImage: spriteImage1];
    [spriteShield setSelectedImage: spriteImage2];
}

-(void) dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}

@end
