//
//  AchievementNode.h
//  L'Archer
//
//  Created by João Amaral on 3/5/13.
//
//

#import "CCNode.h"

@interface AchievementNode : CCNode
{
    CCMenuItemImage *spriteIcon;
    CCSprite *spriteShield;
    CCLabelTTF *lblTitle;
    CCLabelTTF *lblDescription;
}

@end
