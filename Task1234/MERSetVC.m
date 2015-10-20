//
//  MERSetVC.m
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERSetVC.h"
#import "MERSetCardV.h"
#import "MERSetDeck.h"

@interface MERSetVC ()
@property (strong, nonatomic) IBOutletCollection(MERSetCardV) NSArray *setCards;
@property (strong, nonatomic) MERSetDeck *deck;
@end

@implementation MERSetVC

- (MERSetDeck *)deck
{
    if (!_deck) {
        _deck = [[MERSetDeck alloc] init];
    }
    return _deck;
}


- (void)drawPlayingCards
{
    for (MERSetCardV *card in _setCards) {
        NSString *cardInString = [self.deck drawRandomCard];
        card.shape = [cardInString substringWithRange:NSMakeRange(0, 1)];
        card.color = [cardInString substringWithRange:NSMakeRange(1, 1)];
        card.fill = [cardInString substringWithRange:NSMakeRange(2, 1)];
        card.rank = [[cardInString substringWithRange:NSMakeRange(3, 1)] integerValue];
        NSLog(@"%@", cardInString);
        NSLog(@"%@", card);
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

@end
