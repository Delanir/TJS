//
//  AchievementNode.m
//  L'Archer
//
//  Created by João Amaral on 3/5/13.
//
//

#import "AchievementNode.h"

@implementation AchievementNode
@synthesize isEnabled;

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
//    CCSprite * spriteImage1 = [CCSprite spriteWithSpriteFrameName:sprite];
//    CCTexture2D *texture = [[CCTextureCache sharedTextureCache] addImage:sprite];
//    spriteShield = [CCSprite spriteWithTexture:texture];
    
//    spriteShield = [CCSprite spriteWithSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"achievements_skull.png"]];

//    [spriteShield setTexture:[[CCTextureCache sharedTextureCache] addImage:@""]];
    NSLog(@"Change IMAGE");
//    [spriteShield: spriteImage1];
//    spriteWithSpriteFrameName
//    spriteShield = [CCSprite spriteWithFile:@"achievements_skull.png"];
}

@end
