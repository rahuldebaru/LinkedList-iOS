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

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *txtData;
@property (weak, nonatomic) IBOutlet UITextField *txtPosition;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
- (IBAction)didTapBtnAdd:(id)sender;

@property (strong, nonatomic) LinkedList* list;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.list = [[LinkedList alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapBtnAdd:(id)sender {
    
    int position = [self.txtPosition.text integerValue];
    if(position)
    {
        [self.list insert:self.txtData.text atPosition:position];
        [self.tableView reloadData];
    }
    else
    {
        [self.list add:self.txtData.text];
        [self.tableView reloadData];
    }
}

#pragma mark - TABLE VIEW

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!self.list.count)
        return 0;
    return (self.list.count * 2 - 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LinkedListTableCellID"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"LinkedListTableCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Node* node = [self.list getNodeAtPosition:(indexPath.row+1)];
    if(node) {
        cell.textLabel.text = node.data;
    }
    
    return cell;
}



@end
