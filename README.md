# Pascal Life

_Version 1.0.0+20240723  ([Version Release Notes](#ReleaseNotes))_ 

**Pascal Life** is an open source implementation of Conway's **[Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)** cellular automata simulation.

## About the Software

The software is a self-contained executable program, written in **[Free Pascal](https://www.freepascal.org/)**, that runs on Microsoft Windows or Ubuntu Linux (and presumably other Linux distributions).
(No separate run-time environment is required to run the program.)
The **[Lazarus Integrated Development Environment](https://www.lazarus-ide.org/)** was used to develop the program.
(Both Free Pascal and the Lazarus IDE are free open-source software products.) 

## Downloading and Running the Program

### Microsoft Windows

You can run the Pascal Life program on Microsoft Windows as follows:

- Download the **PascalLife.exe** binary executable file from the **bin** sub-folder from this GitHub.com page.

- To uninstall the program, simply delete the **PascalLife.exe** file.

### Ubuntu Linux

You can run the Astronomical Simulation program on Ubuntu Linux (and presumably other Linux distributions) as follows:

- Download the **PascalLife** binary executable file (with no file extension) from the **bin** sub-folder from this GitHub.com page.

- Ensure the **PascalLife** file has the executable permission.  From a Files window, right-click the file, select Properties, and use the Permissions tab to enable the Execute permission.  To do this in a Terminal window, use the following command:
  
    chmod +x AstroSim

- To uninstall the program, simply delete the **PascalLife** binary executable file.

### Running the Program

Double-click the downloaded copy of **PascalLife.exe** (on Windows) or **PascalLife** (on Linux) to start the simulation.

When the program starts it displays the **Pascal Life** form.

Here is an image of the Pascal Life form paused during a running simulation.

![PascalLife Form](img/PascalLife-Form.png?raw=true "PascalLife Form")

The Form contains these elements:

- **Display Grid** diplays the grid of automata cells, with _dead_ cells in black, and _live_ cells in lime green.
- **Grid** control area. Enter the desired size of the **Display Grid** in number of cells by typing values into the first (width) and second (height) text boxes. Click the **OK** button to clear and resize the **Display Grid**.
- **Draw** control area. The drop-down control contains a list of possible shapes to add to the **Display Grid** (see below). Click the **Random** check-box to generate a random pattern of _live_ cells to the **Display Grid**. Click the **Clear** button to clear the grid to all _dead_ cells.
- **Start** button starts the simulation; the button becomes a **Stop** button that resets the simulation and clears the **Display Grid**.
- **Generation** control area. Click the **Next** button to single step the simulation by a single generation. Move the **Slow/Fast** slider to adjust the speed of the simulation. Click the **Pause** button to pause a running simulation; the button becomes a **Run** button that will resume the simulation.


### Adding new Shapes to the Display Grid

The drop-down control lists a set of possible shapes that can be added to the simulation by clicking the mouse pointer within the **Display Grid**.

- **Cell** : Click anywhere in the **Display Grid** to create a new _live_ cell, or to turn an existing _live_ cell into a _dead_ cell. Drag the mouse pointer within the **Display Grid** with the left button pressed to create a series of _live_ cells.
- **Glider**: This small shape migrates diagonally through the **Display Grid**.
- **f-Pentomino**: This small shape evolves into complex dynamic pattern.
- **Spaceship** comes in three sizes: **lightweight**, **middleweight**, and **heavyweight**. Each version migrates horizontally across the **Display Grid**.
- **Gosper Gun**: This complex pattern evolves into a structure that emits a steady stream of migrating **Glider** shapes.
 

## Source code compilation notes

Download the **Lazarus IDE**, including **Free Pascal**, from  here:

- **<https://www.lazarus-ide.org/index.php?page=downloads>**

After installing the **Lazarus IDE**, clone this GitHub repository to your local disk.
Then double-click on the **src\PascalLife.lpr** project file to open it in **Lazarus**. 

_**Note:**_ Using the debugger in the **Lazarus IDE** on Windows 10 _**might**_ require the following configuration adjustment:

- **[Lazarus - Windows - Debugger crashing on OpenDialog](https://www.tweaking4all.com/forum/delphi-lazarus-free-pascal/lazarus-windows-debugger-crashing-on-opendialog/)**

When **Lazarus** includes debugging information the executable file is relatively large.
When ready to create a release executable, the file size can be significantly reduced by selecting the menu item **Project | Project Options ...** and navigating to the **Compile Options | Debugging** tab in the resulting dialog window.
Clear the check-mark from the **Generate info for the debugger** option and then click the **OK** button.
Then rebuild the executable using the **Run | Build** menu item (or using the shortcut key-stroke _**Shift-F9**_).

<a name="ReleaseNotes"></a>

## Release Notes

### Version 1.0.0

This is the initial version of the software.

Adapted from **<https://github.com/sto3psl/game-of-live>** by Fabian Gündel.
