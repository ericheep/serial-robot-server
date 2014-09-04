// SerialBot.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

public class SerialBot {
    // class for all serial robots

    HandshakeID talk;

    OscIn oin;
    OscMsg msg;

    // fibonacci port number
    11235 => oin.port;
    oin.listenAll();

    // for optional rescaling
    int scale[64];
    scale.cap() => int scaleCap;
    for (int i; i < scale.cap(); i++) {
        i => scale[i];
    }

    fun void rescale(int newScale[]) {
        // reassigns incoming MIDI notes to their proper robot note
        newScale.cap() => scaleCap;
        for (int i; i < newScale.cap(); i++) {
            newScale[i] => scale[i];
        }
    }

    fun int renote(int oldNote) {
        // note reassignment, also checks if message is a valid note
        int pass, newNote;
        for (int i; i < scaleCap; i++) {
            if (oldNote == scale[i]) {
                i => newNote;
                1 => pass;
            }
        }
        if (pass != 1) {
            -1 => newNote;
        }
        return newNote;
    }

    fun int IDCheck(int arduinoID, string address) {
        // tells child class to only send serial messages
        // if it has successfully connected to a matching robot
        -1 => int check;
        for (int i; i < talk.talk.robotID.cap(); i++) {
            if (arduinoID == talk.talk.robotID[i]) {
                <<< address, "connected!", i >>>;
                i => check;
            }
        }
        if (check == -1) {
            <<< address, "was unable to connect">>>;
        }
        return check;
    }

    fun void oscrecv(int port, string address) {
        // receives OSC and sends out serial
        while (true) {
            oin => now;
            while (oin.recv(msg)) {
                if (msg.address == address) {
                    renote(msg.getInt(0)) => int note;
                    if (note >= 0) {
                        talk.talk.note(port, note, msg.getInt(1));
                    }
                    else {
                        <<< msg.getInt(0), "is not an accepted note number for", address, "" >>>;
                    }
                }
            }
        }
    }
}
