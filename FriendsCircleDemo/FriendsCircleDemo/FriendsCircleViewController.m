//
//  FriendsCircleViewController.m
//  FriendsCircleDemo
//
//  Created by weixb on 2017/8/7.
//  Copyright © 2017年 weixb. All rights reserved.
//

#import "FriendsCircleViewController.h"
#import "FDFeedEntity.h"
#import "FDFeedCell.h"

static NSString *const FriendsCircleCellIdentifier = @"FDFeedCell";

@interface FriendsCircleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)   UITableView     *tableView;
@property (nonatomic, copy)     NSArray         *prototypeEntitiesFromJSON;
@property (nonatomic, strong)   NSMutableArray  *feedEntitySections; // 2d array

@end

@implementation FriendsCircleViewController

#pragma mark - Init
/* init, dealloc */


#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self buildTestDataThen:^{
        self.feedEntitySections = @[].mutableCopy;
        [self.feedEntitySections addObject:self.prototypeEntitiesFromJSON.mutableCopy];
        [self.tableView reloadData];
    }];
}

- (void)buildTestDataThen:(void (^)(void))then {
    // Simulate an async request
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Data from `data.json`
        NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *feedDicts = rootDict[@"feed"];
        
        // Convert to `FDFeedEntity`
        NSMutableArray *entities = @[].mutableCopy;
        [feedDicts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [entities addObject:[[FDFeedEntity alloc] initWithDictionary:obj]];
        }];
        self.prototypeEntitiesFromJSON = entities;
        
        // Callback
        dispatch_async(dispatch_get_main_queue(), ^{
            !then ?: then();
        });
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.feedEntitySections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feedEntitySections[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    FDFeedCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[FDFeedCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    // 加载数据(不能放在willDisplayCell方法中)
    cell.entity = self.feedEntitySections[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *mutableEntities = self.feedEntitySections[indexPath.section];
        [mutableEntities removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - Event response
/* 所有button、gestureRecognizer的响应事件都放在这个区域里面 */


#pragma mark - Private methods
- (NSString *)cellIdentifier:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%zd-%zd", indexPath.section,indexPath.row];
}

#pragma mark - Getters and setters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

@end
