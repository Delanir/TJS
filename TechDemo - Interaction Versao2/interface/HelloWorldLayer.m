//
//  HelloWorldLayer.m
//  interface
//
//  Created by Ricardo on 3/18/13.
//  Copyright __MyCompanyName__ 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

CCSprite *arrow;
CGPoint firstTouch;
CGPoint lastTouch;
int mode = 0;

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

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        shootRate = 1;
        numArrows = 0;
        
        // ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
        background = [CCSprite spriteWithFile:@"Background.png"];
        background.position = ccp(size.width/2,size.height/2);
        [self addChild:background z:0];
        
        //Arrow Sprite and position
        arrow = [CCSprite spriteWithFile:@"yurie.png"];
        arrow.position = ccp(arrow.contentSize.width/2, size.height/2);
        [self addChild:arrow];
        
        //Bow Sprite and position
        bow = [CCSprite spriteWithFile:@"bow.png"];
        bow.position = ccp(bow.contentSize.width/2, size.height/2);
        [self addChild:bow];
        
        [self setIsTouchEnabled:YES];
  
        //Shooting Menu Stuff
        CCSprite *shootingMode = [CCSprite spriteWithFile:@"ShootingMode.png"];
        CCMenuItem *starMenuItem = [CCMenuItemImage
                                    itemFromNormalImage:@"ShootingMode.png" selectedImage:@"ShootingMode.png"
                                    target:self selector:@selector(changeShootMode:)];
        starMenuItem.position = ccp(size.width/2, size.height - shootingMode.contentSize.height/2);
        CCMenu *starMenu = [CCMenu menuWithItems:starMenuItem, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
    
        //Label Stuff
        shootingModeLabel = [CCLabelTTF labelWithString:@"Normal Shoot" fontName:@"Arial" fontSize:24];
        shootingModeLabel.position = ccp(size.width/2 + 150, size.height - shootingMode.contentSize.height/2);
        [self addChild:shootingModeLabel];
     
        //Fire Rate Label
        fireRateLabel = [CCLabelTTF labelWithString:@"Shoot speed = 1" fontName:@"Arial" fontSize:24];
        fireRateLabel.position = ccp(size.width/2, fireRateLabel.contentSize.height/2);
        [self addChild:fireRateLabel];
        
        //Minus Menu Stuff
        CCSprite *minusSinal = [CCSprite spriteWithFile:@"minusButton.png"];
        CCMenuItem *minusMenuItem = [CCMenuItemImage
                                     itemFromNormalImage:@"minusButton.png" selectedImage:@"minusButton.png"
                                     target:self selector:@selector(minusShoot:)];
        minusMenuItem.position = ccp(size.width/2 - (minusSinal.contentSize.height + fireRateLabel.contentSize.height + 100), minusSinal.contentSize.height/2);
        CCMenu *minusMenu = [CCMenu menuWithItems:minusMenuItem, nil];
        minusMenu.position = CGPointZero;
        [self addChild:minusMenu];
        
        //Plus Menu Stuff
        CCSprite *plusSinal = [CCSprite spriteWithFile:@"plusButton.png"];
        CCMenuItem *plusMenuItem = [CCMenuItemImage
                                    itemFromNormalImage:@"plusButton.png" selectedImage:@"plusButton.png"
                                    target:self selector:@selector(plusShoot:)];
        plusMenuItem.position = ccp(size.width/2 + plusSinal.contentSize.height + fireRateLabel.contentSize.height + 100, plusSinal.contentSize.height/2);
        CCMenu *plusMenu = [CCMenu menuWithItems:plusMenuItem, nil];
        plusMenu.position = CGPointZero;
        [self addChild:plusMenu];
        
	}
	return self;
}

- (void)changeShootMode:(id)sender {
    if (mode == 0) {
        mode = 1;
        [shootingModeLabel setString:@"Rope Shoot"];
    } else if (mode == 1) {
        mode = 2;
        [shootingModeLabel setString:@"Volley Shoot"];
    } else {
        mode = 0;
        [shootingModeLabel setString:@"Normal Shoot"];
    }
}

- (void) minusShoot:(id)sender {
    if (shootRate > 1) {
        shootRate--;
        [fireRateLabel setString:[NSString stringWithFormat:@"Shoot speed = %d", shootRate]];
    }
}

- (void) plusShoot:(id)sender {
    shootRate++;
    [fireRateLabel setString:[NSString stringWithFormat:@"Shoot speed = %d", shootRate]];
}

#pragma mark Shoot Arrows

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSSet *allTouches = [event allTouches];
    UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    //Swipe Detection Part 1
    firstTouch = location;
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Salva de Setas ||
    if (mode == 2) {
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView: [touch view]];
        point = [[CCDirector sharedDirector] convertToGL:point];
        
        //Set up initial location of projectile
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *projectile = [CCSprite spriteWithFile:@"arrow.png"];
        projectile.position = ccp(bow.contentSize.width/2,winSize.height/2);
        
        //Determine offset of location to projectile
        CGPoint offSet = ccpSub(point, projectile.position);
        
        //Bail out if you are shooting down or backwards
        if (offSet.x <= 0) return;
        
        //Ok to add now - we've double checked position
        if ((numArrows % shootRate) == 0) {
            [self addChild:projectile];
            numArrows++;
        } else {
            numArrows++;
            return;
        }
        
        int realX = winSize.width + (projectile.contentSize.width/2);
        float ratio = (float) offSet.y / (float) offSet.x;
        int realY = (realX * ratio) + projectile.position.y;
        CGPoint realDest = ccp(realX,realY);
        
        // Determine the length of how far you're shooting
        int offRealX = realX - projectile.position.x;
        int offRealY = realY - projectile.position.y;
        float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
        float velocity = 480/1; // 480pixels/1sec
        float realMoveDuration = length/velocity;
        
        float angleRadians = atanf((float)offRealY / (float)offRealX);
        float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
        float cocosAngle = -1 * angleDegrees;
        projectile.rotation = cocosAngle;
        bow.rotation = cocosAngle;
        
        // Move projectile to actual endpoint
        [projectile runAction:
         [CCSequence actions:
          [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
          [CCCallBlockN actionWithBlock:^(CCNode *node) {
             [node removeFromParentAndCleanup:YES];
         }],
          nil]];
    }
    
    if (mode == 1) {
        
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView: [touch view]];
        point = [[CCDirector sharedDirector] convertToGL:point];
        
        //Set up initial location of projectile
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *projectile = [CCSprite spriteWithFile:@"arrow.png"];
        projectile.position = ccp(0,winSize.height/2);
        
        //Determine offset of location to projectile
        CGPoint offSet = ccpSub(point, projectile.position);
        
        //Bail out if you are shooting down or backwards
        if (offSet.x <= 0) return;
        
        int realX = winSize.width + (projectile.contentSize.width/2);
        float ratio = (float) offSet.y / (float) offSet.x;
        int realY = (realX * ratio) + projectile.position.y;
        
        // Determine the length of how far you're shooting
        int offRealX = realX - projectile.position.x;
        int offRealY = realY - projectile.position.y;
        
        float angleRadians = atanf((float)offRealY / (float)offRealX);
        float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
        float cocosAngle = -1 * angleDegrees;
        bow.rotation = -cocosAngle;
        
        
    }
}

-(void) ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (mode == 0) {
        
        //Choose one ofthe touches to work with
        UITouch *touch = [touches anyObject];
        CGPoint location = [self convertTouchToNodeSpace:touch];
        
        //Set up initial location of projectile
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *projectile = [CCSprite spriteWithFile:@"arrow.png"];
        projectile.position = ccp(bow.contentSize.width/2,winSize.height/2);
        
        //Determine offset of location to projectile
        CGPoint offSet = ccpSub(location, projectile.position);
        
        //Bail out if you are shooting down or backwards
        if (offSet.x <= 0) return;
        
        //Ok to add now - we've double checked position
        [self addChild:projectile];
        
        int realX = winSize.width + (projectile.contentSize.width/2);
        float ratio = (float) offSet.y / (float) offSet.x;
        int realY = (realX * ratio) + projectile.position.y;
        CGPoint realDest = ccp(realX,realY);
        
        // Determine the length of how far you're shooting
        int offRealX = realX - projectile.position.x;
        int offRealY = realY - projectile.position.y;
        float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
        float velocity = 480/1; // 480pixels/1sec
        float realMoveDuration = length/velocity;
        
        float angleRadians = atanf((float)offRealY / (float)offRealX);
        float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
        float cocosAngle = -1 * angleDegrees;
        projectile.rotation = cocosAngle;
        bow.rotation = cocosAngle;
        
        // Move projectile to actual endpoint
        [projectile runAction:
         [CCSequence actions:
          [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
          [CCCallBlockN actionWithBlock:^(CCNode *node) {
             [node removeFromParentAndCleanup:YES];
         }],
          nil]];
        
    } else {
        
        NSSet *allTouches = [event allTouches];
        UITouch * touch = [[allTouches allObjects] objectAtIndex:0];
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        
        //Swipe Detection Part 2
        lastTouch = location;
        
        //Minimum length of the swipe
        float swipeLength = ccpDistance(firstTouch, lastTouch);
        
        //Check if the swipe is a left swipe and long enough
        if (firstTouch.x > lastTouch.x && swipeLength > 45) {
            [self shootSwipe];
        }
    }
}

-(void) shootSwipe
{
    
    //Set up initial location of projectile
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    CCSprite *projectile = [CCSprite spriteWithFile:@"arrow.png"];
    projectile.position = ccp(bow.contentSize.width/2,winSize.height/2);
    
    [self addChild:projectile];
    
    CGPoint offSet = ccpSub(lastTouch, firstTouch);
    
    //Tamanho da janela mais do projectil
    int realX = winSize.width + (projectile.contentSize.width/2);
    float ratio = (float) offSet.y / (float) offSet.x;
    int realY = (realX * ratio) + projectile.position.y;
    CGPoint realDest = ccp(realX,realY);
    
    // Determine the length of how far you're shooting
    int offRealX = realX - projectile.position.x;
    int offRealY = realY - projectile.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    float angleRadians = atanf((float)offRealY / (float)offRealX);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    float cocosAngle = -1 * angleDegrees;
    projectile.rotation = cocosAngle;
    bow.rotation = cocosAngle;
    
    // Move projectile to actual endpoint
    [projectile runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
         [node removeFromParentAndCleanup:YES];
     }],
      nil]];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
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
