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
    int totalCards;
    int currentCard;
}

@property (nonatomic, retain) StoryBoard * story;
@property (nonatomic, assign) int totalCards, currentCard;

-(void) nextCard;
-(id) initForLevel: (int) level;

@end
