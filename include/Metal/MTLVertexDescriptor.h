// SPDX-FileCopyrightText: 2026 Darling Developers
// SPDX-License-Identifier: MPL-2.0

#ifndef _METAL_MTLVERTEXDESCRIPTOR_H_
#define _METAL_MTLVERTEXDESCRIPTOR_H_

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MTLVertexFormat) {
	MTLVertexFormatInvalid = 0,
	MTLVertexFormatUChar2 = 1,
	MTLVertexFormatUChar3 = 2,
	MTLVertexFormatUChar4 = 3,
	MTLVertexFormatChar2 = 4,
	MTLVertexFormatChar3 = 5,
	MTLVertexFormatChar4 = 6,
	MTLVertexFormatFloat = 28,
	MTLVertexFormatFloat2 = 29,
	MTLVertexFormatFloat3 = 30,
	MTLVertexFormatFloat4 = 31,
};

typedef NS_ENUM(NSUInteger, MTLVertexStepFunction) {
	MTLVertexStepFunctionConstant = 0,
	MTLVertexStepFunctionPerVertex = 1,
	MTLVertexStepFunctionPerInstance = 2,
};

@interface MTLVertexBufferLayoutDescriptor : NSObject <NSCopying> {
@public
	NSUInteger _stride;
	MTLVertexStepFunction _stepFunction;
	NSUInteger _stepRate;
}
@property (readwrite) NSUInteger stride;
@property (readwrite) MTLVertexStepFunction stepFunction;
@property (readwrite) NSUInteger stepRate;
@end

@interface MTLVertexAttributeDescriptor : NSObject <NSCopying> {
@public
	MTLVertexFormat _format;
	NSUInteger _offset;
	NSUInteger _bufferIndex;
}
@property (readwrite) MTLVertexFormat format;
@property (readwrite) NSUInteger offset;
@property (readwrite) NSUInteger bufferIndex;
@end

@interface MTLVertexBufferLayoutDescriptorArray : NSObject {
@public
	NSMutableArray *_items;
}
- (MTLVertexBufferLayoutDescriptor *)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(MTLVertexBufferLayoutDescriptor *)bufferDesc atIndexedSubscript:(NSUInteger)index;
@end

@interface MTLVertexAttributeDescriptorArray : NSObject {
@public
	NSMutableArray *_items;
}
- (MTLVertexAttributeDescriptor *)objectAtIndexedSubscript:(NSUInteger)index;
- (void)setObject:(MTLVertexAttributeDescriptor *)attributeDesc atIndexedSubscript:(NSUInteger)index;
@end

@interface MTLVertexDescriptor : NSObject <NSCopying> {
@public
	MTLVertexBufferLayoutDescriptorArray *_layouts;
	MTLVertexAttributeDescriptorArray *_attributes;
}
@property (readonly) MTLVertexBufferLayoutDescriptorArray *layouts;
@property (readonly) MTLVertexAttributeDescriptorArray *attributes;
+ (MTLVertexDescriptor *)vertexDescriptor;
- (void)reset;
@end

#endif // _METAL_MTLVERTEXDESCRIPTOR_H_
