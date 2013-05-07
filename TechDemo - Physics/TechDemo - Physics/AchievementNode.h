//
//  AchievementNode.h
//  L'Archer
//
//  Created by João Amaral on 3/5/13.
//
//

#import "CCNode.h"
#import "Utils.h"

@interface AchievementNode : CCNode
{
    CCMenuItemImage *spriteIcon;
    CCMenuItemImage *spriteShield;
    CCLabelTTF *lblTitle;
    CCLabelTTF *lblDescription;
}

@property (nonatomic, assign) BOOL isEnabled;

-(void) initAchievement;
-(void) setInformation:(int) num;
-(void) setImage:(NSString *)sprite;
@end
