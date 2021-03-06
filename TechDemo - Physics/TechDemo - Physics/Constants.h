//
//  Constants.h
//  L'Archer
//
//  Created by jp on 22/04/13.
//
//

#ifndef L_Archer_Constants_h
#define L_Archer_Constants_h

#define kDebugMode 1

#define kFireManaCost 3
#define kIceManaCost 3
#define kPushbackManaCost 1

#define kManaRegenerationRate 0.02
#define kManaBaseRegenerationBonus 1.5
#define kManaExtraRegenerationBonus 2.0
#define kHealthBaseRegenerationBonus 0.016
#define kHealthExtraRegenerationBonus 0.032

//Base stats
#define kYuriBaseStrength 20                // base damage
#define kYuriBaseCritical 0.01              // base critical
#define kYuriPointsToLevel2 10
#define kYuriPointsToLevel3 20

//Power up base stats
#define kYuriBasePushbackDistance 32        // 20 pixels
#define kYuriBaseSlowDownDuration 1         // one second
#define kYuriBaseSlowDownPercentage 1.8       // times slower
#define kYuriBaseDamageOverTimeDuration 1.6   // one second
#define kYuriBaseDamageOverTimeDamage 16    // 30 points per second

//Base stat bonuses
#define kYuriBaseStrengthBonus 1.25
#define kYuriExtraStrengthBonus 1.5
#define kYuriBaseSpeedBonus 0.8
#define kYuriExtraSpeedBonus 0.6
#define kYuriBaseCriticalBonus 3
#define kYuriExtraCriticalBonus 6

//Power up stat bonuses
#define kYuriSlowDownDurationNoBonus 1.0
#define kYuriSlowDownPercentageNoBonus 1.0
#define kYuriDamageOverTimeDurationNoBonus 1.0
#define kYuriDamageOverTimeDamageNoBonus 1.0
#define kYuriSlowDownDurationBaseBonus 1.4
#define kYuriSlowDownPercentageBaseBonus 1.4
#define kYuriSlowDownDamageMultiplier 3
#define kYuriDamageOverTimeDurationBaseBonus 1.5
#define kYuriDamageOverTimeDamageBaseBonus 1.4
#define kYuriSlowDownDurationExtraBonus 1.8
#define kYuriSlowDownPercentageExtraBonus 1.8
#define kYuriDamageOverTimeDurationExtraBonus 2.0
#define kYuriDamageOverTimeDamageExtraBonus 1.8
#define kYuriNoAreaOfEffect 0
#define kYuriBaseAreaOfEffect 70
#define kYuriExtraAreaOfEffect 140
#define kYuriNoChainTargets 0
#define kYuriOneChainTarget 1
#define kYuriTwoChainTargets 2
#define kYuriNoFreezePercentage 0
#define kYuriBaseFreezePercentage 0.1
#define kYuriExtraFreezePercentage 0.2

#define kMaxRange 500
#define kAcceptableNumberOfArrows 10

#define STARCOST1 1
#define STARCOST2 2
#define STARCOST3 3
#define DEFAULTSKILLPOINTS 6

#define BUYARROWSCOST 5
#define BUYARROWGAIN 10

#define WALLREPAIRCOST 150
#define WALLREPAIRPERCENTAGE 0.25

#define kDamageBaseVulnerability 1.0
#define kFireBaseVulnerability 1.0
#define kIceBaseVulnerability 1.0
#define kPushbackBaseVulnerability 1.0

#define kMoatNoDamage 0
#define kMoatOneTimeDamage 1
#define kMoatOneTimeDamagePercentage 0.2
#define kMoatOneTimeDamageInstaKillChance 2
#define kInstaKillChance 12

#define kEnemySpeedMultiplier 9

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
    kTauntEnemyState,
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
    kMarksmanBranch1 = 27,
    kMarksmanBranch2 = 26,
    kMarksmanBranch3 = 25,
    kMarksmanElement1 = 23,
    kMarksmanElement2 = 22,
    kMarksmanElement3 = 24
}
skillTreeType;



#endif
