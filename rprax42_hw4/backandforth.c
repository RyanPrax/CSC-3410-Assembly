#include <stdio.h>
#include <stdlib.h>

void clear_screen() {
    printf("\033[H\033[J");
    fflush(stdout);
}

char* prompt_str(char* message) {
    /** Prompts message followed by a STDIN
     *  of max 1024 Bytes (including \n)
    */
    char* input = malloc(1024);
    if (!input) return NULL;
    printf("%s", message);
    scanf("%1023s", input);
    return input;
}

/** Option 1 */
int addstr(char* a, char* b);

/** Option 2 */
int is_palindromeASM(char* s);

/** Option 3 */
int factstr(char *s);
int fact(int n) {
    if (n <= 1) return 1;
    return n * fact(n-1);
}

/** Option 4 */
void palindrome_check();
int is_palindromeC(char* buf, int len) {
    int i, j;
    for (i = 0, j = len-1; i < len/2; i++, j--) {
        if (buf[i] != buf[j]) return 0;
    }
    return 1;
}

int program_selection() {
    printf("Menu:\n");
    printf("1) Add two numbers together\n");
    printf("2) Test if a string is a palindrome (C -> ASM)\n");
    printf("3) Print the factorial of a number\n");
    printf("4) Test if a string is a palindrome (ASM -> C)\n");
    printf("5) Exit\n");
    printf("Enter choice: ");
    int selection;
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
    switch(selection) {
        case 1:
            char* a = prompt_str("Enter first number: ");
            char* b = prompt_str("Enter second number: ");
            int sum;
            sum = addstr(a, b);
            printf("Sum = %d", sum);
            break;
        case 2:
            char* s = prompt_str("Enter a string: ");
            int result;
            result = is_palindromeASM(s);
            result ? printf("It is a palindrome!") : printf("It is NOT a palindrome!");
            break;
        case 3:
            char* n = prompt_str("Enter a number: ");
            printf("Factorial = %d", factstr(n));
            break;
        case 4:
            palindrome_check();
            break;
        case 5:
            return 0;
    }
    printf("\n");
    return 0;
}