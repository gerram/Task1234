//
//  MERMemoryVC.m
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERMemoryVC.h"
#import "MERMemoryCardV.h"
#import "MERMemoryDeck.h"

@interface MERMemoryVC ()
@property (strong, nonatomic) IBOutletCollection(MERMemoryCardV) NSArray *memoryCards;
@property (strong, nonatomic) MERMemoryDeck *deck;
@end

@implementation MERMemoryVC

- (MERMemoryDeck *)deck
{
    if (!_deck) {
        _deck = [[MERMemoryDeck alloc] init];
    }
    return _deck;
}


- (void)drawPlayingCards
{
    for (MERMemoryCardV *card in _memoryCards) {
        NSString *cardInString = [self.deck drawRandomCard];
        card.suit = [cardInString substringWithRange:NSMakeRange(0, 1)];
        card.rank = [cardInString substringWithRange:NSMakeRange(1, cardInString.length - 1)];
        card.faceUP = FALSE;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawPlayingCards];
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

//#pragma mark - Model
//- (NSArray *)generateFullCardArray
//{
//    NSArray *suits = @[@"♥︎", @"♦︎", @"♣︎", @"♠︎"];
//    NSArray *ranks = @[@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
//    NSMutableArray *fullArray = [@[] mutableCopy];
//    
//    for (NSString *suit in suits) {
//        for (NSString *rank in ranks) {
//            [fullArray addObject:[suit stringByAppendingString:rank]];
//        }
//    }
//    
//    return fullArray;
//}
//
//// Not good, maybe to use generator
//- (NSArray *)generateRandomCardArrayFrom:(NSArray *)sourceArray
//{
//    NSMutableArray *fullArray = [@[] mutableCopy];
//    NSMutableArray *source = [sourceArray mutableCopy];
//    
//    while ([source count] > 0) {
//        NSString *tmpObj = [source objectAtIndex:arc4random() % [source count]];
//        [fullArray addObject:tmpObj];
//        [source removeObject:tmpObj];
//    }
//    
//    return fullArray;
//}



@end
