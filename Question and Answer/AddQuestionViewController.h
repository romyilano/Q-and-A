//
//  AddQuestionViewController.h
//  Question and Answer
//
//  Created by Romy Ilano on 2/3/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QuestionItem;
@interface AddQuestionViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldQuestion;
@property (weak, nonatomic) IBOutlet UITextField *textFieldAnswer;
- (IBAction)btnPressedSubmit:(id)sender;

-(void)addQuizItemToDatabase:(QuestionItem *)newQuestion;
@end
