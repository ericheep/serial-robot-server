// SerialBot.ck
// Eric Heep
// CalArts Music Tech // MTIID4LIFE

public class SerialBot {
    HandshakeID talk;

    OscIn oin;
    OscMsg msg;

    4321 => oin.port;
    // "Earth below us, drifting falling, 
    //  floating weightless, calling calling home."
    oin.listenAll();

    fun int IDCheck(int arduinoID, string address) {
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
        while (true) {
            oin => now;
            while (oin.recv(msg)) {
                if (msg.address == address) {
                    <<< port, address >>>;
                    talk.talk.note(port, msg.getInt(0), msg.getInt(1));
                    //<<< msg.address, msg.getInt(0), msg.getInt(1) >>>;
                }
            }
        }
    }
}
