// -*- objc -*-
// Copyright (c) 2010, KOSUGI Tomo
// This software is licensed under the New BSD License.

#import <Foundation/NSAttributedString.h>

@interface NSAttributedString (NSAttributedStringAdditionalCreationMethods)
+ (NSAttributedString *)stringWithString:(NSString *)string;
+ (NSAttributedString *)stringWithString:(NSString *)string attrKey:(id)key attrValue:(id)value;
@end

@interface NSMutableAttributedString (NSMutableAttributedStringStringAppendable)
- (void)appendString:(NSString *)string;
@end
