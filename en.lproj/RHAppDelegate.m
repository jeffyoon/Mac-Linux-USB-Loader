//
//  RHAppDelegate.m
//  RHPreferencesTester
//
//  Originally created by Richard Heard on 23/05/12. Subsequently modified by SevenBits.
//  Copyright (c) 2012-2013 SevenBits. All rights reserved.
//

#import "RHAppDelegate.h"
#import "RHAboutViewController.h"
#import "RHAccountsViewController.h"
#import "RHNotificationViewController.h"

#import "DistributionDownloader.h"

@implementation RHAppDelegate

@synthesize window = _window;
@synthesize preferencesWindowController=_preferencesWindowController;
@synthesize distroPopUpSelector;
@synthesize closeDistroDownloadSheetButton;
@synthesize distroDownloadProgressIndicator;

NSWindow *downloadLinuxDistroSheet;

- (void)dealloc
{
    [_preferencesWindowController release]; _preferencesWindowController = nil;
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

#pragma mark - IBActions
- (IBAction)showPreferences:(id)sender {
    //if we have not created the window controller yet, create it now
    if (!_preferencesWindowController){
        RHAccountsViewController *accounts = [[[RHAccountsViewController alloc] init] autorelease];
        RHAboutViewController *about = [[[RHAboutViewController alloc] init] autorelease];
        RHNotificationViewController *notifications = [[[RHNotificationViewController alloc] init] autorelease];
        
        NSArray *controllers = [NSArray arrayWithObjects:accounts, notifications,
                                [RHPreferencesWindowController flexibleSpacePlaceholderController], 
                                about,
                                nil];
        
        _preferencesWindowController = [[RHPreferencesWindowController alloc] initWithViewControllers:controllers andTitle:NSLocalizedString(@"Preferences", @"Preferences Window Title")];
    }
    
    [_preferencesWindowController showWindow:self];
}

#pragma mark - Distribution Downloader
- (IBAction)showDownloadDistroSheet:(id)sender {
    [NSApp beginSheet:sheet modalForWindow:(NSWindow *)_window modalDelegate:self
       didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (IBAction)closeDownloadDistroSheet:(id)sender {
    [NSApp endSheet:sheet];
    [sheet orderOut:sender];
}

- (IBAction)downloadDistribution:(id)sender {
    [distroDownloadProgressIndicator startAnimation:self];
    NSURL *test = [NSURL URLWithString:@"http://www.ubuntu.com/start-download?distro=desktop&bits=64&release=latest"];
    [[DistributionDownloader new] downloadLinuxDistribution:test:@"/Users/RyanBowring/Desktop/"];
}

- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo {
    // Empty
}

@end
