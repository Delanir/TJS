//
//  GameManager.h
//  L'Archer
//
//  Created by jp on 21/04/13.
//
//

#import <Foundation/Foundation.h>
#import "CCBReader.h"
#import "Constants.h"

@interface GameManager : NSObject

+(GameManager*)shared;
-(void)runSceneWithID:(SceneTypes)sceneID;
-(void)runLevel:(int)level;

@end
