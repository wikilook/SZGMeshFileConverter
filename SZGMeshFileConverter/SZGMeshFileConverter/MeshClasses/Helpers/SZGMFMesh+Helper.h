//
//  SZGMFMesh+Helper.h
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import "SZGMFMesh.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief Helper category for the SZGMFMesh class
 */
@interface SZGMFMesh (Helper)

/*!
 * @brief Method for easy access of GLKVector3 values of the given index
 */
- (GLKVector3) vertexForVertexIndex:(NSNumber*)vertexIndex;

/*!
 * @brief Triangulates the faces of the mesh. Adding new faces in the process usually
 * @warning Only works for convex faces
 */
- (void) triangulateFaces;

/*!
 * @brief Method for calulating the surface area of the mesh
* @warning NOT TESTED -- works properly only with triangulated/convex meshes
 */
- (float) calculateSurfaceArea;

/*!
 * @brief Calculates volume of mesh
 * @warning NOT TESTED -- this is made for triangulated meshes as well
 */
- (float) calculateVolume;

@end

NS_ASSUME_NONNULL_END
