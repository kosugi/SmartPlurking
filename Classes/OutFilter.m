// -*- objc -*-
// Copyright (c) 2010, KOSUGI Tomo
// This software is licensed under the New BSD License.

#import "OutFilter.h"
#import "NSAttributedString+AdditionalCreationMethods.h"
#import <Adium/AIContentMessage.h>

@implementation OutFilter

- (NSAttributedString *)filterAttributedString:(NSAttributedString *)string context:(id)context
{
    if (![self fromPlurk:context selector:@selector(destination)]) {
        return string;
    }

    NSString *text = [string string];
#ifdef DEBUG
    NSLog(@"OutFilter::filterAttributedString");
    NSLog(text);
#endif
    return [NSAttributedString stringWithString:text];
}

@end
