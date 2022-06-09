# generated-music

A ChucK program that generates deterministic 8-bit music based on a seed.

To run, replace the 0 with any other integer to hear a new piece of 8-bit music:
```
chuck random.ck seedPiece.ck:0
```

If you want to record it, 
```
chuck random.ck seedPiece.ck:0 rec.ck:output.wav
```

A favorite to start with:
```
chuck random.ck seedPiece.ck:205
```
