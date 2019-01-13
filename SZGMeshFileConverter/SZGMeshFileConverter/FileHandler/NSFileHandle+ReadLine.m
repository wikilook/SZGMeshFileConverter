//
//  NSFileHandle+ReadLine.m
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

// define the constants
#define ENDLINE_STRING @"\n"
#define LINEBUFFER_SIZE 256

#import "NSFileHandle+ReadLine.h"

@implementation NSFileHandle (ReadLine)

-(NSString*) readLine
{
    NSData* endLineData = [[NSString stringWithFormat:ENDLINE_STRING] dataUsingEncoding:NSASCIIStringEncoding];
    
    NSData* lineData = [[NSMutableData alloc] init];
    BOOL keepReading = YES;
    NSData* buffer;
    
    // While we did not find an endline string in the read chunk, keep reading
    while (keepReading)
    {
        buffer = [self readDataOfLength:LINEBUFFER_SIZE];
        
        if ([buffer length] != 0)
        {
            NSRange endLineRange = [buffer rangeOfData: endLineData options:0 range:NSMakeRange(0, [buffer length])];
            if (endLineRange.location != NSNotFound)
            {
                // Found the endline string in the buffer
                // Set the file seek position after the line
                NSRange subRange = NSMakeRange(0, [endLineData length] + endLineRange.location);
                unsigned long long offset = [self offsetInFile] - [buffer length] + [endLineData length] + endLineRange.location;
                [self seekToFileOffset:offset];
                
                // And get the line data of course
                lineData = [buffer subdataWithRange:subRange];
                keepReading = NO;
            }
            
        }
        else
        {
            // Reached the end of file
            break;
        }
    }
    
    return [[NSString alloc] initWithData:lineData encoding:NSASCIIStringEncoding];
}

@end
