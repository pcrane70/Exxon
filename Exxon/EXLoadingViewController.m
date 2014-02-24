//
//  EXLoadingViewController.m
//  Exxon
//
//  Created by won kim on 2/23/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "EXLoadingViewController.h"
#import "EXCircleSpinner.h"

#define kOldCheckmarkColor [UIColor colorWithRed:(74/255.0) green:(217/255.0) blue:(99/255.0) alpha:1.0].CGColor
#define kCheckmarkColor [UIColor colorWithRed:(95/255.0) green:(188/255.0) blue:(190/255.0) alpha:0.5]

@interface EXLoadingViewController ()
{
    
    IBOutlet EXCircleSpinner *spinner;

    IBOutlet UILabel* animTextLabel;
    
    
    NSTimer* progressTimer;
    int currentProgress;
}

@end

@implementation EXLoadingViewController

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

    spinner.delegate=self;
    [spinner setColorProgress:[UIColor whiteColor] Outline:kCheckmarkColor];
    [spinner setDuration:20];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateProgress {
    
    currentProgress++;
    
    NSString* dot=@"";
    for(int i=0;i<currentProgress%4;i++)
    {
        dot=[dot stringByAppendingString:@"."];
        
    }
    
    NSString* animTitle=@"AUTHORIZING";
    NSString* curString=[NSString stringWithFormat:@"%@%@",animTitle,dot];
    animTextLabel.text=curString;
    
 }



#pragma mark- CircleSpinnerDelegate

-(void)progressStart
{
    progressTimer=[NSTimer scheduledTimerWithTimeInterval:0.5
                                                   target:self
                                                 selector:@selector(updateProgress)
                                                 userInfo:nil
                                                  repeats:YES];
    
    NSLog(@"progressStart");
}


-(void)progressFinish
{
    [progressTimer invalidate];
    progressTimer=nil;
    
    NSLog(@"progressFinish");
}

@end
