//
//  LevelStars.h
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCNode.h"
#import "CCBReader.h"

@interface LevelStars : CCNode{
  CCSprite *_star1;
  CCSprite *_star2;
  CCSprite *_star3;
}
-(void) makeVisible:(int)numberOfStars;
@end
