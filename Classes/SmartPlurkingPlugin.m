// -*- objc -*-
// Copyright (c) 2010, KOSUGI Tomo
// This software is licensed under the New BSD License.

#import "SmartPlurkingPlugin.h"
#import "InFilter.h"
#import "OutFilter.h"

static NSString *PLURK_UID = @"bot@plurk.com";

@implementation SmartPlurkingPlugin

- (void)installPlugin
{
    NSLog(@"SmartPlurkingPlugin::installPlugin");

    inFilter = [[InFilter alloc] initWithUID:PLURK_UID];
    [[adium contentController]
        registerContentFilter:inFilter
        ofType:AIFilterMessageDisplay
        direction:AIFilterIncoming];

    outFilter = [[OutFilter alloc] initWithUID:PLURK_UID];
    [[adium contentController]
        registerContentFilter:outFilter
        ofType:AIFilterContent
        direction:AIFilterOutgoing];
}

- (void)uninstallPlugin
{
    NSLog(@"SmartPlurkingPlugin::uninstallPlugin");
    [[adium contentController] unregisterContentFilter:inFilter];
    [[adium contentController] unregisterContentFilter:outFilter];
    [inFilter release];
    [outFilter release];
}

- (NSString *)pluginAuthor
{
    return @"KOSUGI Tomo";
}

- (NSString *)pluginVersion
{
    return @"1.0.0";
}

- (NSString *)pluginDescription
{
    return @"suppresses redundant information from plurk incoming/outgoing message.";
}

- (NSString *)pluginURL
{
    return @"http://github.com/kosugi/SmartPlurking";
}

@end
