Assumes a unix system with:
 - bash
 - alsa

Execute the main script from within it's own folder
    ./sound_handler.sh

Reads single letters fed externally to determine sound state.  See sound_handler.h for details

# Interfacing with Arduino
Serial comms pins are UART_RX and UART_TX, baud is 115200.  Don't forget to hook up a ground wire too.

On Raspberry pi B+ (what we're using) this pinout diagram is valid when the board is rotated so that the GPIO pins are on the side opposite to you (top) and the HDMI is closer to you (bottom).
![Raspberry pi B+ pinout](https://raw.github.com/createunsw/pacmanSoundSlave/master/model_B_pins.png)

Suggestible code:
```
Serial.begin(115200);
// Wait for raspi to boot and request username
// It will give a colon once it's ready
char in;
do char in = Serial.read(); while ( in != ':' ); // Yes this is valid C
delay(50);
// Login as user 'tc'
Serial.print("tc\n");
delay(50);
// Send commands
/*
	Serial.print("1"); // to start a game and wakka forever
	Serial.print("2"); // change the next wakka to a 'eat yellow' sound.
	                   // this need to be repeated for every wakka
							 // (all this behaviour can be changed if need be)
	Serial.print("3"); // kill loop, run intermission sound
	Serial.print("4"); // kill loop, run endgame sound
*/
```

The delays are probably not neccesary, but good measure
