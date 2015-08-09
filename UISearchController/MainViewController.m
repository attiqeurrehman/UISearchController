//
//  MainViewController.m
//  UISearchController
//
//  Created by Attiqe Ur Rehman on 09/08/2015.
//  Copyright (c) 2015 arbisoft. All rights reserved.
//

#import "MainViewController.h"
#import "SearchResultTableViewController.h"

@interface MainViewController () <UISearchBarDelegate, UISearchControllerDelegate, SearchResultDelegate>

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) SearchResultTableViewController *searchResultTableViewController;

@end


@implementation MainViewController

@synthesize searchController = _searchController;
@synthesize searchResultTableViewController = _searchResultTableViewController;


-(SearchResultTableViewController*) searchTableViewController
{
    if( _searchResultTableViewController== nil) {
        _searchResultTableViewController = [[SearchResultTableViewController alloc] initWithNibName:@"SearchResultTableViewController" bundle:nil];
        _searchResultTableViewController.delegate = self;
    }
    
    return _searchResultTableViewController;
}

-(UISearchController*) searchController
{
    if(_searchController == nil) {
        _searchController = [[UISearchController alloc] initWithSearchResultsController:self.searchTableViewController];
        _searchController.delegate = self;
        [_searchController.searchBar setSearchBarStyle:UISearchBarStyleMinimal];
        _searchController.searchBar.delegate = self;
        _searchController.hidesNavigationBarDuringPresentation = NO;
        [_searchController.searchBar sizeToFit];
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.searchResultsUpdater = self.searchResultTableViewController;
    }
    
    return _searchController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchControllerDelegate

- (void)willPresentSearchController:(UISearchController *)searchController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        searchController.searchResultsController.view.hidden = NO;
    });
}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    searchController.searchResultsController.view.hidden = NO;
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    dispatch_async(dispatch_get_main_queue(), ^{
        searchController.searchResultsController.view.hidden = YES;
    });
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    searchController.searchResultsController.view.hidden = YES;
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

#pragma mark - SearchResultDelegate

- (void)didShowFavourite{
    self.searchController.searchBar.text = @"";
    [self.searchController.searchBar resignFirstResponder];
}

@end
