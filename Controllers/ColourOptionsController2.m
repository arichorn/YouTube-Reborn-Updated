#import "ColourOptionsController.h"
#import "ColourOptionsController2.h"
#import "Localization.h"

@interface ColourOptionsController2 ()
- (void)coloursView;
@end

@implementation ColourOptionsController2

- (void)loadView {
	[super loadView];
    [self coloursView];

    self.title = LOC(@"COLOR_OPTIONS_2");
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    self.navigationItem.leftBarButtonItem = doneButton;

    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButton;

    self.supportsAlpha = NO;
    NSData *lcmColorData = [[NSUserDefaults standardUserDefaults] objectForKey:@"kYTLcmColourOptionVFive"];
    NSKeyedUnarchiver *lcmUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:lcmColorData error:nil];
    [lcmUnarchiver setRequiresSecureCoding:NO];
    UIColor *color = [lcmUnarchiver decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    self.selectedColor = color;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    [self coloursView];
}

@end

@implementation ColourOptionsController2(Privates)

- (void)done {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)save {
    NSData *lcmColorData = [NSKeyedArchiver archivedDataWithRootObject:self.selectedColor requiringSecureCoding:nil error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:lcmColorData forKey:@"kYTLcmColourOptionVFive"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    UIAlertController *alertSaved = [UIAlertController alertControllerWithTitle:@"Colour Saved" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertSaved addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];

    [self presentViewController:alertSaved animated:YES completion:nil];
}

@end