//
//  SFDataTableViewController.m
//  Congress
//
//  Created by Daniel Cloud on 2/26/13.
//  Copyright (c) 2013 Sunlight Foundation. All rights reserved.
//

#import "SFDataTableViewController.h"

@interface SFDataTableViewController ()
{
    SFDataTableSectionIndexTitleGenerator _sectionIndexTitleGenerator;
    SFDataTableSectionForSectionIndexHandler _sectionIndexHandler;
}

@end

@implementation SFDataTableViewController
{
    SFDataTableSectionIndexTitleGenerator _sectionIndexTitleGenerator;
    SFDataTableSectionForSectionIndexHandler _sectionIndexHandler;
}

@synthesize items = _items;
@synthesize sections = _sections;
@synthesize sectionTitles = _sectionTitles;
@synthesize sectionIndexTitles = _sectionIndexTitles;
@synthesize sortIntoSectionsBlock;
@synthesize sectionTitleGenerator;
@synthesize orderItemsInSectionsBlock;
@synthesize cellForIndexPathHandler;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.items = @[];
        self.sections = nil;
        self.sectionTitles = nil;
        self.sectionIndexTitles = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.dataSource = self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (!_sections || [_sections count] == 0) {
        return 1;
    }
    return [_sections count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([_sectionTitles count]) {
        return [_sectionTitles objectAtIndex:section];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (self.sections && self.sections[section]) {
        return [self.sections[section] count];
    }
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cellForIndexPathHandler) {
        return cellForIndexPathHandler(indexPath);
    }
    // If a cellForIndexPathHandler is not set, then a subclass should override thise method.
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _sectionIndexTitles;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (self.sectionIndexTitles && _sectionIndexHandler) {
        return _sectionIndexHandler(title, index, _sectionTitles);
    }
    return 0;
}

#pragma mark - SFDataTableViewController

- (void)setItems:(NSArray *)pItems
{
    _items = pItems;
    if (!self.sortIntoSectionsBlock) {
        _sections = @[_items];
    }
}

- (void)setSectionTitleGenerator:(SFDataTableSectionTitleGenerator)pSectionTitleGenerator
                sortIntoSections:(SFDataTableSortIntoSectionsBlock)pSectionSorter
            orderItemsInSections:(SFDataTableOrderItemsInSectionsBlock)pOrderItemsInSectionsBlock
         cellForIndexPathHandler:(SFDataTableCellForIndexPathHandler)pCellForIndexPathHandler
{
    self.sectionTitleGenerator = pSectionTitleGenerator;
    self.sortIntoSectionsBlock = pSectionSorter;
    if (pOrderItemsInSectionsBlock) {
        self.orderItemsInSectionsBlock = pOrderItemsInSectionsBlock;
    }
    if (pCellForIndexPathHandler) {
        self.cellForIndexPathHandler = pCellForIndexPathHandler;
    }
}

- (void)setSectionIndexTitleGenerator:(SFDataTableSectionIndexTitleGenerator)pSectionIndexTitleGenerator
                  sectionIndexHandler:(SFDataTableSectionForSectionIndexHandler)pSectionForSectionIndexHandler
{
    _sectionIndexTitleGenerator = pSectionIndexTitleGenerator;
    _sectionIndexHandler = pSectionForSectionIndexHandler;
}

- (void)reloadTableView
{
    [self.tableView reloadData];
}

- (void)sortItemsIntoSections
{
    if (self.sectionTitleGenerator && self.sortIntoSectionsBlock) {
        self.sectionTitles = sectionTitleGenerator(self.items);

        NSMutableArray *mutableSections = [NSMutableArray arrayWithCapacity:[self.sectionTitles count]];
        for (int i = 0; i < [self.sectionTitles count]; i++) {
            [mutableSections addObject:[NSMutableArray array]];
        }

        for (id item in self.items) {
            NSUInteger sectionNum = self.sortIntoSectionsBlock(item, self.sectionTitles);
            NSMutableArray *section = [mutableSections objectAtIndex:sectionNum];
            [section addObject:item];
        }
        if (self.orderItemsInSectionsBlock) {
            for (NSUInteger i=0; i < [mutableSections count]; i++) {
                NSArray *sortedSection = self.orderItemsInSectionsBlock([NSArray arrayWithArray:[mutableSections objectAtIndex:i]]);
                [mutableSections replaceObjectAtIndex:i withObject:sortedSection];
            }
        }
        self.sections = [NSArray arrayWithArray:mutableSections];
        if (_sectionIndexTitleGenerator) {
            self.sectionIndexTitles = _sectionIndexTitleGenerator(self.sectionTitles);
        }
    }
}

- (void)sortItemsIntoSectionsAndReload
{
    [self sortItemsIntoSections];
    [self reloadTableView];
}

@end
