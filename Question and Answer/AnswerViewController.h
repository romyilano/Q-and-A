//
//  AnswerViewController.h
//  Question and Answer
//
//  Created by Romy Ilano on 2/3/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QuestionItem;
@interface AnswerViewController : UIViewController

@property (strong, nonatomic) QuestionItem *questionItem;

@property (weak, nonatomic) IBOutlet UILabel *labelQuestion;
@property (weak, nonatomic) IBOutlet UILabel *labelAnswer;

@end
