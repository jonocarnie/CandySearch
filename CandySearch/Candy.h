//
//  CandySearch.h
//  CandySearch
//
//  Created by Jonathan Carnie on 22/08/12.
//  Copyright (c) 2012 Jonathan Carnie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Candy : NSObject{
    NSString *category;
    NSString *name;
    
}


@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;

+(id)candyOfCategory:(NSString *)category name:(NSString *)name;

@end
