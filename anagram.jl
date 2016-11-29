#ANAGRAM DESCRAMBLER
#KINDA GOOD FOR THAT IOS MINIGAME

#BY DAN LYNCH
#LAST MODIFIED 28 NOVEMBER 2016

#Define some variables for use in the program.
letters = [];
goodWords = [];

#Define keys, check out keyProduct() for info about this.
#Note that these are the first twenty-six prime numbers, one for each letter in the alphabet.
keys = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103,
        107, 109, 113];

#Prompt the user for the word, and make sure to strip it just in case.
#Don't google search "Julia Strip" if you want programming documentation.
#Search for "Julialang Strip" instead.
#I should know better.
println("Enter letters to unscramble")
print("Letters, as if they were one word: ")
word = strip(readline(STDIN))

#Simple function to break the string up into different characters.
#This is because of how Julia handles variables.
function breakLetters(word)

  #Ensure the word is in lowercase. I could've done uppercase, but it doesn't matter.
  word = lowercase(word)

  #Reset letters to [], just in case something really long is left over.
  letters = []

  #Make an array of letters based on the word.
  for i = 1: length(word)

    #Push the letters into the array.
    push!(letters, word[i])
  end

  #Obviously, return the result.
  return letters
end

#I think that this is the best way of solving this problem that I could think of.
#There needs to be a unique identifier for each of the letter sets (abc), (bca), etc.
#Someone's probably got a better solution, but I can't really figure something better out.
#Perhaps a multidimensional array? I probably couldn't implement that very well.
function keyProduct(letters)

  #Initialize the result as one, since 1*whatever will just equal whatever
  #so nothing will be thrown off, but no special cases need to be defined.
  result = 1;

  #Repeat for the about of letters in the array.
  for i = 1:length(letters)

    #Select the letter to be worked with.
    letterKeyChar = letters[i]

    #Convert to ASCII.
    letterKeyNum = Int(letterKeyChar)

    #a, the first of the used ascii characters, is at value 97.
    #Since the other array doesn't being at 97, that needs to be compensated for.
    asciiKeyNum = letterKeyNum - 97

    #But, we need to use +1, since Julia arrays begin at one instead of the classic zero.
    result = result * keys[asciiKeyNum + 1]
  end

  #Obvoisuly, return the result.
  return result
end

#Convert the string into letters, then into a number based on the values.
splitWord = breakLetters(word)
keyWord = keyProduct(splitWord)

#Let the user know the value-based number that was found.
print("String Identifier Found: ")
println(keyWord)

#This assumes you're on a unix system.
#If you're not, just find a dictionary that has one word per line.
dict = open("/usr/share/dict/words")

#Go through each line in the entire dictionary.
for ln in eachline(dict)

  #this line accounts for the \n at the end of each line in the dictionary. Chomp. I love that function.
  dictWord = lowercase(chomp(ln))

  #Fixes an issue with hyphenated words in the dictionary.
  if(contains(dictWord, "-"))
    dictWord = "ErrBadWord"
  end

  #Convert the string into letters, then into a number based on the values.
  splitDictWord = breakLetters(dictWord)
  keyDictWord = keyProduct(splitDictWord)

  #If the keys of the words match, add the word to the array of answers.
  if(keyDictWord == keyWord)
    push!(goodWords, dictWord)
  end
end

#Terminate the file read connection.
close(dict)

#Returns the information that was collected throughout.
print("Possible Matches: ")
println(goodWords)
