public class PsuedoRandom {
  0 => int seed;
  0 => int modulus;
  0 => int currentNumber;
  0 => int multiplyer;
  0 => int increment;

  fun void setUp() {
    setUp(0);
  }

  fun void setUp(int s) {
    setUp(s, 24890, 1457, 11);
  }

  fun void setUp(int s, int mod, int mult, int inc) {
    s => seed;
    mod => modulus;
    mult => multiplyer;
    inc => increment;
    s => currentNumber;
  }

  fun float rand() {
    (currentNumber * multiplyer + increment) % modulus => currentNumber;
    return (currentNumber $ float) / (modulus $ float);
  }

  fun int rand2(int low, int high) {
    return rand2f(low, high) $ int;
  }

  fun float rand2f(float low, float high) {
    return ((rand() * (high - low)) + low);
  }
}