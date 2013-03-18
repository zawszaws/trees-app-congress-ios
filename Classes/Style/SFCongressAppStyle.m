//
//  SFCongressAppStyle.m
//  Congress
//
//  Created by Daniel Cloud on 3/6/13.
//  Copyright (c) 2013 Sunlight Foundation. All rights reserved.
//

#import "SFCongressAppStyle.h"

@implementation UIColor (SFCongressAppStyle)

static NSString * const SFCongressPrimaryBackgroundColor = @"FAFBEB";
static NSString * const SFCongressPrimaryTextColor = @"4b4b3f";
static NSString * const SFCongressLinkTextColor = @"d5bc5f";
static NSString * const SFCongresslinkHighlightedTextColor = @"c53f24";

static NSString * const SFCongressNavigationBarColor = @"70b6b7";
static NSString * const SFCongressNavigationBarTextColor = @"fcfcee";
static NSString * const SFCongressNavigationBarTextShadowColor = @"4c918f";

static NSString * const SFCongressMenuBackgroundColor = @"c64d22";
static NSString * const SFCongressMenuSelectionBgColor = @"b63c17";
static NSString * const SFCongressMenuTextColor = @"f2e1d1";
static NSString * const SFCongressMenuDividerBottomInsetColor = @"b63b19";
static NSString * const SFCongressMenuDividerBottomColor = @"d05b30";

static NSString * const SFCongressTableSeparatorColor = @"eeeed2";

static NSString * const SFCongressH1Color = @"434338";
static NSString * const SFCongressH2Color = @"67675d";

static CGFloat const SFCongressParagraphLineSpacing = 6.0f;

+ (UIColor *)primaryBackgroundColor
{
    return [UIColor colorWithHex:SFCongressPrimaryBackgroundColor];
}

+ (UIColor *)menuBackgroundColor
{
    return [UIColor colorWithHex:SFCongressMenuBackgroundColor];
}

+ (UIColor *)menuSelectionBackgroundColor
{
    return [UIColor colorWithHex:SFCongressMenuSelectionBgColor];
}

+ (UIColor *)menuTextColor
{
    return [UIColor colorWithHex:SFCongressMenuTextColor];
}

+ (UIColor *)primaryTextColor
{
    return [UIColor colorWithHex:SFCongressPrimaryTextColor];
}

+ (UIColor *)linkTextColor
{
    return [UIColor colorWithHex:SFCongressLinkTextColor];
}

+ (UIColor *)linkHighlightedTextColor
{
    return [UIColor colorWithHex:SFCongresslinkHighlightedTextColor];
}

+ (UIColor *)menuDividerBottomInsetColor
{
    return [UIColor colorWithHex:SFCongressMenuDividerBottomInsetColor];
}

+ (UIColor *)menuDividerBottomColor
{
    return [UIColor colorWithHex:SFCongressMenuDividerBottomColor];
}

+ (UIColor *)navigationBarBackgroundColor
{
    return [UIColor colorWithHex:SFCongressNavigationBarColor];
}

+ (UIColor *)navigationBarTextColor
{
    return [UIColor colorWithHex:SFCongressNavigationBarTextColor];
}

+ (UIColor *)navigationBarTextShadowColor
{
    return [UIColor colorWithHex:SFCongressNavigationBarTextShadowColor];
}

+ (UIColor *)tableSeparatorColor
{
    return [UIColor colorWithHex:SFCongressTableSeparatorColor];
}

+ (UIColor *)h1Color
{
    return [UIColor colorWithHex:SFCongressH1Color];
}

+ (UIColor *)h2Color
{
    return  [UIColor colorWithHex:SFCongressH2Color];
}

@end

@implementation UIFont (SFCongressAppStyle)

+ (UIFont *)navigationBarFont
{
    return [UIFont fontWithName:@"EuphemiaUCAS-Bold" size:20.0f];
}

+ (UIFont *)menuFont
{
    return [UIFont fontWithName:@"EuphemiaUCAS" size:18.0f];
}

+ (UIFont *)menuSelectedFont
{
    return [UIFont fontWithName:@"EuphemiaUCAS-Bold" size:18.0f];
}

+ (UIFont *)buttonFont
{
    return [UIFont fontWithName:@"EuphemiaUCAS-Bold" size:18.0f];
}

+ (UIFont *)bodyTextFont
{
    return [UIFont fontWithName:@"HoeflerText-Regular" size:13.0f];
}

+ (UIFont *)h1Font
{
    return [UIFont fontWithName:@"Helvetica-Bold" size:14.0f];
}

+ (UIFont *)h2Font;
{
    return [UIFont fontWithName:@"Helvetica-Bold" size:10.0f];
}

+ (UIFont *)h2EmFont
{
    return [UIFont fontWithName:@"HoeflerText-Italic" size:13.0f];
}

+ (UIFont *)linkFont
{
    return [UIFont fontWithName:@"Helvetica" size:13.0f];
}

+ (UIFont *)cellTextFont
{
    return [UIFont fontWithName:@"Helvetica" size:16.0f];
}

+ (UIFont *)cellDetailTextFont
{
    return [UIFont fontWithName:@"Helvetica" size:12.0f];
}

@end

@implementation UIImage (SFCongressAppStyle)

static NSString * const SFCongressNavigationBarBackgroundImage = @"NavigationBarBg.png";

+ (UIImage *)barButtonDefaultBackgroundImage
{
    return [UIImage imageNamed:SFCongressNavigationBarBackgroundImage];
}

@end

@implementation NSMutableAttributedString (SFCongressAppStyle)

+ (NSMutableAttributedString *)underlinedStringFor:(NSString *)string
{
    NSMutableAttributedString *linkString = [[NSMutableAttributedString alloc] initWithString:string];
    [linkString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, linkString.length)];
    return linkString;
}

+ (NSMutableAttributedString *)linkStringFor:(NSString *)string
{
    NSMutableAttributedString *linkString = [NSMutableAttributedString underlinedStringFor:string];
    NSRange stringRange = NSMakeRange(0, linkString.length);
    [linkString addAttribute:NSForegroundColorAttributeName value:[UIColor linkTextColor] range:stringRange];
    return linkString;
}

+ (NSMutableAttributedString *)highlightedLinkStringFor:(NSString *)string
{
    NSMutableAttributedString *linkString = [NSMutableAttributedString linkStringFor:string];
    NSRange stringRange = NSMakeRange(0, linkString.length);
    [linkString addAttribute:NSForegroundColorAttributeName value:[UIColor linkHighlightedTextColor] range:stringRange];
    return linkString;
}

@end

@implementation NSParagraphStyle (SFCongressAppStyle)

+ (CGFloat)lineSpacing
{
    return SFCongressParagraphLineSpacing;
}

@end

@implementation SFCongressAppStyle

+ (void)setUpGlobalStyles
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [self _setUpNavigationBarAppearance];
    [[UISegmentedControl appearance] setTintColor:[UIColor navigationBarBackgroundColor]];
//    [[UISegmentedControl appearance] setBackgroundImage:[UIImage imageNamed:SFCongressMenuBackgroundImage] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [[UISearchBar appearance] setBackgroundImage:[UIImage barButtonDefaultBackgroundImage]];
}

+ (void)_setUpNavigationBarAppearance
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage barButtonDefaultBackgroundImage] forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{
               UITextAttributeFont: [UIFont navigationBarFont],
          UITextAttributeTextColor: [UIColor navigationBarTextColor],
    UITextAttributeTextShadowColor: [UIColor navigationBarTextShadowColor]
     }];
    [navBar setTitleVerticalPositionAdjustment:-4.0f forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:[UIImage barButtonDefaultBackgroundImage] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

@end
