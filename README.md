# HitchExamples

App responsiveness -  we can check this either in XCode Organiser or Instruments

A hitch is any time a frame appears on screen later than expected.

This might happen if user scrolls, if user touches a button and expecting an animation or during transition. Hitches can cause jumps and breaks that connection. It is caused when the frame is rendered late on time.

iPhone or iPad is having 60Hz refresh rate. Frame duration is 16.67 ms(1/60). When user starts interacting with the app, the new corresponding frames need to be rendered. This cycle of rendering new frames on to screen is “Render Loop”.

Refresh rate - 60Hz - iPhone and iPad
            120 Hz - iPad Pro
Frame duration - 16.67 ms - iPhone and iPad
                8.33 ms - iPad Pro

This Render Loop comprises of 5 stages.
1. EVENT
2. COMMIT
3. RENDER PERPARE
4. RENDER EXECUTE
5. DISPLAY

Hitches can occur in two stages of Render Loop: COMMIT HITCH, RENDER HITCH

Commit Hitch
When commit phase takes extra time to prepare changes then Hitch occurred is Commit Hitch. Developer Tool Instruments from Xcode12 includes Animation Hitches measure. This also includes Time Profiler to detect and locate commit hitches.

Render Hitch
When execution of pipeline takes extra time then Hitch occurred is Render Hitch. Same Instruments can be used to detect the Render Hitches labeled as “Expensive Gpu” hitch type. To fix them Xcode View Debugger is to be used. Xcode introduces performance optimizations to suggest fixes for render hitches. Those can be viewed by enabling Show Performance Optimizations from Editor menu.

Offscreen Pass- Anytime the GPU must render a layer by first rendering it somewhere else, then copying it over. 
Example: to draw a shadow, it has to know the shape first, so it will go to somewhere, where it will draw the shadow according to the shape on top layer and then it copies to the layer where shadow has to be drawn. After drawing the shadow, then the top layer will be drawed(actual shapes). This can sometimes cause a hitch because of waiting time. Solution: Include shadow path
