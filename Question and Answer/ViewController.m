//
//  ViewController.m
//  Question and Answer
//
//  Created by Romy Ilano on 2/3/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "ViewController.h"
#import "Constants.h"
#import "QuestionItem.h"
#import <sqlite3.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _quizItems=[[NSMutableArray alloc] init];
    
    NSString *filePath = [self copyDatabaseToDocuments];
    
    [self readQuizItemsFromDatabaseWithPath:filePath];
   
    QuestionItem *questionItem = [[self quizItems] objectAtIndex:0];
    
    self.labelQuestion.text=questionItem.question;
    self.labelAnswer.text = questionItem.answer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-Database Methods
- (IBAction)btnPressedNextQuestion:(id)sender {
    
}

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
                
                NSLog(@"question is %@", questionItem.question);
               [[self quizItems] addObject:questionItem];
            }
        }
        sqlite3_finalize(compiledStatement);
    }
    sqlite3_close(database);
}

@end
