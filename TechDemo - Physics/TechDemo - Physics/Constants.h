//
//  Constants.h
//  L'Archer
//
//  Created by jp on 22/04/13.
//
//

#ifndef L_Archer_Constants_h
#define L_Archer_Constants_h


typedef enum {
    kMasterScene=0,
    kMainMenuScene=1,
    kSkillTreeScene=2,
    kAchievementsScene=3,
    kLeaderboardScene=4,
    kSettingsScene=5,
    kSelectLevel=6,
    kGameLevel=7,
    kGameOverScene=8,
    kLevelCompleteScene=9,
    kCreditsScene=101,
} SceneTypes;


typedef enum {
    kPower1Button,
    kPower2Button,
    kPower3Button
} powerButton;


typedef enum {
    kMintWall,
    kScratchedWall,
    kDamagedWall,
    kWreckedWall,
    kTotaledWall
} wallStatus;


typedef enum {
    kWalkEnemyState,
    kAttackEnemyState,
    kFlyEnemyState,
    kLandEnemyState,
    kHitEnemyState,
    kDieEnemyState
} state;


typedef enum {
    kIceParticle,
    kAirParticle,
    kFireParticle
} particleType;


typedef enum {
    KPushBackStimulus,
    kSlowStimulus,
    kDOTStimulus,
    kDamageStimulus
} stimulusType;




#endif
