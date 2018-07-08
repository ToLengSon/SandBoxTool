//
//  SBPopoverVC.m
//  SandBoxTool
//
//  Created by wsong on 2018/3/27.
//  Copyright © 2018年 zbjt. All rights reserved.
//

#import "SBPopoverVC.h"
#import "SBSimulator.h"
#import "SBApp.h"
#import "SBTools.h"

@interface SBPopoverVC ()
<NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (weak) IBOutlet NSOutlineView *outlineView;

@property (nonatomic, strong) NSMutableArray<SBSimulator *> *simulatorList;

@property (weak) IBOutlet NSView *emptyView;

@end

@implementation SBPopoverVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(outlineViewSelectionDidChange:)
                                                 name:NSOutlineViewSelectionDidChangeNotification
                                               object:nil];
}

- (void)viewWillAppear {
    [super viewWillAppear];
    // 进入视图时直接获取应用焦点
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)outlineViewSelectionDidChange:(NSNotification *)note {
    
    SBApp *app = [self.outlineView itemAtRow:self.outlineView.selectedRow];
    
    if (app.sandBoxPath) {
        system([NSString stringWithFormat:@"open %@", app.sandBoxPath].UTF8String);
        // 隐藏视图
        if (self.shouldHidden) {
            self.shouldHidden(self);
        }
    }
    [self.outlineView deselectRow:self.outlineView.selectedRow];
}

#pragma mark - <NSOutlineViewDataSource, NSOutlineViewDelegate>
- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item {
    if ([item isKindOfClass:[SBSimulator class]]) {
        return ((SBSimulator *)item).appList.count;
    } else {
        self.emptyView.hidden = self.simulatorList.count > 0;
        return self.simulatorList.count;
    }
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item {
    return [item isKindOfClass:[SBSimulator class]];
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item {
    if ([item isKindOfClass:[SBSimulator class]]) {
        return ((SBSimulator *)item).appList[index];
    } else {
        return self.simulatorList[index];
    }
}

- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    
    NSTableCellView *cell = [outlineView makeViewWithIdentifier:@"cell" owner:self];
    
    cell.textField.stringValue = [NSString stringWithFormat:@"%@(%@)", [item name], [item isKindOfClass:[SBApp class]]? ((SBApp *)item).bundleId : ((SBSimulator *)item).systemVersion];
    return cell;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item {
    return [item isKindOfClass:[SBApp class]];
}

- (IBAction)reload:(id)sender {
    _simulatorList = nil;
    [self.outlineView reloadData];
}

- (IBAction)quit:(NSButton *)sender {
    // 退出app
    [[NSApplication sharedApplication] terminate:self];
}

#pragma mark - Getter
- (NSMutableArray<SBSimulator *> *)simulatorList {
    if (_simulatorList == nil) {
        _simulatorList = [NSMutableArray array];
        
        __block NSData *data = nil;
        
        [SBTools executeCommand:@"xcrun simctl list --json"
                         handle:^(NSString *path) {
                             data = [NSData dataWithContentsOfFile:path];
                         }];
        
        NSDictionary *simulatorListSet = [NSJSONSerialization JSONObjectWithData:data
                                                                         options:NSJSONReadingMutableLeaves
                                                                           error:nil][@"devices"];
        _simulatorList = [NSMutableArray array];
        
        for (NSString *simulatorListKey in simulatorListSet) {
            
            if ([simulatorListKey.lowercaseString hasPrefix:@"ios"] &&
                [simulatorListSet[simulatorListKey] count] > 0) {
                
                for (NSDictionary *simulatorDict in simulatorListSet[simulatorListKey]) {
                    if ([simulatorDict[@"state"] caseInsensitiveCompare:@"booted"] == NSOrderedSame) {
                        SBSimulator *simulator = [SBSimulator simulatorWithDict:simulatorDict];
                        simulator.systemVersion = simulatorListKey;
                        [_simulatorList addObject:simulator];
                    }
                }
            }
        }
    }
    return _simulatorList;
}

@end
