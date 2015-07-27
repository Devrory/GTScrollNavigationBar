//
//  GTScrollNavigationBarSpec.m
//  GTScrollNavigationBarExample
//
//  Created by Luu Gia Thuy on 7/26/15.
//  Copyright (c) 2015 Luu Gia Thuy. All rights reserved.
//

#import <GTScrollNavigationBar/GTScrollNavigationBar.h>
#import <Specta/Specta.h>
#import <Expecta/Expecta.h>
#import <KIF/KIF.h>

static const CGFloat NavigationBarPortraitMinY = -23.0f;
static const CGFloat NavigationBarPortraitMaxY = 20.0f;

SpecBegin(GTScrollNavigationBar)

describe(@"GTScrollNavigationBar", ^{
    __block GTScrollNavigationBar *navigationBar;
    __block UITableView *tableView;

    beforeAll(^{
        UIView *view = [tester waitForViewWithAccessibilityLabel:@"DemoScrollNavigationBar"].superview;
        XCTAssertTrue([view isKindOfClass:[UINavigationBar class]], @"Found view is not a GTScrollNavigationBar instance!");
        navigationBar = (GTScrollNavigationBar *)view;
        
        view = [tester waitForViewWithAccessibilityLabel:@"DemoTableView"];
        XCTAssertTrue([view isKindOfClass:[UITableView class]], @"Found view is not a UITableView instance!");
        tableView = (UITableView *)view;
    });
    
    beforeEach(^{
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                         atScrollPosition:UITableViewScrollPositionTop
                                 animated:NO];
        [navigationBar resetToDefaultPositionWithAnimation:NO];
    });
    
    it(@"expands fully at start", ^{
        expect(CGRectGetMinY(navigationBar.frame)).to.beCloseTo(NavigationBarPortraitMaxY);
    });
    
    it(@"shrinks when swiping up", ^{
        [tester swipeViewWithAccessibilityLabel:@"DemoTableView" inDirection:KIFSwipeDirectionUp];
        expect(CGRectGetMinY(navigationBar.frame)).to.beCloseTo(NavigationBarPortraitMinY);
    });
    
    it(@"expands when swiping down", ^{
        CGPoint center = tableView.center;
        [tableView dragFromPoint:center toPoint:CGPointMake(center.x, center.y - 15) steps:15];
        [tester swipeViewWithAccessibilityLabel:@"DemoTableView" inDirection:KIFSwipeDirectionDown];
        expect(CGRectGetMinY(navigationBar.frame)).to.beCloseTo(NavigationBarPortraitMaxY);
    });
    
    it(@"shrinks when panning up", ^{
        CGPoint center = tableView.center;
        [tableView dragFromPoint:center toPoint:CGPointMake(center.x, center.y - 12) steps:12];
        [tester waitForTimeInterval:0.3];
        expect(CGRectGetMinY(navigationBar.frame)).to.beCloseTo(NavigationBarPortraitMinY);
    });
    
    it(@"expands when panning down", ^{
        CGPoint center = tableView.center;
        [tableView dragFromPoint:center toPoint:CGPointMake(center.x, center.y - 12) steps:12];
        [tableView dragFromPoint:center toPoint:CGPointMake(center.x, center.y + 12) steps:12];
        [tester waitForTimeInterval:0.3];
        expect(CGRectGetMinY(navigationBar.frame)).to.beCloseTo(NavigationBarPortraitMaxY);
    });
    
    it(@"expands when scrolling to top", ^{
        [tester swipeViewWithAccessibilityLabel:@"DemoTableView" inDirection:KIFSwipeDirectionUp];
        [tester tapStatusBar];
        expect(CGRectGetMinY(navigationBar.frame)).to.beCloseTo(NavigationBarPortraitMaxY);
    });
});

SpecEnd