//
//  LLCollectionViewCell.m
//  LinkedList
//
//  Created by Rahul Aru on 9/15/16.
//  Copyright © 2016 Rahul Deb Aru. All rights reserved.
//

#import "LLCollectionViewCell.h"

@interface LLCollectionViewCell()

@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet UILabel *lblData;

@end


@implementation LLCollectionViewCell


-(void)awakeFromNib
{
    self.lblData.layer.borderWidth = 2.0;
    self.lblData.layer.borderColor = [UIColor grayColor].CGColor;
    self.lblData.layer.cornerRadius = 4;
}

- (IBAction)didTapDeleteButton:(id)sender {
}


-(void)setEditing:(BOOL)editing
{
    self.btnDelete.hidden = !editing;
}

- (void) setData:(NSString*) theData
{
    self.lblData.text = theData;
}

@end
