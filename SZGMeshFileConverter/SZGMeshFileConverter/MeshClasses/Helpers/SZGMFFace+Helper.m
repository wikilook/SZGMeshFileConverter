//
//  SZGMFFace+Helper.m
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import "SZGMFFace+Helper.h"

@implementation SZGMFFace (Helper)

- (void) triangulate
{
    // Triangulate all the 3 indices arrays
    self.vertexIndices = [self triangulateIndices: self.vertexIndices];
    self.normalIndices = [self triangulateIndices: self.normalIndices];
    self.uvIndices = [self triangulateIndices: self.uvIndices];
}

- (NSMutableArray*) triangulateIndices:(NSArray*)indices
{
    // A pretty simple triangulation algorithm, works reliably in convex/coplanar
    // Basically we use the first vertex as a common vertex
    // We connect each vertex and the next one to the first 
    NSMutableArray* triangulatedVertexIndices = [[NSMutableArray alloc] init];
    
    if ([indices count] > 0)
    {
        for (int j = 1; j < [indices count] - 1; j++)
        {
            NSNumber* corner0 = indices[0];
            NSNumber* corner1 = indices[j];
            NSNumber* corner2 = indices[j+1];
            [triangulatedVertexIndices addObject: corner0];
            [triangulatedVertexIndices addObject: corner1];
            [triangulatedVertexIndices addObject: corner2];
        }
    }
    
    return triangulatedVertexIndices;
}

@end
