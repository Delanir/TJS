//
//  EnemyFactory.m
//  TechDemo - Physics
//
//  Created by jp on 03/04/13.
//
//

#import "EnemyFactory.h"
#import "Config.h"

@implementation EnemyFactory

@synthesize enemyTypes;

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

-(id)init {
	self = [super init];
	if (self != nil) {
		enemyTypes = [[Config shared] getArrayProperty:@"existingEnemies"];
    }
	return self;
}



-(Peasant*)generatePeasant
{
    Peasant *peasant = [[Peasant alloc] initWithSprite:@"p_walk01.png"];
    [peasant placeRandomly];
    [peasant setupActions];
    
    [peasant autorelease];
    
    return peasant;
    
}

-(FaerieDragon*)generateFaerieDragon
{
    FaerieDragon *faerieDragon = [[FaerieDragon alloc] initWithSprite:@"fd_fly01.png"];
    [faerieDragon placeRandomly];
    [faerieDragon setupActions];
    
    [faerieDragon autorelease];
    
    return faerieDragon;
    
}

-(Zealot*)generateZealot
{
    Zealot *zealot = [[Zealot alloc] initWithSprite:@"z_walk01.png"];
    [zealot placeRandomly];
    [zealot setupActions];
    
    [zealot autorelease];
    
    return zealot;
    
}

-(Enemy*)generateEnemyWithType:(NSString*) type vertical:(int) vpos displacement:(CGPoint) disp;
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
            [newEnemy initWithSprite:spriteFile];
            
            // placement
            CGSize winSize = [[CCDirector sharedDirector] winSize];
            CGSize spriteSize = [[newEnemy sprite] contentSize];
            
            float x = winSize.width + (spriteSize.width/2) + (disp.x * spriteSize.width);
            float y = vpos + (disp.y * spriteSize.height);
            
            [newEnemy sprite].position = ccp(x,y);
            
            [newEnemy healthBar].position = ccp(x,y+spriteSize.width/2+2);
            [newEnemy healthBar].scaleY = 1;
            [newEnemy healthBar].scaleX = 6;
            
            [newEnemy setupActions];
            [newEnemy autorelease];
            
            
            break;
        }
    }
    return newEnemy;
}

-(void)dealloc
{
    [_sharedSingleton release];
    [super dealloc];
}

@end