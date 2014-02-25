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
    IBOutlet UIView      *blueBGView;
    IBOutlet UIImageView *logo2Image;
    
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

    
    //hide blue bg
    CGRect blueframe=blueBGView.frame;
    blueframe.origin.x=-screenWidth-6;
    blueBGView.frame=blueframe;
    blueframe.origin.x=0;
    
    //fade in logo 1
    logoImage.alpha=0;
    [UIView animateWithDuration:animSpeed delay:animSpeed
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         logoImage.alpha=1;

                     }
                     completion:^(BOOL finished){
                         NSLog(@"done");
                     }
     ];
    
    

    
    CGRect logoframe=CGRectMake(0,0,0,1);
    logo2Image.layer.contentsRect=logoframe;
    logoframe.size.width=1;
    
    
    [UIView animateWithDuration:animSpeed/2 delay:animSpeed*2+0.5
                        options: UIViewAnimationOptionCurveLinear
                     animations:^{
                         blueBGView.frame=blueframe;
                   
                         logo2Image.layer.contentsRect=logoframe;
                     }
                     completion:^(BOOL finished){
                         NSLog(@"done");
                     }
     ];

    //after speed sec, bring back redBG
    
  //  [self performSelector:@selector(step2) withObject:nil afterDelay:animSpeed*2 ];


}

//blue image is sliding in
-(void)step1
{
    
}
-(void)step2
{
    blueBGView.layer.zPosition=0;
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
