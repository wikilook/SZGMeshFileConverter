//
//  ViewController.m
//  SZGMeshFileConverterSampleApplication
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import "ViewController.h"
#import <SZGMeshFileConverter/SZGMeshFileConverter.h>

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)openPushed:(id)sender {
    NSOpenPanel* openPanel = [NSOpenPanel openPanel];
    
    [openPanel setCanChooseFiles:YES];
    [openPanel setCanChooseDirectories:NO];
    [openPanel setAllowsMultipleSelection:NO];
    
    if ([openPanel runModal] == NSModalResponseOK)
    {
        NSString* filePath = [[openPanel URL] path];
        _openedFileLabel.stringValue = filePath;
    }
}

- (IBAction)convert:(NSButton *)sender {
    if ([_openedFileLabel.stringValue isEqualToString:@""])
    {
        [_logView insertText:@"input file empty"];
    }
    else
    {
        NSSavePanel* savePanel = [NSSavePanel savePanel];
        
        if ([savePanel runModal] == NSModalResponseOK)
        {
            NSString* filePath = [[savePanel URL] path];
            
            SZGMFConverterManager* converter = [[SZGMFConverterManager alloc] init];
            [converter convertFileWithPath:_openedFileLabel.stringValue output: filePath];
        }
    }
}

@end
