//
//  MERMemoryVC.m
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERMemoryVC.h"
#import "MERMemoryCardV.h"

@interface MERMemoryVC ()
@property (weak, nonatomic) IBOutlet MERMemoryCardV *myCard;
@property (weak, nonatomic) IBOutlet MERMemoryCardV *myCard2;

@end

@implementation MERMemoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //@"♥︎, ♦︎, ♣︎, ♠︎";
    
    self.myCard.suit = @"♥︎";
    self.myCard.rank = 5;
    self.myCard.faceUP = TRUE;
    
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
