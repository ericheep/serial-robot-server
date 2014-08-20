// Trimpbeat.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

public class Trimpbeat extends SerialBot {
    // MDarimBot is 0
    // Trimpbeat is 1
    // Trimpspin is 2

    2 => int ID;
    "/Trimpbeat" => string address;
    IDCheck(ID, address) => int check;
    if (check >= 0) {
        spork ~ oscrecv(check, address);
    }
}
