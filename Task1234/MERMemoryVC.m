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
@property (strong, nonatomic) IBOutletCollection(MERMemoryCardV) NSArray *memoryCards;
@end

@implementation MERMemoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //@"♥︎, ♦︎, ♣︎, ♠︎";
    
    /*
    self.myCard.suit = @"♥︎";
    self.myCard.rank = 5;
    self.myCard.faceUP = TRUE;
     */
    
    for (MERMemoryCardV *card in self.memoryCards) {
        if ([card isKindOfClass:[MERMemoryCardV class]]) {
            card.suit = @"♥︎";
            card.rank = 5;
            card.faceUP = TRUE;
        }
    }
    
    NSArray *fullCardArray = [self generateFullCardArray];
    NSArray *randomCardArray = [self generateRandomCardArrayFrom:fullCardArray];
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

#pragma mark - Model
- (NSArray *)generateFullCardArray
{
    NSArray *suits = @[@"♥︎", @"♦︎", @"♣︎", @"♠︎"];
    NSArray *ranks = @[@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    NSMutableArray *fullArray = [@[] mutableCopy];
    
    for (NSString *suit in suits) {
        for (NSString *rank in ranks) {
            [fullArray addObject:[suit stringByAppendingString:rank]];
        }
    }
    
    return fullArray;
}

// Not good, maybe to use generator
- (NSArray *)generateRandomCardArrayFrom:(NSArray *)sourceArray
{
    NSMutableArray *fullArray = [@[] mutableCopy];
    NSMutableArray *source = [sourceArray mutableCopy];
    
    while ([source count] > 0) {
        NSString *tmpObj = [source objectAtIndex:arc4random() % [source count]];
        [fullArray addObject:tmpObj];
        [source removeObject:tmpObj];
    }
    
    return fullArray;
}



@end
