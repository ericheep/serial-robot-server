robot-serial-server
===================

Allows for serial communication to the mechatronic instruments (robots) in the Machine Lab.

Each robot needs to have an **identical ID number** that is written into both the Arduino code and its child class code.

Currenly supported robots with their ID number:
- MDarimbot     0
- Trimpbeat     1
- Trimpspin     2

To connect using ChucK via OSC:

    OscOut oout;
    ("chuckServer.local", 4321) => oout.dest;

Then to send to a robot (addresses should be kept the same as the robot names):

    oout.start("/Address")
    oout.add(note)
    oout.add(velocity)
    oout.send();

To add a new robot to the server:

    public class NewBot extends SerialBot {
        // OldBot is 0
        // NewBot is 1

        1 => int ID;
        "/NewBot" => string address;
        IDCheck(ID, address) => int check;
        if (check >= 1) {
            spork ~ oscrec(check, address);
        }
    }
