//
//  MERBaseCardV.h
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CardDelegate <NSObject>
@optional
- (void)clickedCard:(id)sender;
@end

@interface MERBaseCardV : UIView
@property (nonatomic, weak) id <CardDelegate> delegate;
@property (nonatomic, assign) BOOL isMatch;
@end
