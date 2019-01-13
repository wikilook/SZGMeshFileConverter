//
//  SZGMFConverterManager.m
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import "SZGMFConverterManager.h"
#import "SZGMFExportSTL.h"
#import "SZGMFImportOBJ.h"
#import "SZGMFExport.h"
#import "SZGMFImport.h"

@implementation SZGMFConverterManager

id<SZGMFExport> exporter;
id<SZGMFImport> importer;

- (void) convertFileWithPath:(NSString*)inputFile output:(NSString*)outputFile inputType:(InputType)inputType outputType:(OutputType)outputType
{
    [self setImporterForInputType:inputType];
    [self setExporterForOutputType:outputType];
    
    [exporter exportFileWithPath:outputFile mesh:[importer importFileWithPath:inputFile]];
}

- (void) convertFileWithPath:(NSString*)inputFile output:(NSString*)outputFile
{
    [self convertFileWithPath:inputFile output:outputFile inputType:OBJ outputType:STL];
}

- (void) setImporterForInputType:(InputType)inputType
{
    switch (inputType) {
        case OBJ:
            importer = [[SZGMFImportOBJ alloc] init];
            break;
            
        default:
            importer = [[SZGMFImportOBJ alloc] init];
            break;
    }
}

- (void) setExporterForOutputType:(OutputType)outputType
{
    switch (outputType) {
        case STL:
            exporter = [[SZGMFExportSTL alloc] init];
            break;
            
        default:
            exporter = [[SZGMFExportSTL alloc] init];
            break;
    }
}

@end
