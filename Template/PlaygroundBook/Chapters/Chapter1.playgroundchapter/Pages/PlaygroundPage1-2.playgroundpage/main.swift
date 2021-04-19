//#-hidden-code
playSound(false)
showScore(false)
GameInit()
checkUserInput("AddBlock",pass_message:"You made succesfuly own function.",fail_hint:["Use AddBlock(to:,delay:)!!"],nextPageName:"For loop")
//#-end-hidden-code
/*:
 # **Function**
 
 **Goal : Place blocks using functions.**
 
 In previous Step,we used repeativly AddBlock(to:) that show the block on Tap1,Tap5,Tap9.
 But If you want to show 9times repeativly the block on Tap1,Tap5,Tap9, it is very complex.
 So we need function to show the block Tap1,Tap5,Tap9. Functions are modules of code that accomplish a
 specific task.Actually AddBlock(to:) is function that perform work that show block on screen.
 
 
 To define Function, enter a set of command beteween { and }.
 
    func FunctionName ( parameter ){
        //command
    }
 
 What is parameter?
 :: Input of function. When you call function, you should pass through value to parameter
 
 Let's make function that show Block on Tap1,Tap5,Tap9.
 ' delay : Double ' means that function will be recieved Double type value.
 
 The double is a fundamental data type built into the compiler and used to define numeric variables holding numbers with decimal points.
 
 (The AddBlock(to:Int), which was often used earlier, is a function that takes an integer value as a parameter.)
 
 music will be played from page 4.
 */

func /*#-editable-code function Name */FunctionName/*#-end-editable-code*/ (delay : Double) {
    //delay parameter is passed into this function.
    //#-editable-code Add Command!
    //#-end-editable-code
}

//#-editable-code Call function!
//#-end-editable-code
