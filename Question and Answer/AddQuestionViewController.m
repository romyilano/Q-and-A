//
//  AddQuestionViewController.m
//  Question and Answer
//
//  Created by Romy Ilano on 2/3/13.
//  Copyright (c) 2013 Romy Ilano. All rights reserved.
//

#import "AddQuestionViewController.h"
#import <sqlite3.h>
#import "Constants.h"
#import "QuestionItem.h"

@interface AddQuestionViewController ()

@end

@implementation AddQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnPressedSubmit:(id)sender {
 
    if(self.textFieldQuestion.text.length > 0 ) {
        QuestionItem *newQuestionItem = [[QuestionItem alloc] init];
        
        newQuestionItem.question=self.textFieldQuestion.text;
        newQuestionItem.answer=self.textFieldAnswer.text;
        
        [self addQuizItemToDatabase:newQuestionItem];
    }
}

-(void)addQuizItemToDatabase:(QuestionItem *)newQuestion
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsPath = [paths objectAtIndex:0];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:kFilenameQuiz];
    
    sqlite3 *database;
    
    if(sqlite3_open([filePath UTF8String], &database) == SQLITE_OK) {
        const char *sqlStatement = "insert into Quiz (Question, Answer) VALUES (?, ?)";
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK)
        {
            sqlite3_bind_text(compiledStatement, 0, [newQuestion.question UTF8String], -1, SQLITE_TRANSIENT);
           
            sqlite3_bind_text(compiledStatement,1, [newQuestion.answer UTF8String], -1, SQLITE_TRANSIENT);
            
        }
        if (sqlite3_step(compiledStatement)==SQLITE_DONE) {
            sqlite3_finalize(compiledStatement);
        }

    }

    sqlite3_close(database);
}
@end
