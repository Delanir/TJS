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
{
    BOOL isMusicON;
    BOOL isSoundEffectsON;
    SceneTypes currentScene;
    NSMutableDictionary *ScenePointerDic;
}

@property BOOL isMusicON;
@property BOOL isSoundEffectsON;

+(GameManager*)shared;
-(void)runSceneWithID:(SceneTypes)sceneID;

@end
