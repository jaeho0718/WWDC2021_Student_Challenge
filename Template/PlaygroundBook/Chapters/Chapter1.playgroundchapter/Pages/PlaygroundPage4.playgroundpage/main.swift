//#-hidden-code
playSound(true)
GameInit()
checkUserInput("AddBlock",pass_message:"",fail_hint:["Use AddBlock(to:,delay:)!!"],nextPageName:"Final")
//#-end-hidden-code
/*:
 # **If-else if conditional**
 
 **Goal : Use conditional statements to determine score**
 
 In previous step, we made score comment using if condition
 Additionaly, We use If-else If statement.
    
    if (condition1){
        statement1()
        //If condition1 is true, statement1() in brace run
    }else if (condition2){
        statement2()
        //If condition2 is false,statement2() in brace run
    }else{
        //statement3()
        //If condition1 and condition3 is false, command in brace run
    }
 
 */
//make block!!
//#-editable-code make Block!
//#-end-editable-code
setEndingScene({ score in
    // setEndingScene function deliver score value to you.
    // So you can check score using score value
    // When you use set score label,you should put return in front of setScoreLabel function
    //#-editable-code judge score!
    //#-end-editable-code
})

