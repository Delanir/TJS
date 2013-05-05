//
//  AchievementsLayer.h
//  L'Archer
//
//  Created by João Amaral on 3/5/13.
//
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCBReader.h"
#import "CCLayer.h"
#import "AchievementNode.h"

@interface AchievementsLayer : CCLayer
{
    CCArray * Achievements;
    AchievementNode *_achievement1;
    AchievementNode *_achievement2;
    AchievementNode *_achievement3;
    AchievementNode *_achievement4;
    AchievementNode *_achievement5;
    AchievementNode *_achievement6;
    AchievementNode *_achievement7;
    AchievementNode *_achievement8;
    AchievementNode *_achievement9;
    AchievementNode *_achievement10;
    AchievementNode *_achievement11;
    AchievementNode *_achievement12;
    AchievementNode *_achievement13;
    AchievementNode *_achievement14;
    AchievementNode *_achievement15;
}


- (void) pressedGoToMainMenu:(id)sender;

@end
