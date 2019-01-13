//
//  SZGMFConverterManager.h
//  SZGMeshFileConverter
//
//  Created by Gábor Szalai on 2019. 01. 12..
//  Copyright © 2019. Gábor Szalai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*!
 * @typedef OutputType
 * @brief The possible output types
*/
typedef enum : NSUInteger
{
    STL,
} OutputType;

/*!
 * @typedef InputType
 * @brief The possible input types
 */
typedef enum : NSUInteger
{
    OBJ,
} InputType;

/*!
 * @brief The manager class for converting
 */
@interface SZGMFConverterManager : NSObject
{
}

/*!
 * @discussion Method for converting between file types
 * @param inputFile Path of the input file
 * @param outputFile Path of the output file
 * @param inputType The type of the input file
 * @param outputType The type of the output file
*/
- (void) convertFileWithPath:(NSString*)inputFile output:(NSString*)outputFile inputType:(InputType)inputType outputType:(OutputType)outputType;

/*!
 * @discussion Method for converting between the default file types (OBJ -> STL)
 * @param inputFile Path of the input file
 * @param outputFile Path of the output file
 */
- (void) convertFileWithPath:(NSString*)inputFile output:(NSString*)outputFile;

@end

NS_ASSUME_NONNULL_END
