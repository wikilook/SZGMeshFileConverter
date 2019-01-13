//
//  SZGMFMesh.h
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief Mesh class for storing the mesh data
 */
@interface SZGMFMesh : NSObject

/// Array of GLKVector3 vertices stored in NSValue
@property (nonatomic, strong) NSArray* vertices;

/// Array of GLKVector3 uv vertices stored in NSValue
@property (nonatomic, strong) NSArray* uvs;

/// Array of GLKVector3 normal coordinates stored in NSValue
@property (nonatomic, strong) NSArray* normals;

/// Array of SZGMFFace objects, these store the faces
@property (nonatomic, strong) NSArray* faces;

- (instancetype)initWithVertices:(NSArray*)vertices uvs:(NSArray*)uvs normals:(NSArray*)normals faces:(NSArray*)faces;

@end

NS_ASSUME_NONNULL_END
