//
//  QuestionItem.h
//  Question and Answer
//
//  Created by Romy Ilano on 2/3/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionItem : NSObject
@property (copy, nonatomic) NSString *question;
@property (copy, nonatomic) NSString *answer;

-(id)initWithQuestion:(NSString *)q andAnswer:(NSString *)a;
-(id)initWIthDictionary:(NSDictionary *)dict;
@end
