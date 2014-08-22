robot-serial-server
===================
Written by Eric Heep in the summer of 2014, jointly maintained by CalArts Music Tech.

Allows for serial communication to the mechatronic instruments (robots) in the Machine Lab.

Each robot needs to have an **identical ID number** that is written into both the Arduino code and its child class code.

    public class OldBot extends SerialBot {
        // OldBot is 0

        0 => int ID;
        "/OldBot" => string address;
        IDCheck(ID, address) => int check;
        if (check >= 0) {
            spork ~ oscrec(check, address);
        }
    }

Currenly supported serial robots with their ID number and MIDI channel:

    ID 0 Ch 7 MDarimbot
    ID 1 Ch 8 Trimpbeat
    ID 2 Ch 9 Trimpspin

To connect using ChucK via OSC:

    OscOut oout;

    // fibonacci port number
    ("chuckServer.local", 11235) => oout.dest;

Then to send to a robot using its OSC address, addresses should be kept the same as the robot names (MDarimBot, "/MDarimBot"):

    oout.start("/Address")
    oout.add(note)
    oout.add(velocity)
    oout.send();

To add a new robot to the server, make a new ChucK class, be sure to include the ID of **every** robot inside the class so no confusion arises:

    public class NewBot extends SerialBot {
        // OldBot is 0
        // NewBot is 1

        1 => int ID;
        "/NewBot" => string address;
        IDCheck(ID, address) => int check;
        if (check >= 0) {
            spork ~ oscrec(check, address);
        }
    }

To change the scale of a robot, make an integer array of the desired scale in the class, and call the function "rescale" using that array. This allows for MIDI notes to be interpreted correctly no matter the scale of a robot. 

    public class WholeToneBot extends SerialBot {
        // OldBot is 0
        // NewBot is 1
        // WholeToneBot is 2 

        // create scale here, whole notes starting at C (MIDI scale)
        [60, 62, 64, 66, 68, 70, 72] @=> int scale;

        // call rescale here
        rescale(scale);

        2 => int ID;
        "/WholeToneBot" => string address;
        IDCheck(ID, address) => int check;
        if (check >= 0) {
            spork ~ oscrec(check, address);
        }
    }

If there are any issues connecting or adding a robot to the server, email ericheep@alum.calarts.edu
