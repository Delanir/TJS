//
//  LevelStars.m
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//

#import "LevelStars.h"

@implementation LevelStars

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

@end
