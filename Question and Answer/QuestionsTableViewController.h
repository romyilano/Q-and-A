//
//  QuestionsTableViewController.h
//  Question and Answer
//
//  Created by Romy Ilano on 2/3/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QuestionItem;
@interface QuestionsTableViewController : UITableViewController

@property (copy, nonatomic) NSMutableArray *quizItems;
@property (strong, nonatomic) QuestionItem *questionItem;
@end
