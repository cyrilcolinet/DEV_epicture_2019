import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// Signature for a function that creates a [TileSize] for a given index.
typedef TileSize IndexedTileSizeBuilder(int index);

/// Creates grid layouts with a fixed number of spans in the cross axis.
/// Each tile can occupy from 1 to this number of spans.
///
/// For example, if the grid is vertical, this delegate will create a layout
/// with a fixed number of vertical spans.
///
/// This delegate creates grids with variable sized but equally spaced tiles.
class SliverGridDelegateWithFixedCrossAxisSpans extends SliverGridDelegate {
    /// The number of spans in the cross axis.
    final int crossAxisSpans;

    /// The number of logical pixels between each child along the main axis.
    final double mainAxisSpacing;

    /// The number of logical pixels between each span along the cross axis.
    final double crossAxisSpacing;

    final double mainAxisRatio;

    /// The function used to get the size of a tile from its index.
    final IndexedTileSizeBuilder tileSizeBuilder;

    /// Creates a delegate that makes grid layouts with variable sized tiles.
    ///
    /// All of the arguments must not be null. The [crossAxisSpans],
    /// [mainAxisSpacing], and [crossAxisSpacing] arguments must not be negative.
    const SliverGridDelegateWithFixedCrossAxisSpans(
        {@required this.crossAxisSpans, this.mainAxisSpacing: 0.0,
            this.crossAxisSpacing: 0.0, @required this.tileSizeBuilder,
            this.mainAxisRatio})
        : assert(crossAxisSpans != null && crossAxisSpans > 0),
            assert(mainAxisSpacing != null && mainAxisSpacing >= 0),
            assert(crossAxisSpacing != null && crossAxisSpacing >= 0),
            assert(tileSizeBuilder != null);

    @override
    SliverGridLayout getLayout(SliverConstraints constraints) {
        assert(_debugAssertIsValid());

        final double usableCrossAxisExtent =
            constraints.crossAxisExtent - crossAxisSpacing * (crossAxisSpans - 1);
        final double spanCrossAxisExtent = usableCrossAxisExtent / crossAxisSpans;

        return new SliverGridVariableSizedTileLayout(
            crossAxisSpans: crossAxisSpans,
            spanCrossAxisExtent: spanCrossAxisExtent,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            tileSizeBuilder: tileSizeBuilder,
            mainAxisRatio: mainAxisRatio,
        );
    }

    @override
    bool shouldRelayout(SliverGridDelegateWithFixedCrossAxisSpans oldDelegate) {
        return oldDelegate.crossAxisSpans != crossAxisSpans ||
            oldDelegate.mainAxisSpacing != mainAxisSpacing ||
            oldDelegate.crossAxisSpacing != crossAxisSpacing;
    }

    bool _debugAssertIsValid() {
        assert(crossAxisSpans > 0);
        assert(mainAxisSpacing >= 0.0);
        assert(crossAxisSpacing >= 0.0);
        return true;
    }
}

/// A [SliverGridLayout] that uses variable sized but equally spaced tiles.
///
/// This layout is used by [SliverGridDelegateWithVariableSizedTiles].
class SliverGridVariableSizedTileLayout extends SliverGridLayout {
    /// The number of spans in the cross axis.
    final int crossAxisSpans;

    /// The number of pixels from the leading edge of one span to the trailing
    /// edge of the same span in the cross axis.
    final double spanCrossAxisExtent;

    /// The number of logical pixels between each span along the cross axis.
    final double crossAxisSpacing;

    /// The number of logical pixels between each child along the main axis.
    final double mainAxisSpacing;

    /// The function used to get the size of a tile from its index.
    final IndexedTileSizeBuilder tileSizeBuilder;

    final double mainAxisRatio;

    final double _spanCrossAxisStride;

    final double _spanMainAxisStride;

    final Map<int, _TileGeometry> _indexToGeometry;

    final List<double> _offsets;

    /// Creates a layout that uses variable sized but equally spaced tiles.
    ///
    /// All of the arguments must not be null and must not be negative. The
    /// [crossAxisSpans] argument must be greater than zero.
    SliverGridVariableSizedTileLayout(
        {@required this.crossAxisSpans,
            @required this.spanCrossAxisExtent,
            @required this.crossAxisSpacing,
            @required this.mainAxisSpacing,
            @required this.tileSizeBuilder,
            this.mainAxisRatio})
        : assert(crossAxisSpans != null && crossAxisSpans > 0),
            assert(spanCrossAxisExtent != null && spanCrossAxisExtent >= 0),
            assert(crossAxisSpacing != null && crossAxisSpacing >= 0),
            assert(mainAxisSpacing != null && mainAxisSpacing >= 0),
            assert(tileSizeBuilder != null),
            _spanCrossAxisStride = spanCrossAxisExtent + crossAxisSpacing,
            _spanMainAxisStride = spanCrossAxisExtent + mainAxisSpacing,
            _indexToGeometry = new Map(),
            _offsets = new List.generate(crossAxisSpans, (i) => 0.0);

    @override
    double computeMaxScrollOffset(int childCount) {
        // We cannot now just with child count.
        if (childCount == null) return null;
        _getTileGeometry(childCount - 1);
        var maxScrollOffset = _offsets.reduce(math.max);
        return maxScrollOffset;
    }

    @override
    SliverGridGeometry getGeometryForChildIndex(int index) {
        return _getTileGeometry(index).geometry;
    }

    double getMainAxisExtent(double extent) {
        if (mainAxisRatio == null) {
            return extent;
        } else {
            return _spanMainAxisStride * mainAxisRatio * extent - mainAxisSpacing;
        }
    }

    @override
    int getMaxChildIndexForScrollOffset(double scrollOffset) {
        int index = 0;
        List<double> offsets = new List.generate(crossAxisSpans, (i) => 0.0);

        while (true) {
            var tileGeometry = _getTileGeometry(index);
            if (tileGeometry == null) return index - 1;
            for (var i = 0; i < tileGeometry.tileSize.span; i++) {
                offsets[i + tileGeometry.spanIndex] =
                    tileGeometry.geometry.trailingScrollOffset;
            }
            if (!offsets.any((i) => i <= scrollOffset)) return index;
            ++index;
        }
    }

    @override
    int getMinChildIndexForScrollOffset(double scrollOffset) {
        int index = 0;
        while (true) {
            var geometry = _getTileGeometry(index)?.geometry;
            if (geometry == null) return index - 1;
            if (geometry.trailingScrollOffset >= scrollOffset) return index;
            ++index;
        }
    }

    /// Finds the first available block with at least the specified [size].
    _Block _findFirstAvailableBlockWithSize(int size) {
        return _findFirstAvailableBlockWithSizeAndOffsets(
            size, new List.from(_offsets));
    }

    /// Finds the first available block with at least the specified [size].
    _Block _findFirstAvailableBlockWithSizeAndOffsets(
        int size, List<double> offsets) {
        _Block block = _findFirstAvailableBlock(offsets);
        if (block.size < size) {
            // Not enough space for the specified size.
            // We have to fill this block in try again.
            for (var i = 0; i < block.size; ++i) {
                offsets[i + block.index] = block.maxOffset;
            }
            return _findFirstAvailableBlockWithSizeAndOffsets(size, offsets);
        } else {
            return block;
        }
    }

    _TileGeometry _getTileGeometry(int index) {
        _TileGeometry tileGeometry = _indexToGeometry[index];

        if (tileGeometry == null) {
            // Populates the tiles geometries from the last computed index to this
            // index.
            for (var i = _indexToGeometry.length; i < index; ++i) {
                var x = _getTileGeometry(i);
                if (x == null) return null;
            }

            var tileSize = _normalizeTileSize(tileSizeBuilder(index));
            if (tileSize == null) return null;

            var block = _findFirstAvailableBlockWithSize(tileSize.span);

            var scrollOffset = block.minOffset;
            var crossAxisOffset = block.index * _spanCrossAxisStride;

            var geometry = new SliverGridGeometry(
                scrollOffset: scrollOffset,
                crossAxisOffset: crossAxisOffset,
                mainAxisExtent: tileSize.extent,
                crossAxisExtent:
                _spanCrossAxisStride * tileSize.span - crossAxisSpacing);
            tileGeometry = new _TileGeometry(tileSize, geometry, block.index);
            _indexToGeometry[index] = tileGeometry;
            var stride = tileSize.extent + mainAxisSpacing;
            for (var i = 0; i < tileSize.span; i++) {
                _offsets[i + block.index] = block.minOffset + stride;
            }
        }
        return tileGeometry;
    }

    TileSize _normalizeTileSize(TileSize tileSize) {
        if (tileSize == null) return null;
        return new TileSize(tileSize.span.clamp(0, crossAxisSpans),
            getMainAxisExtent(tileSize.extent));
    }

    /// Finds the first available block for the specified [offsets] list.
    static _Block _findFirstAvailableBlock(List<double> offsets) {
        int index = 0;
        double minBlockOffset = double.infinity;
        double maxBlockOffset = double.infinity;
        int size = 1;
        bool contiguous = false;

        for (var i = index; i < offsets.length; ++i) {
            var offset = offsets[i];
            if (offset < minBlockOffset) {
                index = i;
                maxBlockOffset = minBlockOffset;
                minBlockOffset = offset;
                size = 1;
                contiguous = true;
            } else if (offset == minBlockOffset && contiguous) {
                size++;
            } else if (offset < maxBlockOffset && offset > minBlockOffset) {
                contiguous = false;
                maxBlockOffset = offset;
            } else {
                contiguous = false;
            }
        }

        return new _Block(index, size, minBlockOffset, maxBlockOffset);
    }
}

/// The size of a tile that can be used by a [VariableSizedTileGridView].
class TileSize {
    /// The length of this tile in the cross axis.
    final int span;

    /// The number of pixels from the leading edge to the trailing edge of this tile
    /// in the main axis.
    final double extent;

    /// Creates a tile with a span and an extent.
    ///
    /// The arguments must be positive.
    const TileSize(this.span, this.extent)
        : assert(span != null && span >= 0),
            assert(extent != null && extent >= 0);
}

/// A scrollable 2D array of widgets that can have variable sizes.
class MasonryView extends GridView {
    /// Creates a scrollable 2D array of widgets with variable sizes.
    ///
    /// The [crossAxisSpans] is the number of spans in the cross axis.
    /// Typically for a vertical direction, this is the number of columns of
    /// your grid view. Each widget can have a span from 1 to [crossAxisSpans].
    /// It must be strictly positive.
    ///
    /// The [tileSizeBuilder] gives the tile size for the widget at the
    /// specified index.
    ///
    /// The [itemBuilder] has the same meaning as in [new GridView.builder].
    ///
    /// The [mainAxisSpacing] and [crossAxisSpacing] are the number of pixels
    /// between your widgets. These arguments are 0.0 by default and must be
    /// positives.
    ///
    /// The [mainAxisRatio] is the ratio between the computed cross axis extent
    /// for one span and the main axis extent of your widgets.
    /// For example, by setting a [mainAxisRatio] to 1, the widget for a tile
    /// size of (1, 1.0) will be a square.
    /// If you do not set the [mainAxisRatio] or set it to null, the extent of
    /// the tile size will be the main axis extent of your widget.
    MasonryView.builder({
        Key key,
        Axis scrollDirection: Axis.vertical,
        ScrollController controller,
        bool primary,
        ScrollPhysics physics,
        bool shrinkWrap: false,
        EdgeInsetsGeometry padding,
        double mainAxisSpacing: 0.0,
        double crossAxisSpacing: 0.0,
        @required int crossAxisSpans,
        @required IndexedTileSizeBuilder tileSizeBuilder,
        @required IndexedWidgetBuilder itemBuilder,
        double mainAxisRatio,
        int itemCount,
        bool addAutomaticKeepAlives: true,
        bool addRepaintBoundaries: true,
    })
        : assert(crossAxisSpans > 0),
            assert(tileSizeBuilder != null),
            assert(itemBuilder != null),
            assert(mainAxisSpacing != null && mainAxisSpacing >= 0.0),
            assert(crossAxisSpacing != null && crossAxisSpacing >= 0.0),
            super.custom(
            key: key,
            scrollDirection: scrollDirection,
            reverse: false,
            controller: controller,
            primary: primary,
            physics: physics,
            shrinkWrap: shrinkWrap,
            padding: padding,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisSpans(
                crossAxisSpans: crossAxisSpans,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
                tileSizeBuilder: tileSizeBuilder,
                mainAxisRatio: mainAxisRatio,
            ),
            childrenDelegate: new SliverChildBuilderDelegate(
                itemBuilder,
                childCount: itemCount,
                addAutomaticKeepAlives: addAutomaticKeepAlives,
                addRepaintBoundaries: addRepaintBoundaries,
            ));
}

class _Block {
    final int index;
    final int size;
    final double minOffset;
    final double maxOffset;

    const _Block(this.index, this.size, this.minOffset, this.maxOffset);
}

class _TileGeometry {
    final TileSize tileSize;
    final SliverGridGeometry geometry;
    final int spanIndex;

    const _TileGeometry(this.tileSize, this.geometry, this.spanIndex);
}