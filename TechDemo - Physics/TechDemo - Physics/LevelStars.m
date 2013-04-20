//
//  LevelStars.m
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//

#import "LevelStars.h"

@implementation LevelStars

-(void) makeVisible:(int)numberOfStars{
  ccColor3B white=ccc3(255, 255, 255);
  ccColor3B black=ccc3(0, 0, 0);
  
  [_star1 setColor:black];
  [_star2 setColor:black];
  [_star3 setColor:black];
  switch (numberOfStars) {
    case 3:
      [_star3 setColor:white];
    case 2:
      [_star2 setColor:white];
    case 1:
      [_star1 setColor:white];
      break;
    default:
      break;
  }
  
}

@end
