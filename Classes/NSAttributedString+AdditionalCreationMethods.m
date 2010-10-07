// -*- objc -*-
// Copyright (c) 2010, KOSUGI Tomo
// This software is licensed under the New BSD License.

#import "NSAttributedString+AdditionalCreationMethods.h"

@implementation NSAttributedString (NSAttributedStringAdditionalCreationMethods)

+ (NSAttributedString *)stringWithString:(NSString *)string
{
    return [[[NSAttributedString alloc] initWithString:string] autorelease];
}

+ (NSAttributedString *)stringWithString:(NSString *)string attrKey:(id)key attrValue:(id)value
{
    NSDictionary *attrs = [NSDictionary dictionaryWithObject:value forKey:key];
    return [[[NSAttributedString alloc] initWithString:string attributes:attrs] autorelease];
}

@end

@implementation NSMutableAttributedString (NSMutableAttributedStringStringAppendable)

- (void)appendString:(NSString *)string
{
    [self appendAttributedString:[NSAttributedString stringWithString:string]];
}

@end
