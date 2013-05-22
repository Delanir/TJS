//
//  LevelStars.m
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//

#import "LevelStars.h"
#import "Registry.h"

@implementation LevelStars


-(id) init
{
    self = [super init];
#ifdef kDebugMode
    [[Registry shared] addToCreatedEntities:self];
#endif
    return self;
}

-(void) makeVisible:(int)numberOfStars
{
  switch (numberOfStars)
  {
    case 3:
      [_star3 setIsEnabled:YES];
    case 2:
      [_star2 setIsEnabled:YES];
    case 1:
      [_star1 setIsEnabled:YES];
      break;
    default:
      break;
  }
  
}

-(void) makeVisibleReverse:(int)numberOfStars{
    switch (numberOfStars)
    {
        case 3:
            [_star1 setIsEnabled:YES];
        case 2:
            [_star2 setIsEnabled:YES];
        case 1:
            [_star3 setIsEnabled:YES];
            break;
        default:
            break;
    }
    
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
