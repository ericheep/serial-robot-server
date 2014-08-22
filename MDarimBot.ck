// MDarimbot.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

public class MDarimBot extends SerialBot {
    // MDarimBot is 0
    // Trimpbeat is 1
    // Trimpspin is 2
    
    // MIDI notes
    [33,35,36,38,40,41,42,43
     45,47,48,50,52,53,54,55
     57,59,60,62,64,65,66,67
     69,71,72,74,76,77,78,79
     81,83] @=> int scale;

    rescale(scale);

    0 => int ID;
    "/MDarimBot" => string address;
    IDCheck(ID, address) => int check;
    if (check >= 0) {
        spork ~ oscrecv(check, address);
    }
}
