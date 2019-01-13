//
//  SZGMFMesh.m
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import "SZGMFMesh.h"

@implementation SZGMFMesh

- (instancetype)initWithVertices:(NSArray*)vertices uvs:(NSArray*)uvs normals:(NSArray*)normals faces:(NSArray*)faces;
{
    if (self = [super init])
    {
        _vertices = vertices;
        _normals = normals;
        _uvs = uvs;
        _faces = faces;
    }
    return self;
}

@end
