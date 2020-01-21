//
//  TMapDarkVersionManager.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, TMapTheme) {
    TMapThemeNormal = 0, //normal theme
    TMapThemeNight = 1,  //night theme
};

///////////////////////////////////////////
////          夜间模式管理器
///////////////////////////////////////////
@interface TMapDarkVersionManager : NSObject

/**
 *  if `changeStatusBar` is set to `YES`, the status bar will change to `UIStatusBarStyleLightContent` when invoke `+ nightFalling` and `UIStatusBarStyleDefault` for `+ dawnComing`. if you would like to use `-[UIViewController preferredStatusBarStyle]`, set this value to `NO`. Default to `YES`
 */
@property (nonatomic, assign, getter=shouldChangeStatusBar) BOOL changeStatusBar;

/**
 *  Current theme, default is TMapThemeNormal, change it to change the global
 *  theme, this will handle HashTable to change the theme color or image
 *
 *  Ex:
 *
 *      ```objectivec
 *          DKNightVersionManager *manager = [DKNightVersionManager sharedManager];
 *          manager.theme = TMapThemeNight; // TMapThemeNormal or TMapThemeNight
 *      ```
 */
@property (nonatomic, assign) TMapTheme theme;
/**
 *  Support keyboard type changes when swiching to TMapThemeNight. If this value is YES,
 *  `keyboardType` for UITextField will change to `UIKeyboardAppearanceDark` only current theme
 *  version is TMapThemeNight.
 *  Default is YES.
 */
@property (nonatomic, assign) BOOL supportsKeyboard;

/**
*  using system interface style.
*  only support for iOS 13 or later version
*  Default is YES.
*/
@property (nonatomic, assign) BOOL systemInterfaceStyleEnable API_AVAILABLE(ios(13.0));

/**
*  Return the shared night version manager instance
*
*  @return singleton instance for TMapDarkVersionManager
*/
+ (instancetype)shareManager;

/**
 *  Night falling. When nightFalling is called, `themeVersion` of the manager will
 *  be set to `TMapThemeNight`. This is a convinient method for switching theme the
 *  `TMapThemeNight`.
 */
- (void)nightFalling;

/**
 *  Dawn coming. When dawnComing is called.
 *  `themeVersion` of the manager will
 *  be set to `TMapThemeNormal`. This is a convinient method for switching theme the
 *  `TMapThemeNormal`.
 */
- (void)dawnComing;


/**
*  View weak container.
*  When view call didMoveToSuperView add the view to hashTable
*  When theme changed. `themeVersion` of the manager will
*  be set to new theme. This is a convinient method for switching theme.
*
*/
- (void)addToHashTable:(__kindof NSObject *)view;

@end

NS_ASSUME_NONNULL_END
