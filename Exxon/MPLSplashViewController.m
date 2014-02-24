//
//  MPLSplashViewController.m
//  Exxon
//
//  Created by won kim on 2/24/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "MPLSplashViewController.h"

@interface MPLSplashViewController ()
{
    
    IBOutlet UIImageView *redBGImage;
    IBOutlet UIImageView *logoImage;
    IBOutlet UIImageView *blueBGImage;
    
    float screenWidth;
    float animSpeed;
}

@end

@implementation MPLSplashViewController

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
    
    //TODO:remove it. For testing purpose
    UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
    btnStart.frame = CGRectMake(0 , 0, 100, 100);
    [self.view addSubview:btnStart];
    
    [btnStart addTarget:self
                 action:@selector(playSplashAnimation)
       forControlEvents:UIControlEventTouchDown];
    
    UIScreen *screen = [UIScreen mainScreen];
    CGRect screenRect = screen.bounds;
    screenWidth=screenRect.size.width;
    
    animSpeed=1;
   
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    [self playSplashAnimation];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)playSplashAnimation
{

    //set layer
    blueBGImage.layer.zPosition=1;
    logoImage.layer.zPosition=2;
    redBGImage.layer.zPosition=0;
    
    //hide blue bg
    CGRect blueframe=blueBGImage.frame;
    blueframe.origin.x=-screenWidth;
    blueBGImage.frame=blueframe;
    blueframe.origin.x=0;

   
    
    CGRect logoframe=CGRectMake(0,0,0,1);
   // logoframe.size.width=120;
    logoImage.layer.contentsRect=logoframe;
    logoframe.size.width=1;
    
    
    [UIView animateWithDuration:animSpeed delay:animSpeed
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         blueBGImage.frame=blueframe;
                   
                         logoImage.layer.contentsRect=logoframe;
                     }
                     completion:^(BOOL finished){
                         NSLog(@"done");
                     }
     ];

    //after speed sec, bring back redBG
    
    [self performSelector:@selector(showRedBGImage) withObject:nil afterDelay:animSpeed*2 ];


}

-(void)showRedBGImage
{
    blueBGImage.layer.zPosition=0;
    logoImage.layer.zPosition=2;
    redBGImage.layer.zPosition=1;

    //show red bg
    CGRect redframe=redBGImage.frame;
    redframe.origin.x=screenWidth;
    redBGImage.frame=redframe;
    redframe.origin.x=0;
 
    
    
    [UIView animateWithDuration:animSpeed delay:0
                        options: UIViewAnimationOptionCurveEaseInOut                     animations:^{
  
                         redBGImage.frame=redframe;
                     }
                     completion:^(BOOL finished){
                         
                         
                         NSLog(@"transition to main menu");
                     }
     ];
    
}


@end
