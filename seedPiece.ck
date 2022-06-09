PsuedoRandom r; //from random.ck (make sure to run with random.ck)
r.setUp(Std.atoi(me.arg(0)));

[[3, 3, 3, 3, 24, 12, 3, 12, 7, 7, 8, 19],
[3],
[3, 3],
[0, 5, 5, 5, 5, 0, 3, 5, 0, 3, 5, 5, 3, 5, 3, 5, 3, 0, 3, 3, 0, 7, 0, 12, 5, 2, 0, 0],
[3],
[6, 3, 6, 3, 7, 3, 7, 7, 7, 5, 7, 3, 3, 5, 3, 7, 5, 5, 5, 5, 5, 3, 3, 5, 5, 6, 5, 5, 6, 5, 5, 5, 3, 5, 5, 7, 3, 3, 10, 10, 3, 12, 7, 7],
[5, 5, 6, 5, 7, 7, 7, 7, 5, 5, 7, 7],
[10, 10, 10, 10, 10, 10, 10, 5, 7, 7, 10, 7, 10, 10, 10, 7, 7, 6, 7, 7, 6, 7, 7, 6, 7, 7, 5, 7, 7, 5, 7, 7, 7, 10, 7, 10, 5, 5, 12, 12, 12, 10, 3, 8, 5, 8, 8, 3, 5, 12, 0],
[7, 10, 7, 7, 7],
[3],
[7, 7, 12, 7, 15, 6, 12, 12, 7, 12, 15, 10, 7, 12, 12, 12, 10, 10, 15, 7, 10, 12, 10, 10, 7, 7, 12, 12, 12, 6, 6, 5, 12, 8],
[3],
[10, 10, 10, 10, 0, 12, 24, 24, 10, 10, 24, 12, 10, 10, 19, 19, 19, 19, 10, 10, 15, 10, 5, 2, 3, 0],
[3],
[3],
[15, 12, 12, 12, 15, 12, 15, 15, 12],
[3],
[3],
[3],
[7, 0, 24, 36, 7],
[3],
[3],
[3],
[3],
[12, 24, 12, 31, 12, 12],
[3],
[3],
[3],
[3],
[3],
[3],
[24, 19],
[3],
[3],
[3],
[3],
[31]]
  @=> int notesData[][];

SqrOsc lead => Gain volume => dac;
SinOsc baseOsc => volume;
SinOsc baseOscOctave => volume;
PulseOsc base2Osc => volume;
0.75 => base2Osc.gain;
0.25 => volume.gain;

0 => int noteNumber;
-1 => int secondNote;
0 => int baseNumber;

[0, 3, 5, 7, 10, 12, 15, 22, 19, 0, 0, 0, 0, 12, 12] @=> int notes[];
[[0, 7, 10, 12, 0, 7, 10, 12, 3, 7, 10, 12, 3, 7, 10, 12, 5, 7, 10, 12, 5, 7, 10, 12, 7, 12, 14, 19, 14, 12, 7, 17],
[0, 7, 10, 12, 0, 7, 10, 12, -2, 5, 10, 12, -2, 5, 10, 12, -4, 3, 6, 8, -4, 3, 8, 12, -5, 2, 7, 14, 19, 14, 7, 2],
[0, 7, 12, 14, 12, 10, 7, 5, 3, 7, 10, 12, 15, 14, 12, 10, 5, 12, 15, 12, 17, 12, 15, 12, 8, 5, 3, 0, 10, 5, 2, -2],
[3, 5, 10, 12, 10, 5, 3, 0, -2, 3, 5, 7, 10, 7, 5, 2, 8, 7, 8, 5, 8, 3, 8, 0, 7, 14, 19, 7, -2, 5, 10, 12]]
  @=> int bases[][];
[[0, 12, 12, 12, 0, 12, 12, 12, 3, 15, 15, 15, 3, 15, 15, 15, 5, 17, 17, 17, 5, 17, 17, 17, 7, 7, 7, 7, 7, 7, 7, 10],
[0, 12, 12, 12, 0, 12, 12, 12, -2, 5, 5, 5, -2, 5, 5, 5, -4, 3, 3, 3, -4, 3, 3, 3, -5, 2, 2, 2, -5, 2, 2, 2],
[0, 12, 12, 12, 0, 12, 12, 12, 3, -9, -9, -9, 3, -9, 3, 15, 5, 17, 17, 17, 5, -7, 5, 17, -4, 8, 8, 8, -2, 10, -2 , 10],
[3, 15, -9, 15, 3, 10, 15, 15, 10, 22, 22, 12, 10, 22, 22, 10, 8, 20, 15, 8, 20, 20, 15, 8, 7, 14, 7, 14, -2, 10, -14, -2]]
  @=> int secondBases[][];
[20, 35, 35, 10] @=> int baseChance[];

notes[r.rand2(0, notes.cap() -1)] => int currentNote;

false => int isEigth;
true => int isEigthSequence;
false => int isInLongStreak;

fun int nextNote(int note) {
  return notesData[note][r.rand2(0, notesData[note].cap())];
}

fun int nextBase() {
  r.rand2(0, 99) => int percent;
  for(0 => int i; i < baseChance.cap(); i++) {
    if(percent <= baseChance[i]) {
      return i;
    } else {
      baseChance[i] -=> percent;
    }
  }
}

fun int changeEigth(int current) {
  if(!isInLongStreak) {
    r.rand2(0, 299) > 298 => int result;
    if(result) {
      true => isInLongStreak;
      <<<"in streak">>>;
      if(current) {
        return true;
      } else {
        return false;
      }
    }
  }
  if(r.rand2(0, 99) + (!current * 25) - (isInLongStreak * 33) > 90) {
    if(isInLongStreak) {
      false => isInLongStreak;
      <<<"out of streak">>>;
    }
    return true;
  } else {
    return false;
  }
}

66.66666666666666 => float melodyProbability;

fun int playMelody() {
  r.rand2(0, 99) < melodyProbability => int play;
  if(play) {
    0.75 *=> melodyProbability;
    if(melodyProbability < 15) { 66.666666666666 => melodyProbability; }
    return true;
  }
  return false;
}

true => int playingMelody;
nextBase() => int melodyBase;
melodyBase => baseNumber;
0 => int melodyNote;
int melody[32];
notes[r.rand2(0, notes.cap() -1)] => int addNote;

for(0 => int i; i < 32; i++) {
  addNote => melody[i];
  nextNote(addNote) => addNote;
}

while(true) {
  !isEigth => isEigth;
  if(!playingMelody) {
    if(changeEigth(isEigthSequence)) {
      !isEigthSequence => isEigthSequence;
    }
    if(isEigthSequence) {
      if(isEigth) {
        nextNote(currentNote) => currentNote;
        300.0 * (Math.pow(2.0, (currentNote / 12.0))) => lead.freq;
      }
    } else {
        currentNote => int pastNote;
        while(currentNote == pastNote) {
          nextNote(currentNote) => currentNote;
        }
        300.0 * (Math.pow(2.0, (currentNote / 12.0))) => lead.freq;
    }
  } else {
    if(isEigth) {
      if(melodyNote >= 32) {
        false => playingMelody;
      } else {
        melody[melodyNote] => currentNote;
        300.0 * (Math.pow(2.0, (currentNote / 12.0))) => lead.freq;
        1 +=> melodyNote;
      }
    }
  }
  if(isEigth) {
    secondNote++;
    if(secondNote >= bases[baseNumber].cap()) {
      0 => secondNote;
      if(playMelody()) {
        true => playingMelody;
        melodyBase => baseNumber;
        0 => melodyNote;
      } else {
        nextBase() => baseNumber;
      }
    }
    300.0 * (Math.pow(2.0, (bases[baseNumber][secondNote] / 12.0))) => baseOscOctave.freq;
    150.0 * (Math.pow(2.0, (bases[baseNumber][secondNote] / 12.0))) => baseOsc.freq;
    75.0 * (Math.pow(2.0, (secondBases[baseNumber][secondNote] / 12.0))) => base2Osc.freq;
  }
  100::ms => now;
}