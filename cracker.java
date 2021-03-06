import java.io.*; 
import java.util.*; 

public class cracker
{
	private final static int moves[][] =
		{
			{0,1,3},{3,1,0},
			{0,2,5},{5,2,0},
			{1,3,6},{6,3,1},
			{1,4,8},{8,4,1},
			{2,4,7},{7,4,2},
			{2,5,9},{9,5,2},
			{3,6,10},{10,6,3},
			{3,7,12},{12,7,3},
			{4,7,11},{11,7,4},
			{4,8,13},{13,8,4},
			{5,8,12},{12,8,5},
			{5,9,14},{14,9,5},
			{3,4,5},{5,4,3},
			{6,7,8},{8,7,6},
			{7,8,9},{9,8,7},
			{10,11,12},{12,11,10},
			{11,12,13},{13,12,11},
			{12,13,14},{14,13,12}
		};
	
	private static ArrayList<int[]> FinalMoveList = new ArrayList<int[]>(13);
	
	public static int move(ArrayList<Integer> Occupied, ArrayList<Integer> Free, ArrayList<int[]> moveList, int Left)
	{
		if(Left==1)
		{
			FinalMoveList = new ArrayList<int[]>(moveList);
			return 1;
		}
		
		for (int j=0; j<36;j++)
		{
			
			if(Occupied.contains(moves[j][0])&&Occupied.contains(moves[j][1])&&Free.contains(moves[j][2]))
			{
				
				ArrayList<Integer> tempOccu= new ArrayList<Integer>(Occupied);
				ArrayList<Integer> tempFree= new ArrayList<Integer>(Free);
				ArrayList<int[]> tempMoveList = new ArrayList<int[]>(moveList);
				int tempLeft=Left;
				
					
				tempFree.add(moves[j][0]);
				tempFree.add(moves[j][1]);
				tempFree.remove(Integer.valueOf(moves[j][2]));
						
				tempOccu.remove(Integer.valueOf(moves[j][0]));
				tempOccu.remove(Integer.valueOf(moves[j][1]));
				tempOccu.add(moves[j][2]);
				
				tempLeft--;
				tempMoveList.add(moves[j]);
				
				
				if(move(tempOccu, tempFree, tempMoveList, tempLeft)==1)
				{
					return 1;
				}
			}
		} 
		

		return 0;
	}
	
	public static void printStatus(char[] board)
	{
		System.out.println("    "+board[0]+"    ");
		System.out.println("   "+board[1]+" "+board[2]+"   ");
		System.out.println("  "+board[3]+" "+board[4]+" "+board[5]+"  ");
		System.out.println(" "+board[6]+" "+board[7]+" "+board[8]+" "+board[9]+" ");
		System.out.println(board[10]+" "+board[11]+" "+board[12]+" "+board[13]+" "+board[14]+"\n");
	}
	
	public static void main(String[] args)
	{
		char board[] = new char[15];
		
		ArrayList<Integer> Free = new ArrayList<Integer>(15);
		ArrayList<Integer> Occupied = new ArrayList<Integer>(15);
		
		
		
		for (int i=0; i<5; i++)
		{
			System.out.println("=== "+i+" ===\n");
			
			//Initialize board
			for (int j=0; j<15; j++)
			{
				Occupied.add(j);
				board[j]='x';
			}
			//Initialize empty spot
			board[i]='.';
			Occupied.remove(Integer.valueOf(i));
			Free.add(i);
			printStatus(board); //print initial status
			
			
			
			
			//find solution
			if(move(Occupied, Free, FinalMoveList, 14)==1)
			{
				for(int j=0;j<13;j++)
				{
					
					board[FinalMoveList.get(j)[0]]='.';
					board[FinalMoveList.get(j)[1]]='.';
					board[FinalMoveList.get(j)[2]]='x';
					printStatus(board);
				}
				Free.clear();
				Occupied.clear();
				FinalMoveList.clear();
			}
			else
			{
				System.out.println("Error");
				return;
			}
				
			


			
				
			

		
			System.out.println();
			
		}
		
	}
}