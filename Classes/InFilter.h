// -*- objc -*-
// Copyright (c) 2010, KOSUGI Tomo
// This software is licensed under the New BSD License.

#import "BaseFilter.h"

@class OnigRegexp;

@interface InFilter : BaseFilter
{
    OnigRegexp *patUrl;
    OnigRegexp *patRoot;
    OnigRegexp *patComment;
}

- (id)initWithUID:(NSString *)uid;
- (void)dealloc;

@end
