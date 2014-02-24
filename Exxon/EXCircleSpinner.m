//
//  EXCircleSpinner.m
//  Exxon
//
//  Created by won kim on 2/23/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import "EXCircleSpinner.h"





#define kLineWidth       34

@interface EXCircleSpinner ()
{
    CAShapeLayer *circleOutline;
    CAShapeLayer *circleFill;
    CAShapeLayer *circleProgress;
    CAKeyframeAnimation *drawOut;
    CAKeyframeAnimation *drawIn;
    
    NSTimer* progressTimer;
    
    float duration;
    int   currentProgress;
    NSString* animTitle;
    IBOutlet UILabel* progressLabel;

    

}
@end

@implementation EXCircleSpinner

@synthesize delegate,progressColor,outlineColor;

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        
        int radius = self.frame.size.width/2;
        circleOutline = [CAShapeLayer layer];
        circleFill = [CAShapeLayer layer];
        circleProgress = [CAShapeLayer layer];
 
        
        float offset=20;

        circleOutline.path = circleFill.path = circleProgress.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(offset , offset, 2.0*(radius-offset), 2.0*(radius-offset)) cornerRadius:radius].CGPath;
        
        
        // Configure the apperence of the circle
        circleProgress.fillColor = [[UIColor clearColor] CGColor];
        circleProgress.strokeColor = [[UIColor clearColor] CGColor];//[UIColor whiteColor].CGColor;
        circleProgress.lineWidth = kLineWidth;
       // circleProgress.opacity=0;
        
        circleOutline.fillColor = [[UIColor clearColor] CGColor];
        circleOutline.strokeColor = [[UIColor clearColor] CGColor];;
        circleOutline.lineWidth = kLineWidth;

        
        [self.layer addSublayer:circleOutline];
        [self.layer addSublayer:circleProgress];
        
        drawOut = [CAKeyframeAnimation animationWithKeyPath:@"strokeEnd"];
        drawIn = [CAKeyframeAnimation animationWithKeyPath:@"strokeStart"];
        NSArray *times = @[@0.0f, @0.5f, @1.0f];
        NSArray *outValues = @[@0.0f, @1.0f, @1.0f];
        NSArray *inValues = @[@0.0f, @0.0f, @1.0f];
        [drawOut setKeyTimes:times];
        [drawOut setValues:outValues];
        [drawIn setKeyTimes:times];
        [drawIn setValues:inValues];
        
        duration=30;
        drawOut.duration = drawIn.duration = duration*2;
        drawOut.repeatCount = drawIn.repeatCount = HUGE_VALF;
        drawOut.removedOnCompletion = drawIn.removedOnCompletion = NO;
        drawOut.fillMode = drawIn.fillMode = kCAFillModeForwards;
        

        UIButton *btnStart = [UIButton buttonWithType:UIButtonTypeCustom];
        btnStart.frame = CGRectMake(0 , 0, 2.0*(radius), 2.0*(radius));
        [self addSubview:btnStart];
        
        [btnStart addTarget:self
                   action:@selector(startProgress)
         forControlEvents:UIControlEventTouchDown];
        
        animTitle=@"AUTHORIZING";
//        [circleProgress addAnimation:drawOut forKey:@"drawCircleAnimation"];
//        [circleProgress addAnimation:drawIn forKey:@"undrawCircleAnimation"];

       // [self finishLoadingAnimation];
    }
    return self;
}
- (void)setColorProgress:(UIColor*)progress Outline:(UIColor*)outline
{
    progressColor=progress;
    outlineColor=outline;
    circleOutline.strokeColor=[outlineColor CGColor];
    
    
}

- (void)setDuration:(float)time
{
    duration=time;
    drawOut.duration = drawIn.duration = duration*2;
}

-(void)startProgress
{
    NSLog(@"startProgress");
    [self startLoadingAnimation];
}


- (void) startLoadingAnimation {
    
    [progressTimer invalidate];
    progressTimer=nil;
    currentProgress=0;
    progressLabel.text=[NSString stringWithFormat:@"%d",currentProgress];
    [circleProgress addAnimation:drawOut forKey:@"drawCircleAnimation"];
    [circleProgress addAnimation:drawIn forKey:@"undrawCircleAnimation"];
    
    circleProgress.strokeColor =[progressColor CGColor];
    
    progressTimer=[NSTimer scheduledTimerWithTimeInterval:1.0
                                                   target:self
                                                 selector:@selector(updateProgress)
                                                 userInfo:nil
                                                  repeats:YES];
    
    
    if ([[self delegate] respondsToSelector:@selector(progressStart)])  {
        [[self delegate] progressStart];
    }

}

- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animation stop called");
}

- (void) finishLoadingAnimation {
     //circleProgress.strokeColor = [[UIColor clearColor] CGColor];
    progressLabel.text=[NSString stringWithFormat:@"%d",currentProgress];
    [circleProgress removeAnimationForKey:@"drawCircleAnimation"];
    [circleProgress removeAnimationForKey:@"undrawCircleAnimation"];
    
    [progressTimer invalidate];
    progressTimer=nil;
    
    if ([[self delegate] respondsToSelector:@selector(progressFinish)])  {
        [[self delegate] progressFinish];
    }


    
}

- (void) stopLoadingAnimation {
    [circleProgress removeAllAnimations];
}

- (void) updateProgress {
    
    currentProgress++;
    

    
    if(currentProgress<duration)
    {
        progressLabel.text=[NSString stringWithFormat:@"%d",currentProgress];
    }
    else
    {
        [self finishLoadingAnimation];
        
    }
}


@end
