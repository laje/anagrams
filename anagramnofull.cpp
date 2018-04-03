#include <iostream>
#include <fstream>

#include <string>
#include <cstring>
#include <vector>

#include <math.h>

using namespace std;

int main (int argc, char **arg)
{
	if (argc < 2)
	{
		cout << "Usage: anagram <word>\n";
		return 0;	
	}	
	cout << "Input Word: " << arg[1] << "\n";

	vector<int> prime;
	for(int j=2;j<=101;++j)
	{
		int i=2;
		for(;i<=j-1;i++)
		{
			if(j%i == 0)
				break;
		}

		if(i==j)
			prime.push_back(j);
	}

	cout << "(" <<  prime.size() << ") Anagram chars registered.\n";
	
	int inword[strlen(arg[1])];
	int inwordh = 1;
	
	for (int i = 0; i < strlen(arg[1]); i++)
	{
		inword[i] = prime[arg[1][i] - 97];
		inwordh *= inword[i];
		cout << "->" << inwordh;
	}
	
	cout << "\n";

	ifstream file("/usr/share/dict/words");
	if (file.good())
	{
		cout << "Good Dictionary.\n";
	} else
	{
		cout << "Bad Dictionary.\n";
	}
	
	cout << "----[Begin Results]----\n";
	
	int size = 0;
	string stdword;
	while (file >> stdword)
	{
		char *word = &stdword[0u];
		vector<char> dictword;
		int dictwordh = 1;
		for (int i = 0; i < strlen(word); i++)
		{
			if (word[i] < 97)
			{
				word[i] -= 32;
			}
			
			//Was going to implement a contains() to skip processing anything which didn't contain a letter which was present in the inword.
			if(true)
			{
				dictword.push_back(prime[word[i] - 97]);
				dictwordh *= dictword[i];
				if (dictwordh == inwordh)
				{
					cout << word << "\n";
					size++;
				}	
			}
		}
		//dict.push_back(word);
	}
	
	cout << "-----[End Results]-----\n" << "Dictionary Size: [" <<  size <<
		"]\n";

	return 0;
}
	
