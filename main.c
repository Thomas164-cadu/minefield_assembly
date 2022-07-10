#include <stdio.h>
#include <stdlib.h>

void set_a_flag(int matrix[8][8], int i, int j){
  matrix[i][j] = - matrix[i][j];
}

void show_cell(int matrix[8][8], int interface[8][8], int i, int j){
  if (matrix[i][j] == 0){
    //should show neighbors
    //we have to implement the method that generates the positions
    //maybe this should be done on another method, like recalculate interface after openning bomb
    interface[i][j-1] = matrix[i][j-1];
  }
  if (matrix[i][j] < 0){
    return;
  }
  interface[i][j] = matrix[i][j];
}

void show_interface(int interface[8][8], int size){
   for (int i = 0; i< size; i++){
    printf("%d", i);
  }
  printf("\n");

  for (int i = 0; i < size; i++) {
    printf("%d", i);
    for (int j = 0; j < size; j++) {
      if (interface[i][j] == 9){
        printf("#");
        
      } else if (interface[i][j] < 0){
        printf("F");
        
      } else if (interface[i][j] >= 0){
        printf("%d", interface[i][j]);
      }
    }
    printf("\n");
  }
}

int main(void) {
  int size, option;

  printf("Escolha o tamanho do tabuleiro:\n");
  printf("(1) 8x8; (2) 10x10; (3) 12x12.\n");
  scanf("%d", &option);

  switch (option) {
  case 1:
    size = 8;
    break;
  case 2:
    size = 10;
    break;
  case 3:
    size = 12;
    break;
  }

  int interface[size][size];

  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      interface[i][j] = 9;
    }
  }

  int matrix[size][size];

  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      matrix[i][j] = 0;
    }
  }

  show_interface(interface, size);

  matrix[0][0] = 0;
  //show_cell(matrix, interface, 0,0);
  matrix[1][1] = 1;
  //show_cell(matrix, interface, 1,1);
  set_a_flag(interface, 1,1);
  matrix[2][2] = 0;
  show_cell(matrix, interface, 2,2);
  matrix[3][3] = 3;
  //show_cell(matrix, interface, 3,3);
  set_a_flag(interface, 3,3);
  matrix[4][4] = 0;
  show_cell(matrix, interface, 4,4);

  show_interface(interface, size);

  return 0;
}
