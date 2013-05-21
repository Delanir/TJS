//
//  Registry.h
//  L'Archer
//
//  Created by jp on 17/04/13.
//
//

#import <Foundation/Foundation.h>
#import "Stimulus.h"

@interface Registry : NSObject
{
    NSMutableDictionary * registry;
    NSMutableArray * allEntities;
    unsigned int numberOfCreatedEntities;
    unsigned int numberOfDestroyedEntities;
}

@property (retain) NSMutableDictionary * registry;
@property (retain) NSMutableArray * allEntities;
@property (nonatomic, retain)  CCLayer *lastScene;
@property unsigned int numberOfCreatedEntities, numberOfDestroyedEntities;
+(Registry*)shared;

-(void) registerEntity: (id) entity withName: (NSString *) name;
-(id) getEntityByName: (NSString *) entityName;
-(void) removeEntityFromRegistry: (NSString*) entity;
-(void) clearRegistry;
-(void) printRegistry;

// Debugging purposes
-(void) addToCreatedEntities: (id) entity;
-(void) addToDestroyedEntities: (id) entity;
-(int) numberOfExistingEntities;
-(void) printAllExistingEntities;


@end
