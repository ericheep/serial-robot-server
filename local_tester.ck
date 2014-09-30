// local_tester.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

OscOut oout;
("localhost", 11235) => oout.dest;

["/MDarimBot","/Trimpbeat","/Trimpspin"] @=> string address[];

int ctr;

// MIDI notes
[60,61,62,63,64,65,66,67,68,69,
 70,71,72,73,74,75,76,77,78,79] @=> int scl[];

[45,47,48,50,52,53,54,55,
 57,59,60,62,64,65,66,67,
 69,71,72,74,76,77,78,79,
 81,83,84,86,88,89,90,91,
 93,95,96] @=> int mscl[];

while (true) {
    (ctr + 1) % 20 => ctr;
    oout.start("/Trimpbeat");
    oout.add(scl[Math.random2(0,scl.cap() - 1)]);
    oout.add(Math.random2(0,127));
    oout.send();
    0.40::second => now;
}

