# ComputationalArt2
An application for discreate and procedural art and simulation. **Things marked (WIP) do not work yet.**

## Application
The UI can handle runtime theme and scale changes.

### Start
To start an instance of the app execute the following in a workspace:
```smalltalk
CAWindow create.
```

### Use
Everything lives in a single window. All buttons have tooltips.

![image](https://github.com/hpi-swa-teaching/ComputationalArt2/assets/114243111/d6fc571c-f9d6-41c4-af20-824bdd629041)

#### Project Menu
+ Import: Imports a Project.
+ Export: Exports a Project.
+ Import Image: Imports an image from as a new canvas.
+ Export Image: Exports the current canvas to an image.
+ Sim Step: Shows the simulation step that is currently visable.
+ Initialization Script: The button to get to the initialization script that is run as sim step 0.
+ Canvas Script: The button to get to the canvas script that will be run per simulation step.

#### Viewport
The Viewport interacts with the selected tool. The user can interact with the canvas through the tools and the viewport.

#### Canvas
The canvas displays the current state. It can be manipulated by using the tools from the toolbar or by scripting. It stores 8 bpc RGB data.

#### Toolbar
There is always exactly one selected tool in the toolbar. A tool can be selected at any time by clicking on the tool icon. When changing the the tool, the tool context menu will disply the options relevant for the selected tool.

#### Tools
The tools work with the left mouse button.
+ **Move**: Drag to move the view; scroll to zoom in and out.
+ **Pen**: Draws dots in the primary color as the mouse is draged over the canvas. (Stroke Width is WIP).
+ **Line**: Draws a line from the point where the mouse is presses to the current mouse location. The current primary color is used for the color of the stroke. The line is applied to the canvas as soon as the user releases the mouse button.
+ **Rectangle**: Draw a rectangle from the point where the mouse is pressed to the current mouse location. Stroking and filling can be enabled and dissabled. Stroking will use the primary color, filling the secondary. Stroke width is WIP. The rectangle is applied to the canvas as soon as the user releases the mouse button.
+ **Circle**: Draw a circle from the point where the mouse is pressed to the current mouse location. Stroking and filling can be enabled and dissabled. Stroking will use the primary color, filling the secondary. Stroke width is WIP. The rectangle is applied to the canvas as soon as the user releases the mouse button.
+ **Flood Fill**: Replaces the color patch clicked on with primary color. All pixels in a color patch have the same color and are connected.
+ **Reset Canvas**: Sets every pixel to the primary color.

#### Color
By clicking on the primary/secondary color button, a color picker window will appear. The user can choose a color by providing it explicitly in RGB or HSV, both in (interger range 0 to 255).

![image](https://github.com/hpi-swa-teaching/ComputationalArt2/assets/114243111/efb3da62-d838-47e1-aa89-d672d8c8b6a8)

We use a custom `CARGB` color class that uses RGB 0 to 255 integer values. This is to ensure color values in the image are exacly the ones specified in the color and the falues returend from the image are exact integers. The class has the following messages:
```smalltalk
CARGB black.   "(0, 0, 0)"
CARGB red.     "(255, 0, 0)"
CARGB green.   "(0, 255, 0)"
CARGB blue.    "(0, 0, 255)"
CARGB yellow.  "(255, 255, 0)"
CARGB cyan.    "(0, 255, 255)"
CARGB magenta. "(255, 0, 255)"
CARGB white.   "(255, 255, 255)"
CARGB random.  "random RGB value"
CARGB r: red g: green b: blue. "shorthand constructor."
```
The instance has the following:
```smalltalk
c := CARGB black.
c red: 0.    "Setter for red.    Clamps to [0, 255] and rounds."
c green: 0.  "Setter for green.  Clamps to [0, 255] and rounds."
c blue: 0.   "Setter for blue.   Clamps to [0, 255] and rounds."
c red.       "Getter for red in range [0, 255]."
c green.     "Getter for green in range [0, 255]."
c blue.      "Getter for blue in range [0, 255]."
```
## Scripting
The simulation can be started using the _Start_ button. The user can pause the simulation by pressing the _Pause_ button. The user can revert to the state before the execution by pressing the _Reset_ button. This is independet of the undo/redo chain. If the simulation is currently not running, the user can press the _Step_ button to only make a single step in the simulation.
### The Canvas API
The user operates on the `canvas` object, which is know to the script runtime. The canvas exposes methods to draw and get pixel values. Colors are always [0, 255] integers and points are pixel coordinates. The canvas API is the same for the initialization and canvas script. 
```smalltalk
canvas fillR:r G: g B: b.                     "Set the fill color to rgb [0, 255] integer."
canvas fillRGB: aCARGB.                       "Set the fill color the aCARGB."
canvas fillRGB.                               "Get the fill color as CARGB."
canvas fillRect: startPoint to: endPoint.
canvas fillRect: startPoint extent: sizePoint.
canvas fillCircle: aPoint radius: aNumber.
canvas strokeWidth: aNumber.                   "Set the stroke width to aNumber integer. (WIP)"
canvas strokeWidth.                            "Get the stoke width integer".
canvas strokeR:r G: g B: b.                    "Set the stroke color to rgb [0, 255] integer."
canvas strokeRGB: aCARGB.                      "Set the stroke color the aCARGB."
canvas strokeRGB.                              "Get the stroke color as CARGB."
canvas strokeLine: startPoint to: endPoint.
canvas strokeRect: startPoint to: endPoint.
canvas strokeRect: startPoint extent: sizePoint.
canvas strokeCircle: aPoint radius: aNumber.
canvas fold: a2DArray at: aPoint.              "Fold aPoint by the given 2D array kernel."
canvas fold: a2DArray.                         "Fold the canvas by the given 2D array kernel."
canvas width.                                  "The width of the canvas in pixels."
canvas height.                                 "The height of the canvas in pixels."
canvas rgbAt: aPoint put: aCARGB.              "Set the color at the pixel aPoint to aCARGB."
canvas rgbAt: aPoint.                          "Get the color at the pixel aPoint as CARGB."
canvas rgbBackAt: aPoint.                      "Get the color at the pixel of the backbuffer. The backbuffer is the canvas before the script execution."
canvas pixelsDo: [:x :y | "Code here."]        "Executes the block for all pixel from left to right and top to bottom."
```
### Examples
Here are some examples on the canvas script.

#### Colorful Circles
Initialization Script:
```smalltalk
canvas fillRGB: CARGB black.
canvas fillRect: 0@0 to: (canvas width)@(canvas height).
```

Canvas Script:
```smalltalk
| target |
target := CARGB r: 0 g: 0 b: 0.
canvas pixelsDo: [:x :y | |rgb|
	rgb := canvas rgbAt: (x@y).
	canvas strokeRGB: CARGB random.
	rgb = target ifTrue: [
		canvas strokeCircle: (x@y) radius: 6.].].
```

#### Coloful Conway's Game of Life
Canvas Script:
```smalltalk
canvas pixelsDo: [ :x :y | |sum living thisColor|
	sum := 0.
	-1 to: 1 do: [ :yOff |
		-1 to: 1 do: [ :xOff |
			((xOff = 0) and: (yOff = 0)) ifFalse: [
				(canvas rgbBackAt: (x@y) + (xOff@yOff)) red > 0 ifTrue:[
					sum := sum + 1.
					].
				].
			].
		].
	thisColor := canvas rgbBackAt: (x@y).
	living := thisColor red > 0 or: thisColor green > 0 or: thisColor blue > 0.
	living ifTrue: [
		(sum <= 1 or: sum >= 4) ifTrue: [
			canvas rgbAt: (x@y) put: CARGB black.
			].
		]
	ifFalse: [
		sum = 3 ifTrue: [
			canvas fold: {
			{1.0/sum. 1.0/sum. 1.0/sum.}.
			{1.0/sum. 1.0/sum. 1.0/sum.}.
			{1.0/sum. 1.0/sum. 1.0/sum.}.} at: (x@y).
			].
		].
	].

canvas fillRGB: CARGB random.
canvas fillRect: (100 random)@(100 random) extent: 3@3.
```
