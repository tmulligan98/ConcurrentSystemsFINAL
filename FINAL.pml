/* Based on fa1.pml  Copyright 2007 by Moti Ben-Ari under the GNU GPL */

#define LEN 5

inline Input(n) {
  if
  :: i[n] = 'a'
  :: i[n] = 'b'
  :: i[n] = 'c'
  :: i[n] = 'd'
  fi
}

//Number to subtract from LEN is chosen non-deterministically
inline seq_length(){
  if
  :: j = 1;
  :: j = 2;
  :: j = 3;
  :: j = 4;
  :: j = 5;
  fi
}



active proctype FA() {
  int j;
  seq_length(); //Will return a sequence length between 1 and 5. This will be j!
  byte h;
  byte i[j];
  //Input(0); Input(1); Input(2); Input(3); i[4] = '.';

  int k = j - 2; //Dummy variable for the loop below!

  do
   :: (k >= 0) -> Input(k); k--;
   :: (k < 0) -> break;
  od
  
  i[j-1] = '.';

q0: if
    :: i[h] == 'a'  -> printf("@TRANS q0 a q1\n"); h++; goto q1;
    :: i[h] == 'b'  -> printf("@TRANS q0 b q3\n"); h++; goto q3;
    :: i[h] == 'a'  -> printf("@TRANS q0 a q2\n"); h++; goto q2;
    fi;
q1: if
    :: i[h] == 'd'  -> printf("@TRANS q1 d q3\n"); h++; goto q3;
    fi;
q2: if
    :: i[h] == 'b'  -> printf("@TRANS q2 b q4\n"); h++; goto q4;
    fi;
q3: if
    :: i[h] == 'c'  -> printf("@TRANS q3 c q2\n"); h++; goto q2;
    :: i[h] == 'c'  -> printf("@TRANS q3 c q6\n"); h++; goto q6;
    :: i[h] == 'd'  -> printf("@TRANS q3 d q5\n"); h++; goto q5;
    :: i[h] == '.'  -> printf("@TRANS q3 . accept\n"); goto accept
    fi;
q4: if
    :: i[h] == 'c'  -> printf("@TRANS q4 c q6\n"); h++; goto q6;
    :: i[h] == 'b'  -> printf("@TRANS q4 b q5\n"); h++; goto q5;
    :: i[h] == 'a'  -> printf("@TRANS q4 a q2\n"); h++; goto q2;
    fi;
q5: if
    :: i[h] == 'a'  -> printf("@TRANS q5 a q4\n"); h++; goto q4;
    :: i[h] == 'b'  -> printf("@TRANS q5 b q1\n"); h++; goto q1;
    fi;
q6: if
    :: i[h] == '.'  -> printf("@TRANS q6 . accept\n"); goto accept
    fi;
accept:
    printf("Accepted!\n");
	assert(false)
}

active proctype Watchdog() {
end:	timeout -> printf("Rejected ...\n")
}
