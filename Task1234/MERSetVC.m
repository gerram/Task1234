//
//  MERSetVC.m
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERSetVC.h"
#import "MERSetCardV.h"

@interface MERSetVC ()
@property (weak, nonatomic) IBOutlet MERSetCardV *setCard;
@property (weak, nonatomic) IBOutlet MERSetCardV *setCardTwix;
@property (weak, nonatomic) IBOutlet MERSetCardV *setCardWing;
@end

@implementation MERSetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Suits
    // @[@"green", @"blue", @"red"];
    
    // Fills
    // @[@"full", @"hatch", @"blank"];
    
    
    self.setCard.rank = 3;
    self.setCard.suit = @"red";
    self.setCard.shape = kDiamond;
    self.setCard.fill = kFull;
    
    self.setCardTwix.rank = 3;
    self.setCardTwix.suit = @"red";
    self.setCardTwix.shape = kTwix;
    self.setCardTwix.fill = kHatch;
    
    self.setCardWing.rank = 3;
    self.setCardWing.suit = @"red";
    self.setCardWing.shape = kWing;
    self.setCardWing.fill = kBlank;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
