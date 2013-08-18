//
//  CoreKittyTests.m
//  CoreKittyTests
//
//  Created by zm on 8/18/13.
//  Copyright (c) 2013 Hackazach. All rights reserved.
//

#import "Kiwi.h"

SPEC_BEGIN(COOLSPEC)

describe(@"this is a cool spec", ^{
    it(@"does a really great job", ^{
        NSString *Zach = @"hello there!";
        [[Zach should] equal:@"hello there!"];
    });
});

SPEC_END