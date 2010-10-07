// -*- objc -*-
// Copyright (c) 2010, KOSUGI Tomo
// This software is licensed under the New BSD License.

#import <Adium/AIContentControllerProtocol.h>

@interface BaseFilter : NSObject <AIContentFilter>
{
    NSString *uid;
}

- (BOOL)fromPlurk:(id)target selector:(SEL)selector;
- (id)initWithUID:(NSString *)uid;
- (void)dealloc;

@end
