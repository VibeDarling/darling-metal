# metal-gaps guest test

`gaps.mm` exercises the Metal classes added for Blender 5.1.2's dyld failures,
from inside the guest under `darlingserver`. Every check is on a value the caller
itself supplied, so a pass means the object stored and returned that value and
nothing else. Checks written with `MTL_EXPECT_NEGATIVE` assert the opposite: that
an operation indium cannot back refuses rather than answering plausibly.

## Running it

The harness is not in this repository because it needs the flags harvested from a
darling build tree and a prefix with a `darlingserver` serving it. What it does:

1. Compiles `gaps.mm` as a guest arm64 Mach-O with the component include dirs
   hoisted ahead of `framework-include`, because the shared tree carries an
   installed snapshot of these very headers that would otherwise shadow them.
2. Links it against `crt1.o`, the harvested dylib map, and the freshly built
   `Metal` and `indium` as direct inputs, prepending the `-dylib_file` entries
   for those two because ld64 honours the first one.
3. Installs the binary into the prefix's `/usr/bin` and runs it with
   `DPREFIX=<prefix> darling exec /usr/bin/gaps`.

## The negative control

`-DNEGATIVE` inverts every assertion: `MTL_EXPECT` becomes
`MTL_EXPECT_NEGATIVE` and vice versa. That run **must fail**. It currently
reports 86 failures out of 87 checks, the remaining one being a skip because
there is no default library to get a function from.

If the inverted run ever passes, the assertions are not asserting anything and a
passing real run means nothing either. Run both, every time.
