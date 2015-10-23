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
#import "MERMemoryEngine.h"

@interface MERMemoryVC () <CardDelegate>
@property (strong, nonatomic) MERMemoryEngine *model;
@property (strong, nonatomic) MERMemoryDeck *deck;
@property (strong, nonatomic) IBOutletCollection(MERMemoryCardV) NSArray *memoryCards;
@end

@implementation MERMemoryVC

#pragma mark - Properties
- (MERMemoryDeck *)deck
{
    if (!_deck) {
        _deck = [[MERMemoryDeck alloc] init];
    }
    return _deck;
}


- (MERMemoryEngine *)model
{
    if (!_model) {
        _model = [[MERMemoryEngine alloc] init];
    }
    return _model;
}


- (void)drawPlayingCards
{
    //NSDictionary *suits = @{@"A": @"♥︎", @"B": @"♦︎", @"C": @"♣︎", @"D": @"♠︎"};
    NSArray *ranks = @[@"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K", @"A"];
    
    for (MERMemoryCardV *card in _memoryCards) {
        NSString *cardInString = [self.deck drawRandomCard];
        card.suit = [cardInString substringWithRange:NSMakeRange(0, 1)];
        NSString *rankInString = [cardInString substringWithRange:NSMakeRange(1, cardInString.length - 1)];
        card.rank = [ranks indexOfObject:rankInString];
        card.faceUP = FALSE;
        card.delegate = self;
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

#pragma mark - CardDelegate
- (void)clickedCard:(id)sender
{
    //
    if ([sender isKindOfClass:[MERMemoryCardV class]]) {
        MERMemoryCardV *senderObj = sender;
        //NSLog(@"%@", senderObj.suit);
        NSString *clickedCard = [NSString stringWithFormat:@"%@%@", senderObj.suit, [senderObj rankAsString]];
        
        [self.model addCardToMatchingList:clickedCard];
        if ([[_model matchingList] count] == 1) {
            [self updateUI:senderObj];
        }
    }
}

- (void)updateUI:(MERMemoryCardV *)excludedCard {
    for (MERMemoryCardV *card in _memoryCards) {
        if (![card isEqual:excludedCard]) {
            card.faceUP = FALSE;
            card.isMatch = FALSE;
        }
    }
}


@end
