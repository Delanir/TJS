//
//  EnemyFactory.m
//  TechDemo - Physics
//
//  Created by jp on 03/04/13.
//
//

#import "EnemyFactory.h"
#import "LevelLayer.h"
#import "Registry.h"

@implementation EnemyFactory

@synthesize enemyTypes, enemyChanceTotal;

static EnemyFactory* _sharedSingleton = nil;

+(EnemyFactory*)shared
{
	@synchronized([EnemyFactory class])
	{
		if (!_sharedSingleton)
			[[self alloc] init];
        
		return _sharedSingleton;
	}
    
	return nil;
}

+(id)alloc
{
	@synchronized([EnemyFactory class])
	{
		NSAssert(_sharedSingleton == nil, @"Attempted to allocate a second instance of a singleton.");
		_sharedSingleton = [super alloc];
		return _sharedSingleton;
	}
    
	return nil;
}

-(id)init
{
	if (self = [super init])
    {
        enemyChanceTotal = 0;
		enemyTypes = [[Config shared] getArrayProperty:@"existingEnemies"];
        for ( NSDictionary * enemy in enemyTypes)
        {
            NSNumber * chance = [enemy objectForKey:@"chance"];
            enemyChanceTotal += [chance floatValue];
        }
#ifdef kDebugMode
        [[Registry shared] addToCreatedEntities:self];
#endif
    }
	return self;
}





-(Enemy*)generateRandomEnemy
{
    LevelLayer * levellayer = [[Registry shared] getEntityByName:@"LevelLayer"];
    int level = [levellayer level];
    
    Enemy * newEnemy = nil;
    
    float low_bound = (level - 1) *  (enemyChanceTotal / 18);
    float high_bound = enemyChanceTotal / (11 - level);
    float randomSeed = (((float)arc4random()/0x100000000)*(high_bound-low_bound)+low_bound);
    
    float count = 0;
    
    for ( NSDictionary * enemy in enemyTypes)
    {
        NSNumber * chance = [enemy objectForKey:@"chance"];
        count += [chance floatValue];
        if (count > randomSeed)
        {
            CGSize winSize = [[CCDirector sharedDirector] winSize];
            
            float lb = winSize.height/6 + 80;
            float hb = ((5 * winSize.height) /6) - 80;
            float positionOfCreation = (((float)arc4random()/0x100000000)*(hb-lb)+lb);
            
            newEnemy = [self generateEnemyWithType:[enemy objectForKey:@"type"] vertical:positionOfCreation displacement:ccp(0,0) taunt:NO];
            break;
        }
    }
    return newEnemy;
}


-(Enemy*)generateEnemyWithType:(NSString*) type vertical:(int) vpos displacement:(CGPoint) disp taunt:(BOOL) isTaunt;
{
    Enemy * newEnemy = nil;
    //NSLog(@"Enemy: %@ Vert: %d Disp:(%f,%f)", type, vpos, disp.x, disp.y);
    
    for ( NSDictionary * enemy in enemyTypes)
    {
        NSString * enemyType = [enemy objectForKey:@"type"];
        if([type isEqualToString:enemyType])
        {
            NSString * className = [enemy objectForKey:@"class"];
            NSString * spriteFile = [enemy objectForKey:@"initSprite"];
            newEnemy = [NSClassFromString(className) alloc];
            [newEnemy initWithSprite:spriteFile initialState:kWalkEnemyState];
            
            // placement
            CGSize winSize = [[CCDirector sharedDirector] winSize];
            CGSize spriteSize = [[newEnemy sprite] contentSize];
            
            float x = winSize.width + (spriteSize.width/2) + (disp.x * spriteSize.width);
            float y = vpos + (disp.y * spriteSize.height);
            
            [newEnemy sprite].position = ccp(x,y);
            
            [newEnemy healthBar].position = ccp(x,y+spriteSize.width/2+2);
            [newEnemy healthBar].scaleX = [Utils iPadRetina]?6:3;
            [newEnemy healthBar].scaleY = [Utils iPadRetina]?1:0.5;
            
            if(isTaunt) [newEnemy setCurrentState:kTauntEnemyState];
            
            [newEnemy setupActions];
            [newEnemy setNormalAnimationSpeed: [newEnemy getCurrentSpeed]];
            [newEnemy autorelease];
            
            
            break;
        }
    }
    return newEnemy;
}

-(void)dealloc
{
#ifdef kDebugMode
    [[Registry shared] addToDestroyedEntities:self];
#endif
    [_sharedSingleton release];
    [super dealloc];
}

@end