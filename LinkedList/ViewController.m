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

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, LLCollectionViewCellDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lblEmptyList;

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

-(void)setIsEditMode:(BOOL)mode
{
    _isEditMode = mode;
    self.txtData.enabled = !_isEditMode;
    self.txtPosition.enabled = !_isEditMode;
    self.btnAdd.enabled = !_isEditMode;
    if(_isEditMode)
    {
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didTapEdit:)];
        self.navigationItem.rightBarButtonItem = rightBarButton;
        
        UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(didTapTrash:)];
        self.navigationItem.leftBarButtonItem = leftBarButton;
    }
    else
    {
        UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(didTapEdit:)];
        self.navigationItem.rightBarButtonItem = barButton;
        self.navigationItem.leftBarButtonItem = nil;
    }
    [self.collectionView reloadData];
}

- (IBAction)didTapEdit:(id)sender {
    self.isEditMode = !self.isEditMode;
}

- (IBAction)didTapAdd:(id)sender {
    
    [self.txtData resignFirstResponder];
    [self.txtPosition resignFirstResponder];
    
    if(!self.txtData.text.length)
    {
        [self.view makeToast:@"Data cannot be empty!"];
        return;
    }
    
    int position = [self.txtPosition.text intValue];
    if(position && [self.list insert:self.txtData.text atPosition:position])
    {
        [self.collectionView reloadData];
        [self.view makeToast:@"New node inserted"];
    }
    else if([self.list add:self.txtData.text])
    {
        [self.collectionView reloadData];
        [self.view makeToast:@"New node added"];
    }
    else
        [self.view makeToast:@"Error creating node!"];
    self.txtData.text = @"";
    self.txtPosition.text = @"";
}

- (IBAction)didTapTrash:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"Delete all nodes?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action){
        [self.list clear];
        [self.collectionView reloadData];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action){
    }];
    [alert addAction:cancelAction];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark - COLLECTION VIEW


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(!self.list.count)
    {
        self.lblEmptyList.hidden = NO;
        self.collectionView.hidden = YES;
        return 0;
    }
    self.lblEmptyList.hidden = YES;
    self.collectionView.hidden = NO;
    return (self.list.count * 2 - 1);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier1 = @"CollectionViewDataCellID";
    static NSString *identifier2 = @"CollectionViewArrowCellID";
    
    if(indexPath.row % 2 == 0) {
        LLCollectionViewCell *cell = (LLCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifier1 forIndexPath:indexPath];
        long derivedPosition = indexPath.row / 2 + 1;
        Node* node = [self.list getNodeAtPosition:derivedPosition];
        if(node) {
            [cell setData:node.data];
            [cell setEditing:self.isEditMode];
            [cell setCellDelegate:self];
        }
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier2 forIndexPath:indexPath];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    int count = self.list.count;
    int maxNumOfItems = collectionView.frame.size.width/50;
    int width = 50 + 10;
    if (count <= maxNumOfItems) {
        width = collectionView.frame.size.width/count;
    }
    return CGSizeMake(width, self.collectionView.frame.size.height - 40);
}

-(void)didTapDeleteButton:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    UICollectionViewCell *cell = (UICollectionViewCell *) [self superviewWithClassName:@"LLCollectionViewCell" fromView:button];
    if (cell)
    {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        // do whatever action you need with the indexPath...
        
        long actualIndex = indexPath.row / 2 + 1;
        
        if([self.list removeNodeAtPosition:actualIndex])
        {
            [self.view makeToast:@"Node deleted"];
            [self.collectionView reloadData];
        }
        else
            [self.view makeToast:@"Error deleting node!"];
        
    }
}

#pragma mark - PRIVATE

- (UIView *)superviewWithClassName:(NSString *)className fromView:(UIView *)view
{
    while (view)
    {
        if ([NSStringFromClass([view class]) isEqualToString:className])
        {
            return view;
        }
        view = view.superview;
    }
    return nil;
}


@end
