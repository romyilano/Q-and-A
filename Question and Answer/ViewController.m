//
//  ViewController.m
//  Question and Answer
//
//  Created by Romy Ilano on 2/3/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "ViewController.h"
#import "QuestionsTableViewController.h"

#import "Constants.h"
#import "QuestionItem.h"

#import <sqlite3.h>

@interface ViewController ()
-(void)displayNewQuestion;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    // why does this crash when I do self.quizItems = [[NSMutableArray alloc] init];
    //  I get
    // 2013-02-03 17:53:30.625 Question and Answer[2099:c07] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[__NSArrayI addObject:]: unrecognized selector sent to instance 0x894d320'
    _quizItems=[[NSMutableArray alloc] init];
    NSString *filePath = [self copyDatabaseToDocuments];
    
    [self readQuizItemsFromDatabaseWithPath:filePath];
   
    [self displayNewQuestion];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Custom Methods
- (IBAction)btnPressedNextQuestion:(id)sender {
   
    [self displayNewQuestion];
}

- (IBAction)btnPressedAddQuestion:(id)sender {
}

- (IBAction)btnPressedListOfQuestions:(id)sender {
    
    QuestionsTableViewController *questionsTableViewController = [[QuestionsTableViewController alloc] init];
    questionsTableViewController.quizItems = self.quizItems;
    
    [[self navigationController] pushViewController:questionsTableViewController animated:YES];
    
}

-(void)displayNewQuestion
{
    int questionNumber = arc4random() % [[self quizItems] count];
    
    QuestionItem *questionItem = [[self quizItems] objectAtIndex:questionNumber];
    self.labelAnswer.text=questionItem.answer;
    self.labelQuestion.text = questionItem.question;
}

#pragma mark-Database Methods

-(NSString *)copyDatabaseToDocuments
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // iOS apps are all at index 0... mac os x have more
    NSString *documentsPath = [paths objectAtIndex:0];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:kFilenameQuiz];
    
    if(![fileManager fileExistsAtPath:filePath])
    {
        NSString *bundleCopy = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:kFilenameQuiz];
    
        [fileManager copyItemAtPath:bundleCopy toPath:filePath error:nil];
    }

    return filePath;
    
}

-(void)readQuizItemsFromDatabaseWithPath:(NSString *)filePath
{
    sqlite3 *database;
    
    if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = "select * from Quiz";
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // while there's a row... [loop through the rows]
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                
                NSString *questionText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 0)];
                NSString *answerText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                
                QuestionItem *questionItem = [[QuestionItem alloc] init];
                questionItem.question = questionText;
                questionItem.answer = answerText;
                
               //  NSLog(@"question is %@", questionItem.question);
               [[self quizItems] addObject:questionItem];
            }
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

@end
