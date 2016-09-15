//
//  LLCollectionViewCell.h
//  LinkedList
//
//  Created by Rahul Aru on 9/15/16.
//  Copyright © 2016 Rahul Deb Aru. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLCollectionViewCellDelegate <NSObject>



@end


@interface LLCollectionViewCell : UICollectionViewCell

@property (assign, nonatomic) BOOL editing;

- (IBAction)didTapDeleteButton:(id)sender;
- (void) setData:(NSString*) theData;

@end
