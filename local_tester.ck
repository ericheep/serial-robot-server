// local_tester.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

OscOut oout;
("localhost", 11235) => oout.dest;

["/MDarimBot","/Trimpbeat","/Trimpspin"] @=> string address[];

int ctr;

[33,35,36,38,40,41,42,43,
 45,47,48,50,52,53,54,55,
 57,59,60,62,64,65,66,67,
 69,71,72,74,76,77,78,79,
 81,83] @=> int scl[];


while (true) {
    (ctr + 1) % 20 => ctr;
    oout.start(address[0]);
    oout.add(scl[ctr]);
    oout.add(100);
    oout.send();
    0.25::second => now;
}

