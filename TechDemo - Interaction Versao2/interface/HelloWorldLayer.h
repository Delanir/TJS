//
//  HelloWorldLayer.h
//  interface
//
//  Created by Ricardo on 3/18/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    CCSprite *bow;
    CCSprite * background;
    CCLabelTTF *shootingModeLabel;
    CCLabelTTF *fireRateLabel;
    short int shootRate;
    unsigned long int numArrows;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

//My Functions

-(void) changeShootMode:(id)sender;

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

-(void) shootSwipe;



@end
