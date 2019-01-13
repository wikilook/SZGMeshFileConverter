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
 * @brief Triangulates the faces of the mesh. Adding new faces in the process usually
 * @warning Only works for convex faces
 */
- (void) triangulateFaces;

/*!
 * @brief Method for calulating the surface area of the mesh
 */
- (float) calculateSurfaceArea;

@end

NS_ASSUME_NONNULL_END
