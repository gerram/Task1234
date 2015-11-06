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
//#import "Grid.h"

@interface MERMemoryVC () <CardDelegate>
@property (strong, nonatomic) MERMemoryEngine *model;
//@property (nonatomic) Grid *grid;

@property (strong, nonatomic) IBOutletCollection(MERMemoryCardV) NSArray *memoryCards;
@property (weak, nonatomic) IBOutlet UILabel *scoresLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeGameSegment;
@property (weak, nonatomic) NSTimer *timer;

@end

@implementation MERMemoryVC
- (IBAction)doSegment:(id)sender {
    NSInteger clickedSegment = [sender selectedSegmentIndex];
    switch (clickedSegment) {
        case 0:
        {
            self.model.gameMode = GameModeNormal;
            break;
        }
        case 1:
        {
            self.model.gameMode = GameModeEasy;
            break;
        }
        default:
            self.model.gameMode = GameModeNormal;
            break;
    }
}

#pragma mark - Properties
- (MERMemoryEngine *)model
{
    if (!_model) {
        _model = [[MERMemoryEngine alloc] init];
    }
    return _model;
}

/*
- (Grid *)grid
{
    if (!_grid) {
        _grid = [[Grid alloc] init];
        _grid.size = [UIScreen mainScreen].bounds.size;
        _grid.cellAspectRatio = 3.0 / 4.0;
        _grid.minimumNumberOfCells = 15;
        
        // Optional
        _grid.minCellHeight = 50.0;
        _grid.maxCellHeight = 50.0;
    }
    return _grid;
}
*/

- (void)drawPlayingCards
{
    // Start game
    [self.model generateTabledCards:[_memoryCards count]];
    
    [self.model.tabledCards enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        MERMemoryCardV *card = self.memoryCards[idx];
        MERMemoryCardV *cardModel = self.model.tabledCards[idx];
        card.suit = cardModel.suit;
        card.rank = cardModel.rank;
        card.delegate = self;
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self drawPlayingCards];
    //self.scoresLabel.text = 0;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Timer
- (void)fireTimer:(NSTimer *)timer
{
    
}


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
        card.isPlayed = cardModel.isPlayed;
    }
    self.scoresLabel.text = [NSString stringWithFormat:@"Scores: %ld", (long)self.model.scores];
}




@end
