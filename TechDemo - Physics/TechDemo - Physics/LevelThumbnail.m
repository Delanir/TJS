//
//  LevelThumbnail.m
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//

#import "LevelThumbnail.h"
#import "LevelLayer.h"
#import "GameManager.h"


@implementation LevelThumbnail
@synthesize isEnabled,numberStars,level;


-(void)initLevel{
  #warning TODO @"level1.plist"
  
  [_thumbnail setIsEnabled:isEnabled];
  [_stars makeVisible:numberStars];
  
}

- (void) goToLevel:(id)sender{
  //NSString *abc =[NSString string]
//  CCLOG(@"pressed %d", numberStars)
#warning temporário
    [[GameManager shared] runSceneWithID:kGameLevel];
  
  
}
@end
