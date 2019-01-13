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
#import <math.h>

@implementation SZGMFMesh (Helper)

- (GLKVector3) vertexForVertexIndex:(NSNumber*)vertexIndex
{
    GLKVector3 vertex_V3 = GLKVector3Make(0, 0, 0);
    long long vertexIndexLL = [vertexIndex longLongValue];
    
    if (vertexIndexLL < [self.vertices count] + 1)
    {
        NSValue* vertex = self.vertices[vertexIndexLL - 1];
        [vertex getValue:&vertex_V3];
    }
    
    return vertex_V3;
}

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
            
            GLKVector3 vertex1_V3 = [self vertexForVertexIndex: face.vertexIndices[i]];
            GLKVector3 vertex2_V3 = [self vertexForVertexIndex: face.vertexIndices[j]];
            
            cross = GLKVector3Add(cross, GLKVector3CrossProduct(vertex1_V3, vertex2_V3));
        }
        cross = GLKVector3DivideScalar(cross, 2);
        faceArea = GLKVector3Distance(cross, GLKVector3Make(0, 0, 0));
        
        // And just add them together
        area += faceArea;
    }
    return area;
}

- (float) calculateVolume
{
    float meshVolume = 0.0f;
    // Go through all the faces
    for (SZGMFFace* face in self.faces)
    {
        float faceVolume = 0.0f;
        
        // Calculate the faces volume
        for (int i = 0; i < [face.vertexIndices count]; i+=3)
        {
            if (i+2 < [face.vertexIndices count])
            {
                GLKVector3 vertex1_V3 = [self vertexForVertexIndex: face.vertexIndices[i]];
                GLKVector3 vertex2_V3 = [self vertexForVertexIndex: face.vertexIndices[i+1]];
                GLKVector3 vertex3_V3 = [self vertexForVertexIndex: face.vertexIndices[i+2]];
                
                faceVolume += [self volumeForTriangle:vertex1_V3 position2:vertex2_V3 position3:vertex3_V3];
            }
        }
        
        // Add them together
        meshVolume += faceVolume;
    }
    return fabsf(meshVolume);
}

- (float) volumeForTriangle:(GLKVector3)position1 position2:(GLKVector3)position2 position3:(GLKVector3)position3
{
    float vector321 = position3.x * position2.y + position1.z;
    float vector231 = position2.x * position3.y + position1.z;
    float vector312 = position3.x * position1.y + position2.z;
    float vector132 = position1.x * position3.y + position2.z;
    float vector213 = position2.x * position1.y + position3.z;
    float vector123 = position1.x * position2.y + position3.z;
    return (1.0f / 6.0f) * (vector123 + vector231 + vector312 - vector321 - vector132 - vector213);
}

@end
