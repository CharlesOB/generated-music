dac => Gain g => WvOut w => blackhole;
"" => w.autoPrefix;
me.arg(0) => string filename;
if(filename.length() == 0) "special:auto" => filename;
filename => w.wavFilename;
<<<"Writing to file: ", w.filename()>>>;
1 => w.record;
while(true){1::week => now;}