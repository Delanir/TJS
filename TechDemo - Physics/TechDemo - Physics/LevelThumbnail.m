//
//  LevelThumbnail.m
//  L'Archer
//
//  Created by João Amaral on 20/4/13.
//
//

#import "LevelThumbnail.h"
#import "LevelLayer.h"


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
  [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0 scene:[LevelLayer scene] withColor:ccWHITE]];
  
  
}
@end
