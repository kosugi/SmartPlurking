// -*- objc -*-
// Copyright (c) 2010, KOSUGI Tomo
// This software is licensed under the New BSD License.

#import "BaseFilter.h"
#import <Adium/AIContentMessage.h>

@implementation BaseFilter

- (NSAttributedString *)filterAttributedString:(NSAttributedString *)string context:(id)context
{
    return string;
}

- (float)filterPriority
{
    return DEFAULT_FILTER_PRIORITY;
}

- (BOOL)fromPlurk:(id)target selector:(SEL)selector
{
    return
        [target isKindOfClass:[AIContentMessage class]] &&
        [uid isEqualToString:[[target performSelector:selector] UID]];
}

- (id)initWithUID:(NSString *)newUid
{
#ifdef DEBUG
    NSLog(@"BaseFilter::init");
#endif
    if (self = [super init]) {
        uid = [newUid retain];
    }
    return self;
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"BaseFilter::dealloc");
#endif
    [uid release];
    [super dealloc];
}

@end
