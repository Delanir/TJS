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

-(void) setImage
{
    //spriteWithSpriteFrameName
    NSLog(@"SetImage");
    spriteShield = [CCSprite spriteWithFile:@"achievements_skull.png"];
}

@end
