//
//  TMapColorTable.m
//  DarkMode
//
//  Created by elwin on 2020/1/13.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import "TMapColorTable.h"
#import <UIKit/UIKit.h>

UIColor *TMColorFromRGB(NSUInteger hex) {
    return [UIColor colorWithRed:((CGFloat)((hex >> 16) & 0xFF)/255.0)
                           green:((CGFloat)((hex >> 8) & 0xFF)/255.0)
                            blue:((CGFloat)(hex & 0xFF)/255.0)
                           alpha:1.0];
}

UIColor *TMColorFromRGBA(NSUInteger hex) {
    return [UIColor colorWithRed:((CGFloat)((hex >> 24) & 0xFF)/255.0)
                           green:((CGFloat)((hex >> 16) & 0xFF)/255.0)
                            blue:((CGFloat)((hex >> 8) & 0xFF)/255.0)
                           alpha:((CGFloat)(hex & 0xFF)/255.0)];
}

@interface NSString (Trimmingg)

@end

@implementation NSString (Trimmingg)

- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;

    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    
    for (; length > 0; length--) {
         //character in characterSet
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

@end


@interface TMapColorTable()
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableDictionary<NSString *, UIColor *> *> *table;
@property (nonatomic, strong, readwrite) NSArray<NSString *> *themes;
@end

@implementation TMapColorTable

+ (instancetype)shareColorTable {
    static TMapColorTable *sharedColorTable = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedColorTable = [[[self class] alloc] init];
        sharedColorTable.file = @"TMapColorTable.txt";
        [sharedColorTable reloadColorTable];
    });
    return sharedColorTable;
}

- (void)reloadColorTable {
    //clear previos color table
    self.table = nil;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:self.file.stringByDeletingPathExtension ofType:self.file.pathExtension];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"Error reading file:%@", error.localizedDescription);
    }
    
    NSMutableArray *tempEntries = [[fileContents componentsSeparatedByString:@"\n"] mutableCopy];
    // Fixed whitespace error in txt file, fix https://github.com/Draveness/DKNightVersion/issues/64
    
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    [tempEntries enumerateObjectsUsingBlock:^(NSString *  _Nonnull entry, NSUInteger idx, BOOL * _Nonnull stop) {
        //remove whiteSpace
        NSString *trimmingEntry = [entry stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [entries addObject:trimmingEntry];
    }];
    
    
    [entries filterUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
    [self createThemeWith:entries.firstObject];
    [entries removeObjectAtIndex:0];
   
  // Remove theme entry (head line）
    
     // self.themes = [self themesFromContents:fileContents];
     // Add entry to color table
     for (NSString *entry in entries) {
        [self colorsFromEntry:entry];
     }
}

- (void)createThemeWith:(NSString *)header {
    NSMutableArray *array = [[self separateString:header] mutableCopy];
    _themes = [array copy];
}

- (void)colorsFromEntry:(NSString *)entry {
    NSMutableArray *colors = [[self separateString:entry] mutableCopy];
    NSString *key = colors.lastObject;
    [colors removeLastObject];
    NSMutableDictionary<NSString *,UIColor *> *result =  [@{} mutableCopy];
    if (colors.count != _themes.count) {
        return;
    }
    
    for (int i = 0; i< colors.count; i++) {
        NSString *number = colors[i];
        UIColor *color = [self colorFromString:number];
        NSString *themeName = _themes[i];
        if (color && themeName.length > 0) {
             result[themeName] = color;
        }
    }
    
    [self.table setObject:result forKey:key];
}

//get theme entry (head line)
- (NSArray *)themesFromContents:(NSString *)content {
    NSString *rawThemes = [content componentsSeparatedByString:@"\n"].firstObject;
    return [self separateString:rawThemes];
}

- (NSArray *)separateString:(NSString *)string {
    //whiteSpace is the separated character
    NSArray *array = [string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return [array filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
}

- (TMColorPicker)colorWithKey:(NSString *)key {
    NSParameterAssert(key);
    //todo by elwinzhao
    NSDictionary *themeToColorDictionary = [self.table valueForKey:key];
    
    TMColorPicker picker = ^(TMThemeName *themeName) {
        return [themeToColorDictionary valueForKey:themeName];
    };
    return picker;
}
- (NSMutableDictionary *)table {
    if (!_table) {
        _table = [[NSMutableDictionary alloc] init];
    }
    return _table;
}

#pragma mark - Helper

- (UIColor *)colorFromString:(NSString*)hexStr {
    hexStr = [hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if([hexStr hasPrefix:@"0x"]) {
        hexStr = [hexStr substringFromIndex:2];
    }
    if([hexStr hasPrefix:@"#"]) {
        hexStr = [hexStr substringFromIndex:1];
    }

    NSUInteger hex = [self intFromHexString:hexStr];
    if(hexStr.length > 6) {
        return TMColorFromRGBA(hex);
    }

    return TMColorFromRGB(hex);
}

- (NSUInteger)intFromHexString:(NSString *)hexStr {
    unsigned int hexInt = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexStr];
    [scanner scanHexInt:&hexInt];
    return hexInt;
}


@end
