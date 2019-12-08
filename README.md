# icebreaker_devbrd
Play and learn with the iCEBreaker development board featuring a Lattice iCE40 UP5K FPGA and a completely open-source toolchain..

## Build and run the project
Connect your icebreaker board to your machine via USB. Then open a shell in the repo root directory and run  

> $> make  
> $> make prog  

The read LED on the iCEBreaker board should be blinking after programming completes. Pressing the user button close the USB connector should increase the blink frequency.

## References
[iCEBreaker Hardware Info](https://github.com/icebreaker-fpga/icebreaker)  
[iCEBreaker Example Designs](https://github.com/icebreaker-fpga/icebreaker-examples)  
[iCEBreaker Crowdsupply Campaign](https://www.crowdsupply.com/1bitsquared/icebreaker-fpga)  
[Lattice iCE40 Device Family Datasheet](http://www.latticesemi.com/-/media/LatticeSemi/Documents/DataSheets/iCE/iCE40-UltraPlus-Family-Data-Sheet.ashx)  
[Lattice iCE40 Application Notes](http://www.latticesemi.com/search.aspx?&sk=Default&s=%7e_d0!2!1!!1!7!0!1!!2!!!0!1!3!2!4!_d2!_d6!fil!iCE40+UltraPlus!iCE40+UltraPlus+App+Notes!FrurxrsrwrsrzqEqypvspHpGpqBqypxpvspwpxpApvspwpwpqCqypxpvspwpxpDpvspwpwpqqrzqqqrtr!fvf%7c%40productitemnames!_d0!_d8!fvf%7c%40documenttype!Application+Note!_d1!!zqbqtGpypxpvppupvpupxpupwppwpppupvpHpKpJpIpFpCpBpApDpyppEpqzprpqsq!&sg=3202d857-8037-4fdf-be46-68b54b91e390)  
