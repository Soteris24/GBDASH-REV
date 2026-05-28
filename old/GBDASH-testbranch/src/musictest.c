#include <gb/gb.h>
#include <gb/cgb.h>
#include <stdint.h>
#include <stdio.h>
#include "menuscreen.h"
#include "gb-madness.h"
#include "register.h"
#include <gbdk/platform.h>

static void musictest_setup(void) {
    stopall();             // Stop all currently playing music/sfx
    DISPLAY_ON;            // Make sure the screen is on
    SHOW_BKG;              // Enable background
    HIDE_SPRITES;          // No sprites needed for this screen
    cls();                 // Clear background/text (prevents tile overlap)

    // Print title text
    printf("=== MUSIC TEST ===\n\n");
    printf("Press DOWN to return\n");

    // Optionally play test music
    play(2);               // Replace '2' with your test song ID
}

void domusictest(void) {
    fade(musictest_setup); // Fade in with setup

    while (1) {
        uint8_t joy = joypad();

        if (joy & J_DOWN) {
            stopall();     // Stop music before returning
            fade(domenu);  // Fade out and return to menu
            break;
        }

        wait_vbl_done();
    }
}
