//
//  ViewController.m
//  LinkedList
//
//  Created by Rahul Aru on 9/14/16.
//  Copyright © 2016 Rahul Deb Aru. All rights reserved.
//

#import "ViewController.h"
#import "LinkedList.h"
#import "Node.h"
#import "LLCollectionViewCell.h"
#import "UIView+Toast.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextField *txtData;
@property (weak, nonatomic) IBOutlet UITextField *txtPosition;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;

- (IBAction)didTapAdd:(id)sender;
- (IBAction)didTapEdit:(id)sender;

@property (strong, nonatomic) LinkedList* list;
@property (assign, nonatomic) BOOL isEditMode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.list = [[LinkedList alloc] init];
    self.isEditMode = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapEdit:(id)sender {
    if(!self.isEditMode) {
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTapEdit:)];
        self.navigationItem.rightBarButtonItem = barButton;
        self.isEditMode = YES;
    } else {
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(didTapEdit:)];
        self.navigationItem.rightBarButtonItem = barButton;
        self.isEditMode = NO;
    }
    
    [self.collectionView reloadData];
}

- (IBAction)didTapAdd:(id)sender {
    
    int position = [self.txtPosition.text intValue];
    if(position)
    {
        [self.list insert:self.txtData.text atPosition:position];
        [self.collectionView reloadData];
        [self.view makeToast:@"New node inserted"];
    }
    else
    {
        [self.list add:self.txtData.text];
        [self.collectionView reloadData];
        [self.view makeToast:@"New node added"];
    }
    self.txtData.text = @"";
    self.txtPosition.text = @"";
}

#pragma mark - COLLECTION VIEW


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(!self.list.count)
        return 0;
    return (self.list.count /** 2 - 1*/);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"CollectionViewDataCellID";
    
    LLCollectionViewCell *cell = (LLCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    Node* node = [self.list getNodeAtPosition:((int)indexPath.row+1)];
    if(node) {
        [cell setData:node.data];
        [cell setEditing:self.isEditMode];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    int count = self.list.count;
    int maxNumOfItems = collectionView.frame.size.width/50;
    int width = 50 + 10;
    if (count <= maxNumOfItems) {
        width = collectionView.frame.size.width/count;
    }
    return CGSizeMake(width, self.collectionView.frame.size.height);
}

@end
