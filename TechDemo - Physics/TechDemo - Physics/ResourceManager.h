//
//  ResourceManager.h
//  L'Archer
//
//  Created by jp on 17/04/13.
//
//

#import <Foundation/Foundation.h>
#import "Stimulus.h"

@interface ResourceManager : NSObject
{
    unsigned int skillPoints;
    unsigned int gold;
    unsigned int arrows;
    double mana;
    
    // Other things may not be as useful to be here but could be.
    // They are not resources, just numbers
    // - number of enemies
    // - number of enemies killed
    // - accuracy
    // - wall health
}

@property unsigned int skillPoints;
@property unsigned int gold;
@property unsigned int arrows;
@property double mana;

-(void) addSkillPoints:(unsigned int) add;
-(void) addGold:(unsigned int) add;
-(void) addArrows:(unsigned int) add;
-(void) addMana:(double) add;

-(BOOL) spendSkillPoints:(unsigned int) spend;
-(BOOL) spendGold:(unsigned int) spend;
-(BOOL) spendArrows:(unsigned int) spend;
-(BOOL) spendMana:(double) spend;


+(ResourceManager*)shared;

@end
