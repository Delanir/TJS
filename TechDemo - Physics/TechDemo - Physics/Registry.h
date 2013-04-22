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
   
}

@property (retain) NSMutableDictionary * registry;
@property (nonatomic, retain)  CCLayer *lastScene;
+(Registry*)shared;

-(void) registerEntity: (id) entity withName: (NSString *) name;
-(id) getEntityByName: (NSString *) entityName;
-(void) clearRegistry;
-(void) printRegistry;


@end
