//
//  SZGMFMesh+Helper.m
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import "SZGMFMesh+Helper.h"
#import "SZGMFFace.h"
#import "SZGMFFace+Helper.h"

@implementation SZGMFMesh (Helper)

- (void) triangulateFaces
{
    // We need to recalculate the faces array, this is where we will collect them
    NSMutableArray* triangulatedFaces = [[NSMutableArray alloc] init];
    
    // Go through all the faces
    for (SZGMFFace* face in self.faces)
    {
        // Triangulate them
        [face triangulate];
        if ([face.vertexIndices count] == 3)
        {
            // If we have only 3 indices after triangulation we have nothing else to do (it was already triangulated)
            [triangulatedFaces addObject:face];
        }
        else
        {
            // If we have more than 3 indices it means the triangulation split the inidices into triangles
            for (int i = 0; i < [face.vertexIndices count]; i+=3)
            {
                // Take 3 elements from each indices array and add the to the new indices
                NSArray* newFaceVertexIndices = [face.vertexIndices subarrayWithRange:NSMakeRange(i, 3)];
                
                // The normals and uvs can be empty/or partial so we need to check if that is the case first
                NSArray* newFaceNormalIndices = [[NSArray alloc] init];
                if ([face.normalIndices count] > i + 3)
                {
                    newFaceNormalIndices = [face.normalIndices subarrayWithRange:NSMakeRange(i, 3)];
                }
                NSArray* newFaceUVIndices = [[NSArray alloc] init];
                if ([face.uvIndices count] > i + 3)
                {
                    newFaceUVIndices = [face.uvIndices subarrayWithRange:NSMakeRange(i, 3)];
                }
                
                // Create the new face for the triangle
                SZGMFFace* newFace = [[SZGMFFace alloc] initWithVertexIndices:newFaceVertexIndices uvIndices:newFaceUVIndices normalIndices:newFaceNormalIndices];
                
                // And add them to the generated faces
                [triangulatedFaces addObject:newFace];
            }
        }
    }
    // Finally replace the old faces array with the new one
    self.faces = triangulatedFaces;
}

- (float) calculateSurfaceArea
{
    float area = 0.0f;
    // Go through all the faces
    for (SZGMFFace* face in self.faces)
    {
        float faceArea = 0.0f;
        int j = 0;
        GLKVector3 cross = GLKVector3Make(0, 0, 0);
        
        // Calculate the faces area separately
        for (int i = 0; i < [face.vertexIndices count]; i++)
        {
            j = (i + 1) % [face.vertexIndices count];
            
            GLKVector3 vertex1_V3;
            GLKVector3 vertex2_V3;
            
            long long vertexIndex1 = [face.vertexIndices[i] longLongValue];
            NSValue* vertex1 = self.vertices[vertexIndex1 - 1];
            [vertex1 getValue:&vertex1_V3];
            
            long long vertexIndex2 = [face.vertexIndices[j] longLongValue];
            NSValue* vertex2 = self.vertices[vertexIndex2 - 1];
            [vertex2 getValue:&vertex2_V3];
            
            cross = GLKVector3Add(cross, GLKVector3CrossProduct(vertex1_V3, vertex2_V3));
        }
        cross = GLKVector3DivideScalar(cross, 2);
        faceArea = GLKVector3Distance(cross, GLKVector3Make(0, 0, 0));
        
        // And jsut add them together
        area += faceArea;
    }
    return area;
}

@end
