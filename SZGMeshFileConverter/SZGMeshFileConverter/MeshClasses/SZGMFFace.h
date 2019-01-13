//
//  SZGMFFace.h
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief Face class for storing face data
 */
@interface SZGMFFace : NSObject

/// The indices of the vertices of the face
@property (nonatomic, strong) NSArray* vertexIndices;

/// The indices of the uv coordinates
@property (nonatomic, strong) NSArray* uvIndices;

// The indices of the normal coordinates
@property (nonatomic, strong) NSArray* normalIndices;

- (instancetype) initWithVertexIndices:(NSArray*) vertexIndices uvIndices:(NSArray*) uvIndices normalIndices:(NSArray*)normalIndices;

@end

NS_ASSUME_NONNULL_END
