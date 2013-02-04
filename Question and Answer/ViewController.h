//
//  ViewController.h
//  Question and Answer
//
//  Created by Romy Ilano on 2/3/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, copy) NSMutableArray *quizItems;
@property (weak, nonatomic) IBOutlet UILabel *labelQuestion;
@property (weak, nonatomic) IBOutlet UILabel *labelAnswer;

- (IBAction)btnPressedNextQuestion:(id)sender;
- (IBAction)btnPressedAddQuestion:(id)sender;
- (IBAction)btnPressedListOfQuestions:(id)sender;

-(NSString *)copyDatabaseToDocuments;
-(void)readQuizItemsFromDatabaseWithPath:(NSString *)filePath;

@end
