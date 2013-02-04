//
//  QuestionItem.m
//  Question and Answer
//
//  Created by Romy Ilano on 2/3/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "QuestionItem.h"

@implementation QuestionItem
-(id)initWithQuestion:(NSString *)q andAnswer:(NSString *)a
{
    self=[super init];
    
    if(self)
    {
        self.question=q;
        self.answer=a;
    }
    return self;
}

-(id)initWIthDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    if(self!=nil)
    {
        self.question=dict[@"Question"];
        self.answer =dict[@"Answer"];
            
    }
    return self;
}

@end
