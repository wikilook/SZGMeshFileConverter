//
//  SZGMFFace+Helper.h
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import "SZGMFFace.h"

NS_ASSUME_NONNULL_BEGIN

/*!
 * @brief Helper category for the SZGMFFace class
 */
@interface SZGMFFace (Helper)

/*!
 * @brief Triangulates the face indices
 * @warning Only works reliably for convex/coplanar faces
 */
- (void) triangulate;

@end

NS_ASSUME_NONNULL_END
