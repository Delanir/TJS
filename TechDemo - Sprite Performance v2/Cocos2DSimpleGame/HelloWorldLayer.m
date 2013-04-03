//
//  HelloWorldLayer.m
//  Cocos2DSimpleGame
//
//  Created by Ray Wenderlich on 11/13/12.
//  Copyright Razeware LLC 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
#import "GameOverLayer.h"

#import "CCMenu_CCMenu_Slider.h"
#import "CCMenuItemSlider.h"

//Audio

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    HelloWorldLayer *layer = [HelloWorldLayer node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

- (void) addMonster: (CGPoint) location {
    CCSprite * monster = [CCSprite spriteWithFile:@"monster.png"];
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array ];
    for (int i=1; i<8; ++i) {
        [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Land0%d.png", i ]]];
    }
    
    CCAnimation * walkAnim =[CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.1f];
    
    //[CCAnimation animationWithAnimationFrames:walkAnimFrames delayPerUnit:0.1 loops:1];
    monster = [CCSprite spriteWithSpriteFrameName:@"Land01.png"];
    CCAction *walkAction = [CCRepeatForever actionWithAction:
                            [CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
    [monster runAction:walkAction];
    [self addChild:monster];
    
    // Determine where to spawn the monster along the Y axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = location;
    //[self addChild:monster];
    monster.flipX=YES;
    
    // Determine speed of the monster
    int minDuration = 20.0;
    int maxDuration = 40.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMoveR = [CCMoveTo actionWithDuration:actualDuration position:ccp(-monster.contentSize.width/2, location.y)];
    
    CCMoveTo * actionMoveL = [CCMoveTo actionWithDuration:actualDuration position:ccp(winSize.width+monster.contentSize.width/2, location.y)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [_monsters removeObject:node];
        [node removeFromParentAndCleanup:YES];
        
        //CCScene *gameOverScene = [GameOverLayer sceneWithWon:NO];
        //[[CCDirector sharedDirector] replaceScene:gameOverScene];
    }];
    CCCallBlockN * flip = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        ((CCSprite *)node).flipX=YES;
        
    }];
    [monster runAction:[CCSequence actions:actionMoveR, flip, actionMoveL, actionMoveDone, nil]];
    
    monster.tag = 1;
    // z ordering para os ursos nao andarem a cavalgar uns nos outros
    [self reorderChild: monster z: winSize.height - monster.position.y];
    [_monsters addObject:monster];
    
    
}

- (void) addMonster {
    
    CCSprite * monster = [CCSprite spriteWithFile:@"monster.png"];
    
           

    //[CCAnimation animationWithAnimationFrames:walkAnimFrames delayPerUnit:0.1 loops:1];
    monster = [CCSprite spriteWithSpriteFrameName:@"Fly01.png"];
    CCAction *walkAction = [CCRepeatForever actionWithAction:
                       [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"fly" ] restoreOriginalFrame:NO]];
    
    CCFiniteTimeAction *landAction = [CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"land" ] restoreOriginalFrame:NO];
    CCRepeat *repeatAction = [CCRepeat actionWithAction:landAction times:1];
    
                            //[CCAnimate actionWithAnimation:[[CCAnimationCache sharedAnimationCache] animationByName:@"land" ] restoreOriginalFrame:NO]];
    
    [monster runAction:walkAction];
    [self addChild:monster];
    
    // Determine where to spawn the monster along the Y axis
    CGSize winSize = [CCDirector sharedDirector].winSize;
    int minY = monster.contentSize.height / 2+winSize.height/10;
    int maxY = winSize.height - monster.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    // Create the monster slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    monster.position = ccp(winSize.width + monster.contentSize.width/2, actualY);
    //[self addChild:monster];
    monster.flipX=YES;
    // Determine speed of the monster
    int minDuration = 20.0;
    int maxDuration = 40.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    CCMoveTo * actionMoveR = [CCMoveTo actionWithDuration:actualDuration position:ccp(winSize.width/4+200, actualY)];
    
    //CCMoveTo * actionMoveL = [CCMoveTo actionWithDuration:actualDuration position:ccp(winSize.width+monster.contentSize.width/2, actualY)];
    CCCallBlockN * actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [_monsters removeObject:node];
        [node removeFromParentAndCleanup:YES];
        
        //CCScene *gameOverScene = [GameOverLayer sceneWithWon:NO];
        //[[CCDirector sharedDirector] replaceScene:gameOverScene];
    }];
    CCCallBlockN * flip = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [((CCSprite *)node) stopAction:walkAction];
        [((CCSprite *)node) runAction:repeatAction];
        
    }];
    CCCallBlockN * die = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        ((CCSprite *)node).flipY=YES;
        //[[SimpleAudioEngine sharedEngine] playEffect:@"leMIAUdamiens.caf"];
        
    }];
    [monster runAction:[CCSequence actions:actionMoveR, flip, [CCDelayTime actionWithDuration:1.5],die,[CCDelayTime actionWithDuration:.5] , actionMoveDone, nil]];
    
    monster.tag = 1;
    // z ordering para os ursos nao andarem a cavalgar uns nos outros
    [self reorderChild: monster z: winSize.height - monster.position.y];
    [_monsters addObject:monster];
    
}

-(void)gameLogic:(ccTime)dt {
    [self addMonster];
}

-(void)addAnimationsWithDictionary:(NSDictionary *)dictionary
{
    NSDictionary *animations = dictionary;
    
    if ( animations == nil ) {
        CCLOG(@"ISCCAnimationCacheExtensions: No animations found in provided dictionary.");
        return;
    }
    
    NSArray* animationNames = [animations allKeys];
    
    for( NSString *name in animationNames ) {
        NSDictionary* animationDict = [animations objectForKey:name];
        NSArray *frameNames = [animationDict objectForKey:@"frames"];
        NSNumber *delay = [animationDict objectForKey:@"delay"];
        CCAnimation* animation = nil;
        
        if ( frameNames == nil ) {
            CCLOG(@"ISCCAnimationCacheExtensions: Animation '%@' found in dictionary without any frames - cannot add to animation cache.", name);
            continue;
        }
        
        NSMutableArray *frames = [NSMutableArray arrayWithCapacity:[frameNames count]];
        
        for( NSString *frameName in frameNames ) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:frameName];
            CCLOG(@"ISCCAnimationCacheExtensions: Animation '%@' refers to frame '%@' which is not currently in the CCSpriteFrameCache. This frame will not be added to the animation.", name, frameName);
            
            if ( frame != nil ) {
                [frames addObject:frame];
            }
        }
        
        if ( [frames count] == 0 ) {
            CCLOG(@"ISCCAnimationCacheExtensions: None of the frames for animation '%@' were found in the CCSpriteFrameCache. Animation is not being added to the AnimationCache.", name);
            continue;
        } else if ( [frames count] != [frameNames count] ) {
            CCLOG(@"ISCCAnimationCacheExtensions: An animation in your dictionary refers to a frame which is not in the CCSpriteFrameCache. Some or all of the frames for the animation '%@' may be missing.", name);
        }
        
        if ( delay != nil ) {
            animation = [CCAnimation animationWithFrames:frames delay:[delay floatValue]];
        } else {
            animation = [CCAnimation animationWithFrames:frames];
        }
        
        [[CCAnimationCache sharedAnimationCache] addAnimation:animation name:name];
    }
}
 
- (id) init
{
    if ((self = [super initWithColor:ccc4(255,255,255,255)])) {

        CGSize winSize = [CCDirector sharedDirector].winSize;
        //CCSprite *player = [CCSprite spriteWithFile:@"player.png"];
        //player.position = ccp(player.contentSize.width/2, winSize.height/2);
        //[self addChild:player];
        
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"fairiedragon.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"fairiedragon.png"];
        [self addChild:spriteSheet];
        
        NSMutableArray *walkAnimFrames = [NSMutableArray array ];
        for (int i=1; i<8; ++i) {
            [walkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Land0%d.png", i ]]];
        }
        
        CCAnimation * walkAnim =[CCAnimation animationWithSpriteFrames:walkAnimFrames delay:0.1f];
        
        [[CCAnimationCache sharedAnimationCache] addAnimation:walkAnim name:@"walkAnim"];
        
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *finalPath = [path stringByAppendingPathComponent:@"fairiedragon_anim.plist"];
        
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:finalPath];
        [self addAnimationsWithDictionary:dict];
        
        [self schedule:@selector(gameLogic:) interval:1.0];
    
        [self setTouchEnabled:YES];
        
        CCSprite * bg= [CCSprite spriteWithFile:@"photo 1.JPG"];
        [bg setPosition:ccp(winSize.width/2, winSize.height/2)];
        [self addChild:bg z:0];
        
        
        
        //slider.position=ccp(winSize.width/2, winSize.height/12);
        
        //menu_ = [CCMenu menuWithItems:slider, nil];
       
        
        //[self addChild:menu_];
        
        
        
        _monsters = [[NSMutableArray alloc] init];
        //_projectiles = [[NSMutableArray alloc] init];

        [self schedule:@selector(update:)];
        
        //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
       
       // [CCSpriteBatchNode b
        
        
        
        //Plus Menu Stuff
        CCSprite *plusSinal = [CCSprite spriteWithFile:@"plusButton.png"];
        CCMenuItem *plusMenuItem = [CCMenuItemImage
                                    itemFromNormalImage:@"plusButton.png" selectedImage:@"plusButton.png"
                                    target:self selector:@selector(plusShoot:)];
        plusMenuItem.position = ccp(winSize.width/2 , plusSinal.contentSize.height );
        CCMenu *plusMenu = [CCMenu menuWithItems:plusMenuItem, nil];
        plusMenu.position = CGPointZero;
        [self addChild:plusMenu];
        
        label = [CCLabelTTF labelWithString:@"Number of Dragons: 0" fontName:@"Arial" fontSize:32];
        label.color = ccc3(0,0,0);
        label.position = ccp(winSize.width/2-250, winSize.height/11);
        label.zOrder= 9000;
        [self addChild:label];
        
        
    }
    return self;
}


- (void) plusShoot:(id)sender {
    for (int i=0; i<10; i++) {
        [self addMonster];
    }
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"leEVILBEARdamiens.caf"];
}



- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Choose one of the touches to work with
   // UITouch *touch = [touches anyObject];
    
    
    
   // CGPoint location = [self convertTouchToNodeSpace:touch];
   

    //[self addMonster:location];
    
}



- (void)update:(ccTime)dt {
    int a=[_monsters count];
    
    NSString * message;
    
    message = [NSString stringWithFormat:@"Number of Dragons: %d",a];
    
    label.string = message;
    label.color = ccc3(255,0,0);
    

}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
    [_monsters release];
    _monsters = nil;
//    [_projectiles release];
//    _projectiles = nil;
    [super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
    [[app navController] dismissModalViewControllerAnimated:YES];
}
@end
