//
//  StoryBoard.h
//  L'Archer
//
//  Created by jp on 14/05/13.
//
//

#import "StoryBoard.h"

@interface StoryBoardHUD : CCNode
{
    StoryBoard * story;
    int chapter;
    unsigned long totalCards;
    int currentCard;
}

@property (nonatomic, retain) StoryBoard * story;
@property (nonatomic, assign) unsigned long totalCards;
@property (nonatomic, assign) int currentCard;

-(void) nextCard;
-(id) initForLevel: (int) level;

@end
