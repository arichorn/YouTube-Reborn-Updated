#import "ReorderPivotBarController.h"
#import "Localization.h"

@interface ReorderPivotBarController ()

@property (nonatomic, strong) NSMutableArray *tabOrder;

@end

@implementation ReorderPivotBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
    self.title = LOC(@"REORDER_TABS");
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    UIBarButtonItem *resetButton = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(reset)];
    self.navigationItem.rightBarButtonItems = @[doneButton, saveButton];
    self.navigationItem.leftBarButtonItems = @[resetButton];

    UITableViewStyle style;
        if (@available(iOS 13, *)) {
            style = UITableViewStyleInsetGrouped;
        } else {
            style = UITableViewStyleGrouped;
        }

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tabOrder = [NSMutableArray arrayWithObjects:@"Home", @"Shorts", @"Create", @"Subscriptions", @"You", nil];
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.tableView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.tableView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
        [self.tableView.heightAnchor constraintEqualToAnchor:self.view.heightAnchor]
    ]];
    
    NSArray *savedTabOrder = [[NSUserDefaults standardUserDefaults] objectForKey:@"kTabOrder"];
    if (savedTabOrder != nil) {
        self.tabOrder = [NSMutableArray arrayWithArray:savedTabOrder];
}

- (void)setupView {
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 5;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TabBarTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor blackColor];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:0.110 green:0.110 blue:0.118 alpha:1.0];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.textLabel.shadowColor = [UIColor blackColor];
            cell.textLabel.shadowOffset = CGSizeMake(1.0, 1.0);
            cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
    }
    
if (indexPath.section == 1) {
    if (indexPath.row == 0) {
        cell.textLabel.text = @"Home";
    } else if (indexPath.row == 1) { 
        cell.textLabel.text = @"Shorts";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"Create";
    } else if (indexPath.row == 3) {
        cell.textLabel.text = @"Subscriptions";
    } else if (indexPath.row == 4) {
        cell.textLabel.text = @"You";
    }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setTabItemsWithOrder:(NSArray *)order {
    NSMutableArray *reorderedTabs = [NSMutableArray arrayWithArray:self.tabOrder];
    for (NSString *tabItem in order) {
        NSInteger index = [self.tabOrder indexOfObject:tabItem];
        if (index != NSNotFound) {
            [reorderedTabs replaceObjectAtIndex:index withObject:tabItem];
        }
    }
}
- (void)reset {
    self.tabOrder = [NSMutableArray arrayWithObjects:@"Home", @"Shorts", @"Create", @"Subscriptions", @"You"];
    [self.tableView reloadData];
    [self save];
}
- (void)save {
    [[NSUserDefaults standardUserDefaults] setObject:self.tabOrder forKey:@"kTabOrder"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)done {   
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
