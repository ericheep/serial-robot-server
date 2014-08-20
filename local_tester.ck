// local_tester.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

OscOut oout;
("localhost", 4321) => oout.dest;

["/MDarimBot","/Trimpbeat","/Trimpspin"] @=> string address[];

int note;
int which;
while (true) {
    //<<< which >>>;
    (which + 1) % 3  => which;
    (note + 1) % 20 => note;
    oout.start(address[which]);
    oout.add(note);
    oout.add(100);
    oout.send();
    0.1::second => now;
}

