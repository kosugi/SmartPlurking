// -*- objc -*-
// Copyright (c) 2010, KOSUGI Tomo
// This software is licensed under the New BSD License.

#import "InFilter.h"
#import "NSAttributedString+AdditionalCreationMethods.h"
#import "CocoaOniguruma/OnigRegexp.h"
#import <Adium/AIContentMessage.h>

static NSString *PAT_ROOT_STR = @"(?<username>[^\\s]+)\\s+(?<text>.*)\\n(?<permalink>http://www.plurk.com/p/[^\\s]+) - (?<thread_id>#[^\\s]+)";
static NSString *PAT_COMMENT_STR = @"(?<username>[^\\s]+)\\s+(?<text>.*)\\nto \\\"(?<owner>[^\\s]+)\\s+(?<root_text>.*)\\\" - (?<permalink>http://www.plurk.com/p/[^\\s]+) - (?<thread_id>#[^\\s]+)";
static NSString *PAT_URL_STR = @"\\b(?<url>https?://[-_\\.!~*\'()a-zA-Z0-9;/?:@&=+$,%#]+)";

@implementation InFilter

- (NSAttributedString *)enlink:(NSString *)text
{
    NSMutableAttributedString *buf =
        [[[NSMutableAttributedString alloc] initWithString:text] autorelease];

    int pos = 0;
    OnigResult *r;
    while (r = [patUrl search:text start:pos]) {
        NSRange range = [r rangeAt:1];
        NSDictionary *attrs =
            [NSDictionary dictionaryWithObject:[r stringForName:@"url"] forKey:NSLinkAttributeName];
        [buf addAttributes:attrs range:range];
        pos = range.location + range.length;
    }
    return buf;
}

- (NSAttributedString *)processMessage:(OnigResult *)r
{
    NSMutableAttributedString *buf = [[[NSMutableAttributedString alloc] init] autorelease];
    NSString *username  = [r stringForName:@"username"];
    NSString *text      = [r stringForName:@"text"];
    NSString *threadId  = [r stringForName:@"thread_id"];
    NSString *permalink = [r stringForName:@"permalink"];
    NSString *rootText  = [r stringForName:@"root_text"];
//     NSString *owner     = [r stringForName:@"owner"];

    [buf appendString:username];
    [buf appendString:@": "];
    [buf appendAttributedString:[self enlink:text]];
    [buf appendString:@" - "];

    [buf appendAttributedString:[NSAttributedString
                                    stringWithString:threadId
                                    attrKey:NSLinkAttributeName
                                    attrValue:permalink]];

    if (rootText) {
        static const int THRESHOLD = 20;
        NSString *guide;
        // TODO: avoid newline
        if (THRESHOLD * 1.3 < [rootText length]) {
            guide = [NSString stringWithFormat:@" (on %@\u2026\u2026)", [rootText substringToIndex:THRESHOLD]];
        }
        else {
            guide = [NSString stringWithFormat:@" (on %@)", rootText];
        }
        [buf appendAttributedString:[NSAttributedString
                                        stringWithString:guide
//                                         TODO: doesn't work
//                                         attrKey:NSForegroundColorAttributeName
//                                         attrValue:[NSColor grayColor]
                ]];
    }
    return buf;
}

- (NSAttributedString *)filterAttributedString:(NSAttributedString *)string context:(id)context
{
    if (![self fromPlurk:context selector:@selector(source)]) {
        return string;
    }

    NSString *text = [string string];
#ifdef DEBUG
    NSLog(@"InFilter::filterAttributedString");
    NSLog(text);
#endif

    OnigResult *r;
    if (r = [patRoot match:text]) {
        return [self processMessage:r];
    }
    else if (r = [patComment match:text]) {
        return [self processMessage:r];
    }
    else {
#ifdef DEBUG
        NSLog(@"unmatched");
#endif
        return string;
    }
}

- (id)initWithUID:(NSString *)newUid
{
#ifdef DEBUG
    NSLog(@"InFilter::init");
#endif
    if (self = [super initWithUID:newUid]) {
        patUrl     = [[OnigRegexp compile:PAT_URL_STR     ignorecase:NO multiline:YES extended:NO] retain];
        patRoot    = [[OnigRegexp compile:PAT_ROOT_STR    ignorecase:NO multiline:YES extended:NO] retain];
        patComment = [[OnigRegexp compile:PAT_COMMENT_STR ignorecase:NO multiline:YES extended:NO] retain];
    }
    return self;
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"InFilter::dealloc");
#endif
    [patUrl     release];
    [patRoot    release];
    [patComment release];
    [super dealloc];
}

@end
