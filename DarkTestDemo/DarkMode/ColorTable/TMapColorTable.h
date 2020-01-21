//
//  TMapColorTable.h
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NSString TMThemeName;//

typedef UIColor *(^TMColorPicker)(TMThemeName *themeName);

#define TMapColorWithKey(key) [[TMapColorTable sharedColorTable] colorWithKey:@#key]

/**
*  TMapColorTable is a new feature in 2.x, which providing you a very convinient and
*  delightful approach to manage all your color in an iOS project. Besides that, we
*  support multiple themes with TMapColorTable, change your `TMapColorTable.txt` file
*  like this:
*
*  Ex: color can be RGB RGBA(A using hex)
*
*      NORMAL   NIGHT   RED
*      #ffffff  #343434 #ff0000 BG
*      #aaaaaa  #313131 #ff0000 SEP
*
*  And you can directly change `[TMapDarkVersionManager sharedManager].theme` to
*  what you want, like: `RED` `TMapThemeNormal` and `TMapThemeNight`. And trigger to post notification
*  and update corresponding color.
*/
@interface TMapColorTable : NSObject
/**
 *  Call `- reloadColorTable` will trigger `TMapColorTable` to load this file,
 *  default is `TMapColorTable.txt`. Don't need to call `- reloadColorTable` after
 *  setting this property, cuz we have already do it for you.
 */
@property (nonatomic, strong) NSString *file;

/**
*  Return color table instance, you MUST use this method instead of `- init`,
*  `- init` method may have negative impact on your performance.
*
*  @return An instance of TMapColorTable
*/
+ (instancetype)shareColorTable;
/**
 *  Reload `file` into memory, and reconstrcut the whole color table. This method
 *  will clear color table and use current `file` to load color table again.
 */
- (void)reloadColorTable;

/**
 *  Return a `UIColor` with `key`, but I suggest you use marcho `TMapColorWithKey(key)`
 *  instead of calling this method.
 *
 *  Ex:
 *
 *      NORMAL   NIGHT
 *      #ffffff  #343434 BG
 *      #aaaaaa  #313131 SEP
 *
 *      self.view.backgroudColor = TMapColorWithKey(BG);
 *
 *  If current theme is TMapThemeNormal, view's background color will be set to #ffffff. When theme
 *  changes, it will automatically reload color from global color table and update current color
 *  again.
 *
 *  @param key Which indicates the entry you refer to
 *  @return UIColor
 */

- (TMColorPicker)colorWithKey:(NSString *)key;

@end

