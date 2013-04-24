//
//  LevelThumbnail.h
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "CCNode.h"
#import "CCBReader.h"
#import "LevelStars.h"


@interface LevelThumbnail : CCNode{
  CCMenuItemImage *_thumbnail;
  LevelStars *_stars;
  
}

@property (nonatomic, assign) BOOL  isEnabled;
@property (nonatomic, assign) int  numberStars;
@property (nonatomic, assign) int  level;


-(void) goToLevel:(id)sender;
-(void) initLevel;
-(void) setThumbnail:(NSString *) sprite;

@end
