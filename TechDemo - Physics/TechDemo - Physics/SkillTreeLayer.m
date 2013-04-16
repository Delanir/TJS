//
//  SkillTreeLayer.m
//  L'Archer
//
//  Created by MiniclipMacBook on 4/16/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "SkillTreeLayer.h"


@implementation SkillTreeLayer

-(void)onEnter
{
    [super onEnter];
    [_cityMainBranch setVisible:NO];
//    [_cityMainBranch setZOrder:15];
    [_cityElement2 setVisible:NO];
//    [_cityElement2 setZOrder:4];
    [_cityElement1 setVisible:NO];
//    [_cityElement1 setZOrder:5];
    [_cityElement3 setVisible:NO];
//    [_cityElement3 setZOrder:2];
    [_cityBranch3 setVisible:NO];
//    [_cityBranch3 setZOrder:12];
    [_cityBranch2 setVisible:NO];
//    [_cityBranch2 setZOrder:13];
    [_cityBranch1 setVisible:NO];
//    [_cityBranch1 setZOrder:14];
}

- (void) pressedCitySymbol:(id)sender{
    [_cityMainBranch setVisible:YES];
    [_cityElement2 setVisible:YES];
    [_cityElement1 setVisible:YES];
    [_cityElement3 setVisible:YES];
    [_cityBranch3 setVisible:YES];
    [_cityBranch2 setVisible:YES];
    [_cityBranch1 setVisible:YES];
}

@end
