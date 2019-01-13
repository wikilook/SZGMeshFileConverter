//
//  SZGMFFace.m
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import "SZGMFFace.h"

@implementation SZGMFFace

- (instancetype) initWithVertexIndices:(NSArray*) vertexIndices uvIndices:(NSArray*) uvIndices normalIndices:(NSArray*)normalIndices
{
    if (self = [super init])
    {
        _vertexIndices = vertexIndices;
        _uvIndices = uvIndices;
        _normalIndices = normalIndices;
    }
    return self;
}

@end
