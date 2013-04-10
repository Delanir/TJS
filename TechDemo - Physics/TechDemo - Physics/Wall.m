//
//  Wall.m
//  L'Archer
//
//  Created by João Amaral on 10/4/13.
//
//

#import "Wall.h"

@implementation Wall

- (id) initWithSpriteFromFile:(NSString *)spriteFile andWindowSize:(CGSize) winSize
{
  if( (self=[super init])) {
    [self initWithSpriteFromFile:spriteFile];
  }
  
}
@end
