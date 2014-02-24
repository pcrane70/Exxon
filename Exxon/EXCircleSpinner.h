//
//  EXCircleSpinner.h
//  Exxon
//
//  Created by won kim on 2/23/14.
//  Copyright (c) 2014 toltoly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EXCircleSpinner : UIView


@property (nonatomic, assign) UIColor* outlineColor;
@property (nonatomic, assign) UIColor* progressColor;

@property (nonatomic, retain) id delegate;

- (void)setColorProgress:(UIColor*)progress Outline:(UIColor*)outline;
- (void)setDuration:(float)time;
- (void) stopLoadingAnimation;
- (void) finishLoadingAnimation;

@end

@protocol EXCircleSpinnerProtocol <NSObject>

-(void)progressStart;
-(void)progressFinish;

@end



