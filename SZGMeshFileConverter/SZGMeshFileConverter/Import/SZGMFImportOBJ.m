//
//  SZGMFImportOBJ.m
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import "SZGMFImportOBJ.h"
#import "NSFileHandle+ReadLine.h"
#import "SZGMFFace.h"

@implementation SZGMFImportOBJ

- (SZGMFMesh*) importFileWithPath:(NSString*)filePath
{
    // Inititalize the arrays where we store the data read
    [self initData];
    
    // Get a filehandle and set it to the start of the file we want to read
    NSFileHandle* file = [NSFileHandle fileHandleForReadingAtPath:filePath];
    [file seekToFileOffset:0];
    
    if (file != nil)
    {
        unsigned long long currentPos = [file offsetInFile];
        unsigned long long fileLength = [file seekToEndOfFile];
        [file seekToFileOffset:currentPos];
        
        // Need to check if we are at the end of the file
        while (currentPos < fileLength)
        {
            // Reading the file line by line
            NSString* line = [file readLine];
            
            // And parsing them right away
            [self parseLine:line];
            
            currentPos = [file offsetInFile];
        }
    }
    
    [file closeFile];
    
    //NSLog(@"imported %lu vertices, %lu uvs, %lu normals, %lu faces", [vertices count], [uvs count], [normals count], [faces count]);
    
    return [[SZGMFMesh alloc] initWithVertices:vertices uvs:uvs normals:normals faces:faces];
}

- (void) initData
{
    vertices = [[NSMutableArray alloc] init];
    uvs = [[NSMutableArray alloc] init];
    normals = [[NSMutableArray alloc] init];
    faces = [[NSMutableArray alloc] init];
}


- (void) parseLine:(NSString*) line
{
    // We split the lines to parts separated by white spaces
    NSMutableArray* lineParts = [[line componentsSeparatedByString:@" "] mutableCopy];
    
    // If there are multiple whitespaces we need to remove the empty parts
    [lineParts removeObject:@""];
    
    if ([lineParts count] > 1)
    {
        // The first "word" will determine what kind of data is in the line (v, vt, vn, f)
        NSString* lineType = lineParts[0];
        
        if ([lineType isEqualToString:@"v"] && [lineParts count] >= 4)
        {
            // If the data is a vertex read the 3 somponents of it into a GLKVector3 and store it in an NSValue
            GLKVector3 vertex = GLKVector3Make([lineParts[1] floatValue], [lineParts[2] floatValue], [lineParts[3] floatValue]);
            
            // Add it to the vertices
            [vertices addObject:[NSValue valueWithBytes:&vertex objCType:@encode(GLKVector3)]];
        }
        else if ([lineType isEqualToString:@"vn"] && [lineParts count] >= 4)
        {
            // Same as before
            GLKVector3 vertex = GLKVector3Make([lineParts[1] floatValue], [lineParts[2] floatValue], [lineParts[3] floatValue]);
            
            [normals addObject:[NSValue valueWithBytes:&vertex objCType:@encode(GLKVector3)]];
        }
        else if ([lineType isEqualToString:@"vt"])
        {
            // Texture coordinates have optional parts so we need to check how many parts we actually have int the line
            // The default vector is (0,0,0)
            GLKVector3 vertex = GLKVector3Make(0.0f, 0.0f, 0.0f);
            if ([lineParts count] == 2)
            {
                vertex.x = [lineParts[1] floatValue];
            }
            else if ([lineParts count] == 3)
            {
                vertex.x = [lineParts[1] floatValue];
                vertex.y = [lineParts[2] floatValue];
            }
            else if ([lineParts count] == 4)
            {
                vertex.x = [lineParts[1] floatValue];
                vertex.y = [lineParts[2] floatValue];
                vertex.z = [lineParts[3] floatValue];
            }
            
            // Add them to the uvs
            [uvs addObject:[NSValue valueWithBytes:&vertex objCType:@encode(GLKVector3)]];
        }
        else if ([lineType isEqualToString:@"f"])
        {
            // Faces are a bit more complex, but just a bit
            // They can store up to 3 indices per part separated by '/' characters
            NSMutableArray* faceVertexIndices = [[NSMutableArray alloc] init];
            NSMutableArray* faceUVIndices = [[NSMutableArray alloc] init];
            NSMutableArray* faceNormalIndices = [[NSMutableArray alloc] init];
            
            // Loop through the parts of the line
            for (int i = 1; i < MIN([lineParts count], 4); i++)
            {
                NSString* linePart = lineParts[i];
                
                // Split each part separated by '/'
                NSArray* faceParts = [linePart componentsSeparatedByString:@"/"];
                
                // Apart from the first part the rest is optional as well so we need to check them
                // And add the ones that are there
                if ([faceParts count] == 1)
                {
                    [faceVertexIndices addObject: [NSNumber numberWithLongLong:[faceParts[0] longLongValue]]];
                }
                else if ([faceParts count] == 2)
                {
                    [faceVertexIndices addObject: [NSNumber numberWithLongLong:[faceParts[0] longLongValue]]];
                    [faceUVIndices addObject: [NSNumber numberWithLongLong:[faceParts[1] longLongValue]]];
                }
                else if ([faceParts count] == 3)
                {
                    [faceVertexIndices addObject: [NSNumber numberWithLongLong:[faceParts[0] longLongValue]]];
                    [faceUVIndices addObject: [NSNumber numberWithLongLong:[faceParts[1] longLongValue]]];
                    [faceNormalIndices addObject: [NSNumber numberWithLongLong:[faceParts[2] longLongValue]]];
                }
            }
            
            // Create a new face from the line data, abd add it to the faces
            [faces addObject:[[SZGMFFace alloc] initWithVertexIndices:faceVertexIndices uvIndices:faceUVIndices normalIndices:faceNormalIndices]];
        }
    }
}

@end
