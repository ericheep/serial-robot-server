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
    for (int i ; i < scale.cap(); i++) {
        i => scale[i];
    }

    fun void rescale(int[] collection) {
        // reassigns incoming MIDI notes to their proper robot note
        for (int i; i < collection.cap(); i++) {
            collection[i] => scale[i];
        }
    }

    fun int renote(note) {
        // scale reassignment
        for (int i; i < scale.cap(); i++) {
            if (note == scale[i]) {
                i => note;
            }
        }
        return note;
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
                    talk.talk.note(port, renote(msg.getInt(0)), msg.getInt(1));
                    <<< msg.address, renote(msg.getInt(0)), msg.getInt(1) >>>;
                }
            }
        }
    }
}
