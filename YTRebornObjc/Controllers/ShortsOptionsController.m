#import "ShortsOptionsController.h"

#define BOOL_FOR_KEY(KEY) [[NSUserDefaults standardUserDefaults] boolForKey:KEY]
#define SET_BOOL_FOR_KEY(KEY, VALUE) [[NSUserDefaults standardUserDefaults] setBool:VALUE forKey:KEY]; [[NSUserDefaults standardUserDefaults] synchronize];

#define TOGGLE_SETTING(KEY, SENDER) \
if ([SENDER isOn]) { \
    SET_BOOL_FOR_KEY(KEY, YES); \
} else { \
    SET_BOOL_FOR_KEY(KEY, NO); \
}

#define CREATE_SWITCH(NAME, SELECTOR, KEY) \
UISwitch *NAME = [[UISwitch alloc] initWithFrame:CGRectZero]; \
[NAME addTarget:self action:@selector(SELECTOR:) forControlEvents:UIControlEventValueChanged]; \
NAME.on = BOOL_FOR_KEY(KEY);\
cell.accessoryView = NAME;

@interface ShortsOptionsController ()
- (void)coloursView;
@end

@implementation ShortsOptionsController

- (void)loadView {
    [super loadView];
    [self coloursView];

    self.title = @"Shorts Options";

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.rightBarButtonItem = doneButton;

    [self.tableView setSectionHeaderTopPadding:0.0f];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShortsTableViewCell"];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
            cell.textLabel.textColor = [UIColor blackColor];
            cell.detailTextLabel.textColor = [UIColor blackColor];
        } else {
            cell.backgroundColor = [UIColor colorWithRed:0.110 green:0.110 blue:0.118 alpha:1.0];
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.detailTextLabel.textColor = [UIColor whiteColor];
        }
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Hide Like Button";
            CREATE_SWITCH(hideShortsLikeButton, toggleHideShortsLikeButton, @"kHideShortsLikeButton");
        }
        if (indexPath.row == 1) {
            cell.textLabel.text = @"Hide Dislike Button";
            CREATE_SWITCH(hideShortsDislikeButton, toggleHideShortsDislikeButton, @"kHideShortsDislikeButton");
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = @"Hide Comments Button";
            CREATE_SWITCH(hideShortsCommentsButton, toggleHideShortsCommentsButton, @"kHideShortsCommentsButton");
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = @"Hide Share Button";
            CREATE_SWITCH(hideShortsShareButton, toggleHideShortsShareButton, @"kHideShortsShareButton");
        }
        if (indexPath.row == 4) {
            cell.textLabel.text = @"Hide More Actions Button";
            CREATE_SWITCH(hideShortsMoreActionsButton, toggleHideShortsMoreActionsButton, @"kHideShortsMoreActionsButton");
        }
    }
    return cell;
}

- (void)coloursView {
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
        self.view.backgroundColor = [UIColor colorWithRed:0.949 green:0.949 blue:0.969 alpha:1.0];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    } else {
        self.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self coloursView];
    [self.tableView reloadData];
}

@end

@implementation ShortsOptionsController (Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)toggleHideShortsMoreActionsButton:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideShortsMoreActionsButton", sender);
}

- (void)toggleHideShortsLikeButton:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideShortsLikeButton", sender);
}

- (void)toggleHideShortsDislikeButton:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideShortsDislikeButton", sender);
}

- (void)toggleHideShortsCommentsButton:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideShortsCommentsButton", sender);
}

- (void)toggleHideShortsShareButton:(UISwitch *)sender {
    TOGGLE_SETTING(@"kHideShortsShareButton", sender);
}

@end
