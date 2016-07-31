//
//  AddFriendsViewController.m
//  Search
//
//  Created by Sergey Tszyu on 31.07.16.
//  Copyright © 2016 Sergey Tszyu. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "NSString+Users.h"
#import "Section.h"
#import "MemberCell.h"

@interface AddFriendsViewController ()
@property (strong, nonatomic) NSArray *namesArray;
@property (strong, nonatomic) NSArray *sectionsArray;
@property (strong, nonatomic) NSOperation *currentOperation;
@end

@implementation AddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItems];
    [self createTestData];
    
}

- (void) setupNavigationItems {
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor colorWithRed:31.0/255.0 green:31.0/255.0 blue:31.0/255.0 alpha:1];
    
    UIImage *image = [[UIImage imageNamed:@"back.pdf"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.navigationController.navigationItem.title = @"ADD FRIENDS";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Medium" size:12]};
    
    self.tableView.sectionIndexBackgroundColor = [UIColor colorWithRed:31.0/255.0 green:31.0/255.0 blue:31.0/255.0 alpha:1];
    // df
}

- (void) createTestData {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 200; ++i) {
        [array addObject:[[NSString randomAlphanumericString] capitalizedString]];
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:true];
    [array sortUsingDescriptors:@[sortDescriptor]];
    self.namesArray = array;
    [self generateSectionsBackgroundFromArray:self.namesArray withFilter:self.searchBar.text];
}

- (void) backAction:(UIBarButtonItem*)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Private

- (void) generateSectionsBackgroundFromArray:(NSArray*)array withFilter:(NSString*)filterString {
    
    [self.currentOperation cancel];
    
    __weak AddFriendsViewController *weakSelf = self;
    
    self.currentOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSArray *sectionsArray = [weakSelf generateSectionsFromArray:array withFilter:filterString];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.sectionsArray = sectionsArray;
            [weakSelf.tableView reloadData];
            self.currentOperation = nil;
        });
        
    }];
    [self.currentOperation start];
    
}

- (NSArray*) generateSectionsFromArray:(NSArray*)array withFilter:(NSString*)filterString {
    NSMutableArray *sectionsArray = [NSMutableArray array];
    
    NSString *currentLetter = nil;
    for (NSString *string in array) {
        
        if ([filterString length] > 0 && [string rangeOfString:filterString].location == NSNotFound) {
            continue;
        }
        
        NSString *firstLetter = [string substringToIndex:1];
        Section *section = nil;
        
        if (![currentLetter isEqualToString:firstLetter]) {
            section = [[Section alloc] init];
            section.name = firstLetter;
            section.itemsArray = [NSMutableArray array];
            currentLetter = firstLetter;
            [sectionsArray addObject:section];
        } else {
            section = [sectionsArray lastObject];
        }
        [section.itemsArray addObject:string];
    }
    return sectionsArray;
}

#pragma mark - UITableViewDataSource

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *array = [NSMutableArray array];
    for (Section *section in self.sectionsArray) {
        [array addObject:section.name];
    }
    return array;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionsArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.sectionsArray objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    Section *currentSection = [self.sectionsArray objectAtIndex:section];
    return [currentSection.itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MemberCell";
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MemberCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Section *section = [self.sectionsArray objectAtIndex:indexPath.section];
    NSString *name = [section.itemsArray objectAtIndex:indexPath.row];
    cell.name.text = name;
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    
    [headerView setBackgroundColor:[UIColor colorWithRed:31.0/255.0 green:31.0/255.0 blue:31.0/255.0 alpha:1]];
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(10, 8, 320, 11);
    myLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12];
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    myLabel.textColor = [UIColor colorWithRed:0 green:174.0/255.0 blue:239.0/255.0 alpha:1];
    
    [headerView addSubview:myLabel];
    return headerView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:true animated:true];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:false animated:true];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"textDidChange %@", searchText);
    [self generateSectionsBackgroundFromArray:self.namesArray withFilter:searchText];
}


@end
