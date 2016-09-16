//
//  LLCollectionViewCell.h
//  LinkedList
//
//  Created by Rahul Aru on 9/15/16.
//  Copyright © 2016 Rahul Deb Aru. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LLCollectionViewCellDelegate <NSObject>

@optional
-(void)didTapDeleteButton:(id)sender;

@end


@interface LLCollectionViewCell : UICollectionViewCell

@property (assign, nonatomic) BOOL editing;
@property (nonatomic, weak) id<LLCollectionViewCellDelegate> cellDelegate;

- (IBAction)didTapDeleteButton:(id)sender;
- (void) setData:(NSString*) theData;

@end
