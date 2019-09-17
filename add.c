const int SIZE = 10;
int mem[SIZE] = {2, 5, 6, 7, 8, 0, 4, 2, -1, 2};

// extern void callback(int);

int add(int a, int b) {
    return a + b;
}

int* get_mem() {
    return mem;
}

int sum() {
    int result = 0;

    for (int* ptr = mem, *end = mem + SIZE; ptr < end; ptr++) {
        result += *ptr;
    }

    return result;
}

// void call_js() {
//     callback(4);
// }
