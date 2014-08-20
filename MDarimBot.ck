// MDarimbot.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

public class MDarimBot extends SerialBot {
    // MDarimBot is 0
    // Trimpbeat is 1
    // Trimpspin is 2

    0 => int ID;
    "/MDarimBot" => string address;
    IDCheck(ID, address) => int check;
    if (check >= 0) {
        spork ~ oscrecv(check, address);
    }
}
