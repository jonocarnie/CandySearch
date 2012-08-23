//
//  CandySearch.m
//  CandySearch
//
//  Created by Jonathan Carnie on 22/08/12.
//  Copyright (c) 2012 Jonathan Carnie. All rights reserved.
//

#import "Candy.h"

@implementation Candy

@synthesize category;
@synthesize name;


+(id)candyOfCategory:(NSString *)category name:(NSString *)name{
    Candy *newCandy = [[self alloc] init];
    newCandy.category = category;
    newCandy.name = name;
    return newCandy;
}
@end
