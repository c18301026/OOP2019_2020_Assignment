# Music Visualiser Project

Name: Rianlee Pineda

Student Number: C18301026

# Description of the assignment
The goal of this Object-Oriented Programming assignment was to create "something beautiful to enjoy while listening to music". This Processing program creates visuals on the spot based on a musical performance by you on a typical QWERTY computer keyboard which is laid out to mimic the tuning of a violoncello (or cello).

# Instructions
When you start the program, the first thing you see is some white text on a black background. The white text simply shows help information. You may hide this text by pressing the down key. The keyboard that triggers the visuals is isomorphic (cellos are tuned in all-fifths). In other words, any combination of musical intervals has the same shape on the keyboard wherever it occurs. This makes scales and chords intuitive to play and facilitates transposition.

This program displays shapes and plays MIDI notes in response to keys pressed on the keyboard. In the program, a typical QWERTY keyboard has been laid out to mimic the fingerboard of a cello or a mandocello (a plucked stringed instrument similar to a guitar, but tuned like a cello). The tuning from low to high is C2, G2, D3 and A3. The 'Z' key can be thought of as the lowest open string on a cello, i.e., C. The adjacent key, i.e., 'X', is a semitone higher, i.e., C#, and the next key after, i.e., 'C', is a semitone higher again, i.e., D. The 'A' key can be seen as a cello's open G, 'Q' as the open D and '1' as the open A.

The timbre of the notes and the shapes that appear on the screen depend on what "instrument" you are playing. You have two instrument choices: cello and mandocello. The default setting is set on cello. You can pick this instrument by pressing the left key. When the cello is picked, the MIDI notes that play will resemble that of a bowed string instrument. The shapes that appear are red bars that elongate horizontally but shrink vertically. The other instrument is the mandocello. You can pick this instrument by pressing the right key. When the mandocello is picked, the MIDI notes that play will resemble that of a plucked string instrument. The shapes that appear are blue, unfilled circles that grow in diameter so that they resemble ripples.

# How it works
To run the program, you will need to have the Processing IDE installed. Once you open the .pde file, you can click on the run button or press Ctrl+R to run the program. Alternatively, you can simply run the .exe file found in the zipped folder.

Since this program utilises MIDI, the javax.sound.midi package had to be imported. This lets the program get a synthesizer and use methods such as noteOn() and noteOff() which are essential to getting the computer to output sounds. The default MIDI synthesizer sound was a piano but this was changed to a cello sound through the MidiChannel method programChange(42). 42 represents the cello sound while 25 represents the mandocello (guitar) sound. The method midiNoteNo() returns an integer that represents a MIDI note value, e.g., 36 = C, 37 = C#, 38 = D. A switch statement was used to check for the key pressed by the user. The keys were chosen to represent their equivalent position on a fingerboard/fretboard of a cello/mandocello as explained earlier.

The help text was done through Processing's text() method. It was placed inside an if statement in the draw() method. A Boolean variable, helpOn, is set to true when the program starts. This variable is in the if statement so that it is displayed everytime you start the program. To hide the help information, i.e., to set helpOn to false, you press the down key.

To make the keys produce a MIDI note, the noteOn() method was used and was placed inside Processing's keyPressed() method. Since holding down a key is seen as repeatedly pressing the key, a Boolean array pressed[] was used to check if a key was already pressed. All elements in the array are initialised to false since none of the keys have been pressed yet. Once a key is pressed, its corresponding element in the pressed[] array becomes true and so the key is not repeatedly pressed when held down. When you press a key and its corresponding note plays, the note will continue to ring even if you let go of the key. To fix this issue, the noteOff() method was used. This was placed inside Processing's keyReleased method.

In order to display the red bars whenever you play a note, a bar class was needed. Since there will be many bars to represent the different pitches, a Bar array was declared and initialised to hold a number of Bar objects. The Bar class contained the variables x and y to locate the centre of the rectangle to be displayed, and barW and barH to represent the bar's width and height respectedly. There was also a Boolean variable, i.e., on, which represents whenever it should display itself on the screen or not. A bar's position will depend on the note being played, e.g., a low note will give a low Y co-ordinate for a bar while a higher note will give a higher Y co-ordinate for a bar. Processing's map() method was used to achieve this. Whenever a bar's on becomes true, it is allowed to show itself on the screen through its renderB() method and as it does, it animates through its animB() method. While a bar is on, its width will increase while its height will decrease. When it gets to a certain width, it disappears. The draw() method will continuously check for all the bar objects and wait to call the renderB() and animB() methods whenever the user plays a note. To render the ripples, a very similar process was used. Some notable differences between the bars and the ripples are that the ripple classes have diameters rather than widths and heights and that the ripples will change their X co-ordinate in response to a note's pitch rather than its Y co-ordinate.

# What I am most proud of in the assignment
- coding the midiNoteNo() method: a versatile method that was used in many parts of the code
- using the MIDI synthesizer to output sounds: a lot of self-directed learning necessary to understand how MIDI basics works
- mapping the MIDI note numbers so that they affect the positions of the bars and ripples
- getting the bars and ripples to animate
- turning a QWERTY keyboard into a virtual cello

# Markdown Tutorial

This is *emphasis*

This is a bulleted list

- Item
- Item

This is a numbered list

1. Item
1. Item

This is a [hyperlink](http://bryanduggan.org)

# Headings
## Headings
#### Headings
##### Headings

This is code:

```Java
public void render()
{
	ui.noFill();
	ui.stroke(255);
	ui.rect(x, y, width, height);
	ui.textAlign(PApplet.CENTER, PApplet.CENTER);
	ui.text(text, x + width * 0.5f, y + height * 0.5f);
}
```

So is this without specifying the language:

```
public void render()
{
	ui.noFill();
	ui.stroke(255);
	ui.rect(x, y, width, height);
	ui.textAlign(PApplet.CENTER, PApplet.CENTER);
	ui.text(text, x + width * 0.5f, y + height * 0.5f);
}
```

This is an image using a relative URL:

![An image](images/p8.png)

This is an image using an absolute URL:

![A different image](https://bryanduggandotorg.files.wordpress.com/2019/02/infinite-forms-00045.png?w=595&h=&zoom=2)

This is a youtube video:

[![YouTube](http://img.youtube.com/vi/J2kHSSFA4NU/0.jpg)](https://www.youtube.com/watch?v=J2kHSSFA4NU)

This is a table:

| Heading 1 | Heading 2 |
|-----------|-----------|
|Some stuff | Some more stuff in this column |
|Some stuff | Some more stuff in this column |
|Some stuff | Some more stuff in this column |
|Some stuff | Some more stuff in this column |

