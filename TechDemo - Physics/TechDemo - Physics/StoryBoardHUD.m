//
//  AchievementUnlocked.m
//  L'Archer
//
//  Created by jp on 14/05/13.
//
//

#import "StoryBoardHUD.h"
#import "CCBAnimationManager.h"
#import "NSMutableArray+QueueAdditions.h"
#import "CCBReader.h"
#import "Utils.h"
#import "SpriteManager.h"
#import "Registry.h"


@implementation StoryBoardHUD

@synthesize story, totalCards, currentCard;

-(id) initForLevel: (int) level
{
    if ( self = [super init] )
    {
#ifdef kDebugMode
        [[Registry shared] addToCreatedEntities:self];
#endif
        story = (StoryBoard *) [CCBReader nodeGraphFromFile:@"StoryBoard.ccbi"];
        chapter = level;
        
        NSDictionary * storyInfo = [Utils openPlist:@"story"];
        NSArray* temp = [storyInfo objectForKey:[NSString stringWithFormat:@"chapter%d", level]];
        totalCards = 0;
        currentCard = 0;
        
        
        
        if (temp!=nil) {
            totalCards = [temp count];
            currentCard = 0;
            
            [story setInformation:currentCard inChapter:chapter];
        }
        
        [self addChild:story z:1000];
    }
    return self;
}


-(void) nextCard
{
    currentCard++;
    if (currentCard<totalCards)
        [story setInformation:currentCard inChapter:chapter];
    else
        [self setVisible:NO];
}


-(void) dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [super dealloc];
}

-(void)onExit
{
    [self removeAllChildrenWithCleanup:YES];
    [super onExit];
}



@end
