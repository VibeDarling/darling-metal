// SPDX-FileCopyrightText: 2026 Darling Developers
// SPDX-License-Identifier: MPL-2.0

#import <Metal/MTLVertexDescriptor.h>
#import <Foundation/Foundation.h>

static const NSUInteger kMTLVertexLayoutIndexMax = 31;
static const NSUInteger kMTLVertexAttributeIndexMax = 31;

@implementation MTLVertexBufferLayoutDescriptor

@synthesize stride = _stride, stepFunction = _stepFunction, stepRate = _stepRate;

- (instancetype)init {
	if (self = [super init]) {
		_stride = 0;
		_stepFunction = MTLVertexStepFunctionPerVertex;
		_stepRate = 1;
	}
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	MTLVertexBufferLayoutDescriptor *copy = [[MTLVertexBufferLayoutDescriptor allocWithZone:zone] init];
	copy.stride = _stride;
	copy.stepFunction = _stepFunction;
	copy.stepRate = _stepRate;
	return copy;
}

@end

@implementation MTLVertexAttributeDescriptor

@synthesize format = _format, offset = _offset, bufferIndex = _bufferIndex;

- (instancetype)init {
	if (self = [super init]) {
		_format = MTLVertexFormatInvalid;
		_offset = 0;
		_bufferIndex = 0;
	}
	return self;
}

- (id)copyWithZone:(NSZone *)zone {
	MTLVertexAttributeDescriptor *copy = [[MTLVertexAttributeDescriptor allocWithZone:zone] init];
	copy.format = _format;
	copy.offset = _offset;
	copy.bufferIndex = _bufferIndex;
	return copy;
}

@end

@implementation MTLVertexBufferLayoutDescriptorArray

- (instancetype)init {
	if (self = [super init]) {
		_items = [[NSMutableArray alloc] initWithCapacity:kMTLVertexLayoutIndexMax];
		for (NSUInteger i = 0; i < kMTLVertexLayoutIndexMax; i++) {
			[_items addObject:[NSNull null]];
		}
	}
	return self;
}

- (void)dealloc {
	[_items release];
	[super dealloc];
}

- (MTLVertexBufferLayoutDescriptor *)objectAtIndexedSubscript:(NSUInteger)index {
	if (index >= kMTLVertexLayoutIndexMax) return nil;
	id obj = [_items objectAtIndex:index];
	if (obj == [NSNull null]) {
		obj = [[[MTLVertexBufferLayoutDescriptor alloc] init] autorelease];
		[_items replaceObjectAtIndex:index withObject:obj];
	}
	return obj;
}

- (void)setObject:(MTLVertexBufferLayoutDescriptor *)bufferDesc atIndexedSubscript:(NSUInteger)index {
	if (index >= kMTLVertexLayoutIndexMax) return;
	if (bufferDesc) {
		[_items replaceObjectAtIndex:index withObject:bufferDesc];
	} else {
		[_items replaceObjectAtIndex:index withObject:[NSNull null]];
	}
}

- (void)reset {
	for (NSUInteger i = 0; i < kMTLVertexLayoutIndexMax; i++) {
		[_items replaceObjectAtIndex:i withObject:[NSNull null]];
	}
}

@end

@implementation MTLVertexAttributeDescriptorArray

- (instancetype)init {
	if (self = [super init]) {
		_items = [[NSMutableArray alloc] initWithCapacity:kMTLVertexAttributeIndexMax];
		for (NSUInteger i = 0; i < kMTLVertexAttributeIndexMax; i++) {
			[_items addObject:[NSNull null]];
		}
	}
	return self;
}

- (void)dealloc {
	[_items release];
	[super dealloc];
}

- (MTLVertexAttributeDescriptor *)objectAtIndexedSubscript:(NSUInteger)index {
	if (index >= kMTLVertexAttributeIndexMax) return nil;
	id obj = [_items objectAtIndex:index];
	if (obj == [NSNull null]) {
		obj = [[[MTLVertexAttributeDescriptor alloc] init] autorelease];
		[_items replaceObjectAtIndex:index withObject:obj];
	}
	return obj;
}

- (void)setObject:(MTLVertexAttributeDescriptor *)attributeDesc atIndexedSubscript:(NSUInteger)index {
	if (index >= kMTLVertexAttributeIndexMax) return;
	if (attributeDesc) {
		[_items replaceObjectAtIndex:index withObject:attributeDesc];
	} else {
		[_items replaceObjectAtIndex:index withObject:[NSNull null]];
	}
}

- (void)reset {
	for (NSUInteger i = 0; i < kMTLVertexAttributeIndexMax; i++) {
		[_items replaceObjectAtIndex:i withObject:[NSNull null]];
	}
}

@end

@implementation MTLVertexDescriptor

+ (MTLVertexDescriptor *)vertexDescriptor {
	return [[[self alloc] init] autorelease];
}

- (instancetype)init {
	if (self = [super init]) {
		_layouts = [[MTLVertexBufferLayoutDescriptorArray alloc] init];
		_attributes = [[MTLVertexAttributeDescriptorArray alloc] init];
	}
	return self;
}

- (void)dealloc {
	[_layouts release];
	[_attributes release];
	[super dealloc];
}

- (MTLVertexBufferLayoutDescriptorArray *)layouts {
	return _layouts;
}

- (MTLVertexAttributeDescriptorArray *)attributes {
	return _attributes;
}

- (void)reset {
	[_layouts reset];
	[_attributes reset];
}

- (id)copyWithZone:(NSZone *)zone {
	MTLVertexDescriptor *copy = [[MTLVertexDescriptor allocWithZone:zone] init];
	for (NSUInteger i = 0; i < kMTLVertexLayoutIndexMax; i++) {
		MTLVertexBufferLayoutDescriptor *l = [_layouts objectAtIndexedSubscript:i];
		if (l) [copy.layouts setObject:[[l copy] autorelease] atIndexedSubscript:i];
	}
	for (NSUInteger i = 0; i < kMTLVertexAttributeIndexMax; i++) {
		MTLVertexAttributeDescriptor *a = [_attributes objectAtIndexedSubscript:i];
		if (a) [copy.attributes setObject:[[a copy] autorelease] atIndexedSubscript:i];
	}
	return copy;
}

@end
