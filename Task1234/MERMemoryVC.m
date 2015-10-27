//
//  MERMemoryVC.m
//  Task1234
//
//  Created by George Malushkin on 14/10/15.
//  Copyright © 2015 George Malushkin. All rights reserved.
//

#import "MERMemoryVC.h"
#import "MERMemoryCardV.h"
#import "MERMemoryEngine.h"

@interface MERMemoryVC () <CardDelegate>
@property (strong, nonatomic) MERMemoryEngine *model;
@property (strong, nonatomic) IBOutletCollection(MERMemoryCardV) NSArray *memoryCards;
@property (weak, nonatomic) IBOutlet UILabel *scoresLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeGameSegment;
@end

@implementation MERMemoryVC

#pragma mark - Properties
- (MERMemoryEngine *)model
{
    if (!_model) {
        _model = [[MERMemoryEngine alloc] init];
    }
    return _model;
}


- (void)drawPlayingCards
{
    // Start game
    [self.model generateTabledCards:[_memoryCards count]];
    
    for (int i = 0; i < [self.model.tabledCards count]; i++) {
        MERMemoryCardV *card = self.memoryCards[i];
        MERMemoryCardV *cardModel = self.model.tabledCards[i];
        card.suit = cardModel.suit;
        card.rank = cardModel.rank;
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
    if ([sender isKindOfClass:[MERMemoryCardV class]]) {
        //NSLog(@"%@", senderObj.suit);
        [self.model addCardToMatchingList:sender];
        
        MERMemoryCardV *card = sender;
        card.faceUP = TRUE;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateUI];
        });
    }
}

- (void)updateUI
{
    for (int i = 0; i < [self.model.tabledCards count]; i++) {
        MERMemoryCardV *card = self.memoryCards[i];
        MERMemoryCardV *cardModel = self.model.tabledCards[i];
        card.faceUP = cardModel.faceUP;
        card.isMatch = cardModel.isMatch;
    }
    self.scoresLabel.text = [NSString stringWithFormat:@"Scores: %ld", (long)self.model.scores];
}


@end
