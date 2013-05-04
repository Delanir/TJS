//
//  Constants.h
//  L'Archer
//
//  Created by jp on 22/04/13.
//
//

#ifndef L_Archer_Constants_h
#define L_Archer_Constants_h

#define kManaRegenerationRate 0.02

#define kYuriBaseStrength 25                // base damage
#define kYuriBasePushbackDistance 20        // 20 pixels
#define kYuriBaseSlowDownDuration 1         // one second
#define kYuriBaseSlowDownPercentage 2       // twice slower
#define kYuriBaseDamageOverTimeDuration 1   // one second
#define kYuriBaseDamageOverTimeDamage 30    // 30 points per second

typedef enum
{
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
}
SceneTypes;


typedef enum
{
    kPower1Button,
    kPower2Button,
    kPower3Button
}
powerButton;


typedef enum
{
    kMintWall,
    kScratchedWall,
    kDamagedWall,
    kWreckedWall,
    kTotaledWall
}
wallStatus;


typedef enum
{
    kWalkEnemyState,
    kAttackEnemyState,
    kFlyEnemyState,
    kLandEnemyState,
    kHitEnemyState,
    kDieEnemyState
}
state;


typedef enum
{
    kIceParticle,
    kAirParticle,
    kFireParticle
}
particleType;


typedef enum
{
    KPushBackStimulus,
    kSlowStimulus,
    kDOTStimulus,
    kDamageStimulus
}
stimulusType;


typedef enum
{
    kIceMainBranch = 0,
    kCityMainBranch = 7,
    kFireMainBranch = 14,
    kMarksmanMainBranch = 21,
    kIceBranch1 = 6,
    kIceBranch2 = 5,
    kIceBranch3 = 4,
    kIceElement1 = 2,
    kIceElement2 = 1,
    kIceElement3 = 3,
    kCityBranch1 = 13,
    kCityBranch2 = 12,
    kCityBranch3 = 11,
    kCityElement1 = 9,
    kCityElement2 = 8,
    kCityElement3 = 10,
    kFireBranch1 = 20,
    kFireBranch2 = 19,
    kFireBranch3 = 18,
    kFireElement1 = 16,
    kFireElement2 = 15,
    kFireElement3 = 17,
    kMarksmanBranch1 = 23,
    kMarksmanBranch2 = 22,
    kMarksmanBranch3 = 24,
    kMarksmanElement1 = 27,
    kMarksmanElement2 = 26,
    kMarksmanElement3 = 25
}
skillTreeType;



#endif
