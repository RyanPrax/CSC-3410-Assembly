#include <stdio.h>
#include <stdlib.h>

void clear_screen() {
    printf("\033[H\033[J");
    fflush(stdout);
}

int fact(int n) {

    return n;
}

int program_selection() {
    printf("Menu:\n");
    printf("1) Add two numbers together\n");
    printf("2) Test if a string is a palindrome (C -> ASM)\n");
    printf("3) Print the factorial of a number\n");
    printf("4) Test if a string is a palindrome (ASM -> C)\n");
    printf("5) Exit\n");
    int selection;
    printf("Enter choice: ");
    if (scanf("%d", &selection) != 1) {
        int c;
        // clear the rest of the line so leftover input doesn't break the next read
        while ((c = getchar()) != '\n' && c != EOF) { }
        clear_screen();
        printf("ERROR: Please enter a number\n");
        return -1;
    }
    // also clear any extra characters on the same line after a successful read
    int ch;
    while ((ch = getchar()) != '\n' && ch != EOF) { }
    if (selection < 1 || selection > 5) {
        clear_screen();
        printf("ERROR: Please input a valid number (1-5)\n");
        return -1;
    }
    return selection;

}

int main() {
    int selection = -1;
    while (selection == -1) {
        selection = program_selection();
    }
    if (selection == 5) {
        return 0;
    }

    return 0;
}