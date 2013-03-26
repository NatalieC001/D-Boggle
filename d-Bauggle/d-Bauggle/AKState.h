//
//  AKState.h
//  d-Bauggle
//
//  Created by Arnav Kumar on 21/3/13.
//  Copyright (c) 2013 Arnav Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKState : NSObject

@property (nonatomic) BOOL isWord;
@property (nonatomic) BOOL isActive;
@property (nonatomic, strong) NSMutableArray *alphabets;

-(NSMutableArray *)alphabets;
-(void)initialize;

@end
